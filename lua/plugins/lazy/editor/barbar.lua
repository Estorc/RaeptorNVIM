return {
  {
    'romgrk/barbar.nvim',
    dependencies = { 'lewis6991/gitsigns.nvim', 'nvim-tree/nvim-web-devicons' },
    config = function()
      local max = math.max
      local rshift = bit.rshift

      local buf_call = vim.api.nvim_buf_call         --- @type function
      local buf_get_option = vim.api.nvim_buf_get_option --- @type function
      local buf_is_valid = vim.api.nvim_buf_is_valid --- @type function
      local buf_set_var = vim.api.nvim_buf_set_var   --- @type function
      local command = vim.api.nvim_command           --- @type function
      local create_augroup = vim.api.nvim_create_augroup --- @type function
      local create_autocmd = vim.api.nvim_create_autocmd --- @type function
      local create_namespace = vim.api.nvim_create_namespace
      local defer_fn = vim.defer_fn
      local del_autocmd = vim.api.nvim_del_autocmd --- @type function
      local exec_autocmds = vim.api.nvim_exec_autocmds --- @type function
      local get_current_tabpage = vim.api.nvim_get_current_tabpage
      local get_option = vim.api.nvim_get_option   --- @type function
      local islist = vim.islist or vim.tbl_islist  --- @type function
      local on_key = vim.on_key
      local replace_termcodes = vim.api.nvim_replace_termcodes
      local schedule_wrap = vim.schedule_wrap
      local set_current_buf = vim.api.nvim_set_current_buf --- @type function
      local tbl_isempty = vim.tbl_isempty
      local win_is_valid = vim.api.nvim_win_is_valid     --- @type function
      local win_get_position = vim.api.nvim_win_get_position --- @type function
      local win_get_width = vim.api.nvim_win_get_width   --- @type function

      local api = require('barbar.api')
      local bdelete = require('barbar.bbye').bdelete
      local config = require('barbar.config')
      local highlight = require('barbar.highlight') --- @type barbar.Highlight
      local jump_mode = require('barbar.jump_mode')
      local layout = require('barbar.ui.layout')
      local render = require('barbar.ui.render')
      local state = require('barbar.state')

      local HAS_BUF_MODIFIED_SET = vim.fn.exists('##BufModifiedSet') == 1
      local events = require('barbar.events')
      require('barbar.events').enable = function()
        local augroup_misc, augroup_render = events.augroups()

        create_autocmd('VimEnter', { callback = state.load_recently_closed, group = augroup_misc })
        create_autocmd('VimLeave', { callback = state.save_recently_closed, group = augroup_misc })

        create_autocmd({ 'BufNewFile', 'BufReadPost' }, {
          callback = vim.schedule_wrap(function(event)
            if buf_is_valid(event.buf) then
              jump_mode.assign_next_letter(event.buf)
              state.update_diagnostics(event.buf)
              state.update_gitsigns(event.buf)
            end
          end),
          group = augroup_misc,
        })

        create_autocmd({ 'BufDelete', 'BufWipeout' }, {
          callback = schedule_wrap(function(tbl)
            jump_mode.unassign_letter_for(tbl.buf)
            state.push_recently_closed(tbl.file)
            render.update()
          end),
          group = augroup_render,
        })

        create_autocmd('ColorScheme', {
          callback = highlight.resetup,
          group = augroup_misc,
        })

        if HAS_BUF_MODIFIED_SET then
          create_autocmd('BufModifiedSet', {
            callback = function(tbl)
              local is_modified = buf_get_option(tbl.buf, 'modified')
              if is_modified ~= vim.b[tbl.buf].checked then
                buf_set_var(tbl.buf, 'checked', is_modified)
                render.update()
              end
            end,
            group = augroup_render,
          })
        else
          create_autocmd('OptionSet', {
            callback = function() render.update() end,
            group = augroup_render,
            pattern = 'modified',
          })
        end

        create_autocmd({ 'BufEnter', 'BufNew' }, {
          callback = function() render.update(true) end,
          group = augroup_render,
        })

        create_autocmd(
          {
            'BufEnter', 'BufWinEnter', 'BufWinLeave', 'BufWritePost',
            'TabEnter',
            'VimResized',
            'WinEnter', 'WinLeave',
          },
          {
            callback = vim.schedule_wrap(function() render.update() end),
            group = augroup_render,
          }
        )

        create_autocmd('DiagnosticChanged', {
          -- NOTE: scheduled on purpose. `DiagnosticChanged` is dispatched as a buffer-scoped
          -- autocmd (`{buffer = event.buf}`), so Neovim runs this callback with `event.buf`
          -- temporarily set as the current buffer (`aucmd_prepbuf`). Rendering synchronously here
          -- would make `nvim_get_current_buf()` report the diagnostic's buffer rather than the
          -- actually-focused one, painting the wrong tab as active. This is especially visible when
          -- another plugin (e.g. coc.nvim) calls `vim.diagnostic.reset()`/`set()` during a buffer
          -- switch, firing `DiagnosticChanged` for many buffers in a row -> flicker. Deferring lets
          -- the buffer context unwind first.
          callback = vim.schedule_wrap(function(event)
            if vim.api.nvim_buf_is_loaded(event.buf) then
              state.update_diagnostics(event.buf)
              render.update()
            end
          end),
          group = augroup_render,
        })

        create_autocmd('User', {
          callback = vim.schedule_wrap(function(event)
            local bufnr
            if event.data == nil or event.data.buffer == nil then
              bufnr = event.buf
            else
              bufnr = event.data.buffer
            end

            state.update_gitsigns(bufnr)
            render.update()
          end),
          group = augroup_render,
          pattern = 'GitSignsUpdate',
        })

        if not tbl_isempty(config.options.sidebar_filetypes) then
          --- The `middle` column of the screen
          --- @type integer
          local middle

          --- Sets the `middle` of the screen
          local function set_middle()
            middle = rshift(get_option('columns'), 1) -- PERF: faster than math.floor(&columns / 2)
          end

          create_autocmd('VimResized', { callback = set_middle, group = augroup_misc })
          set_middle()

          local widths = {
            left = {}, --- @type {[string]: nil|integer}
            right = {}, --- @type {[string]: nil|integer}
          }

          --- @param side side
          --- @return integer total_width
          local function total_widths(side)
            local offset = 0
            local win_separator_width = side == 'left' and 1 or 2 -- It looks better like this… don't ask me why
            for _, width in pairs(widths[side]) do
              offset = offset + width + win_separator_width
            end

            -- we want the offset to begin ON the first win separator
            -- WARN: don't use `win_separator` here
            offset = offset - 1

            -- width cannot be less than zero
            return max(0, offset)
          end

          for ft, option in pairs(config.options.sidebar_filetypes) do
            create_autocmd('FileType', {
              callback = function(tbl)
                local bufwinid --- @type nil|integer
                local side --- @type side
                local autocmd = create_autocmd({ 'BufWinEnter', 'WinScrolled' }, {
                  callback = function()
                    if bufwinid == nil then
                      bufwinid = vim.fn.bufwinid(tbl.buf)
                    end
                    if not win_is_valid(bufwinid) then
                      return
                    end
                    local col = win_get_position(bufwinid)[2]
                    local other_side
                    if col < middle then
                      side, other_side = 'left', 'right'
                    else
                      side, other_side = 'right', 'left'
                    end

                    local width = win_get_width(bufwinid)
                    if width ~= widths[ft] then
                      widths[side][ft] = width
                      widths[other_side][ft] = nil
                      api.set_offset(total_widths(side), nil, nil, side, option)
                    end
                  end,
                  group = augroup_render,
                })

                local close_events = {}
                if option.event and not close_events[1] ~= option.event then
                  table.insert(close_events, option.event)
                end

                create_autocmd(close_events, {
                  buffer = tbl.buf,
                  callback = function()
                    if widths[side] then
                      widths[side][ft] = nil
                      api.set_offset(total_widths(side), nil, nil, side, {})
                    end
                    pcall(del_autocmd, autocmd)
                  end,
                  group = augroup_render,
                  once = true,
                })
              end,
              group = augroup_misc,
              pattern = ft,
            })
          end
        end

        create_autocmd('OptionSet', {
          callback = function() render.update() end,
          group = augroup_render,
          pattern = 'buflisted',
        })

        create_autocmd('OptionSet', {
          callback = highlight.resetup,
          group = augroup_misc,
          pattern = 'background',
        })

        create_autocmd('SessionLoadPost', {
          callback = vim.schedule_wrap(function()
            local restore_cmd = vim.g.Bufferline__session_restore
            if restore_cmd then command(restore_cmd) end

            render.update(true)
          end),
          group = augroup_render,
        })

        create_autocmd('TermOpen', {
          callback = function() defer_fn(function() render.update(true) end, 500) end,
          group = augroup_render,
        })

        create_autocmd('TermClose', {
          callback = function() render.update(true) end,
          group = augroup_render,
        })

        do
          local buffers_by_tab = {}
          create_autocmd('User', {
            callback = function()
              local tab = get_current_tabpage()
              buffers_by_tab[tab] = state.export_buffers()
            end,
            group = augroup_misc,
            pattern = 'ScopeTabLeavePre',
          })

          create_autocmd('User', {
            callback = function()
              local tab = get_current_tabpage()
              local buffers = buffers_by_tab[tab]
              if buffers then
                state.restore_buffers(buffers)
              end
            end,
            group = augroup_misc,
            pattern = 'ScopeTabEnterPost',
          })
        end

        create_autocmd('User', {
          callback = function()
            local buffers = state.export_buffers()
            vim.g.Bufferline__session_restore = "lua require('barbar.state').restore_buffers " ..
                vim.inspect(buffers, { newline = ' ', indent = '' })
          end,
          group = augroup_misc,
          pattern = 'SessionSavePre',
        })

        create_autocmd('WinClosed', {
          callback = schedule_wrap(render.update),
          group = augroup_render,
        })

        -- TODO: merge the `vim.cmd` calls and references to `vim.g.bufferline` when v2 releases
        vim.schedule(function()
          vim.cmd [[
      silent! call dictwatcherdel(g:, 'bufferline', 'barbar#events#dict_changed')
      silent! call dictwatcherdel(g:bufferline, '*', 'barbar#events#on_option_changed')
    ]]

          local g_bufferline = vim.g.bufferline
          if type(g_bufferline) ~= 'table' or islist(g_bufferline) then
            vim.g.bufferline = vim.empty_dict()
          end

          vim.cmd [[
      call dictwatcheradd(g:, 'bufferline', 'barbar#events#dict_changed')
      call dictwatcheradd(g:bufferline, '*', 'barbar#events#on_option_changed')
    ]]
        end)

        render.update()
        enabled = true
      end
    end
  },

}
