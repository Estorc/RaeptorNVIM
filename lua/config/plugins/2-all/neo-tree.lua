local Plugins = require("utils.plugins")

local firstOpen = true;
local uv = vim.loop
local stdout = uv.new_tty(1, false)
if not stdout then
  error('failed to open stdout')
end
-- stdout:write("\\033]0;NVIM\\007")

local events = require("neo-tree.events");
-- Mappings for Neo-tree
Plugins.configureSettings("neo-tree", {
  clipboard = {
    sync = "universal",
  },
  popup_border_style = "rounded",
  default_component_configs = {
    git_status = {
      symbols = {
        -- Change type
        added = "✚", -- or "✚"
        modified = "", -- or ""
        deleted = "✖", -- this can only be used in the git_status source
        renamed = "󰁕", -- this can only be used in the git_status source
        -- Status type
        untracked = "",
        ignored = "",
        unstaged = "",
        staged = "",
        conflict = "",
      },
    },
  },
  source_selector = {
    winbar = true,
  },
  window = {
    mappings = {
      -- ['Y'] = function(state)
      --   -- Copy global
      --   local node = state.tree:get_node()
      --   vim.fn.setreg('+', "neo-tree[y]:" .. node:get_id())
      --   vim.notify(string.format('Copied "%s" to global register', node:get_id()), vim.log.levels.INFO)
      --   -- Copy local
      --   require("neo-tree.sources.manager").copy_to_clipboard(state, node)
      -- end,
      -- ['X'] = function(state)
      --   -- Cut global
      --   local node = state.tree:get_node()
      --   vim.fn.setreg('+', "neo-tree[x]:" .. node:get_id())
      --   vim.notify(string.format('Cuted "%s" to global register', node:get_id()), vim.log.levels.INFO)
      --   -- Cut local
      --   require("neo-tree.sources.manager").cut_to_clipboarde(state, node)
      -- end,
      -- ['P'] = function(state)
      --   -- Paste global (using cp)
      --   local node = state.tree:get_node()
      --   local path = node:get_id()
      --   local copy = vim.fn.getreg('+')
      --   local mode = '';
      --   -- Check mode and link
      --   if string.sub(copy, 1, 13) == "neo-tree[y]:" then
      --     copy = string.sub(copy, 14)
      --     mode = 'y'
      --   elseif string.sub(copy, 1, 13) == "neo-tree[x]:" then
      --     copy = string.sub(copy, 14)
      --     mode = 'x'
      --   else
      --     vim.notify(string.format('Invalid copy register: "%s"', copy), vim.log.levels.ERROR)
      --     return
      --   end
      --   if copy ~= nil and copy ~= '' then
      --     local cmd = ''
      --     if mode == 'y' then
      --       cmd = string.format('cp -r "%s" "%s"', copy, path)
      --     elseif mode == 'x' then
      --       cmd = string.format('mv "%s" "%s"', copy, path)
      --     end
      --     vim.fn.system(cmd)
      --     require("neo-tree.sources.manager").refresh("filesystem")
      --   end
      --   vim.notify(string.format('Pasted "%s" to "%s"', copy, path), vim.log.levels.INFO)
      -- end,
      -- ["<C-s>"] = {
      --   "quick_jump",
      --   config = {
      --     -- This will automaticly open / toggle the target node after jumping.
      --     -- You can set it to `nil` to perform only the jump action,
      --     -- or write your own callback (---@type fun(state, node)).
      --     on_jump = "open_or_toggle",
      --     jump_labels = "jfkdlsahgnuvrbytmiceoxwpqz",
      --   }
      -- },
      -- ["<Tab>"] = "select",
      -- ["<C-;>"] = "clear_selection",
      ["<space>"] = "noop",
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["<esc>"] = "cancel", -- close preview or floating neo-tree window
      ["P"] = {
        "toggle_preview",
        config = {
          use_float = true,
          use_snacks_image = true,
          use_image_nvim = true,
        },
      },
      -- Read `# Preview Mode` for more information
      ["l"] = "noop",
      ["S"] = "open_split",
      ["s"] = "open_vsplit",
      -- ["S"] = "split_with_window_picker",
      -- ["s"] = "vsplit_with_window_picker",
      ["t"] = "open_tabnew",
      -- ["<cr>"] = "open_drop",
      -- ["t"] = "open_tab_drop",
      ["w"] = "open_with_window_picker",
      --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
      ["C"] = "close_node",
      -- ['C'] = 'close_all_subnodes',
      ["z"] = "close_all_nodes",
      --["Z"] = "expand_all_nodes",
      --["Z"] = "expand_all_subnodes",
      ["a"] = {
        "add",
        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = "none", -- "none", "relative", "absolute"
        },
      },
      ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
      ["d"] = "delete",
      ["r"] = "rename",
      ["b"] = "rename_basename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["<C-r>"] = "clear_clipboard",
      ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
      -- ["c"] = {
      --  "copy",
      --  config = {
      --    show_path = "none" -- "none", "relative", "absolute"
      --  }
      --}
      ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["<S-h>"] = "prev_source",
      ["<S-l>"] = "next_source",
      ["i"] = "show_file_details",
      -- ["i"] = {
      --   "show_file_details",
      --   -- format strings of the timestamps shown for date created and last modified (see `:h os.date()`)
      --   -- both options accept a string or a function that takes in the date in seconds and returns a string to display
      --   -- config = {
      --   --   created_format = "%Y-%m-%d %I:%M %p",
      --   --   modified_format = "relative", -- equivalent to the line below
      --   --   modified_format = function(seconds) return require('neo-tree.utils').relative_date(seconds) end
      --   -- }
      -- },
    },
  },
  filesystem = {
    -- hijack_netrw_behavior = "open_current",
    window = {
      mappings = {
        ["<C-s-h>"] = { "toggle_hidden", desc = "Toggle hidden files" },
        ["H"] = "noop",
        ["/"] = "fuzzy_finder",
        --["/"] = {"fuzzy_finder", config = { keep_filter_on_submit = true }},
        --["/"] = "filter_as_you_type", -- this was the default until v1.28
        ["D"] = "fuzzy_finder_directory",
        -- ["D"] = "fuzzy_sorter_directory",
        ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
        ["f"] = "filter_on_submit",
        ["<C-x>"] = "clear_filter",
        ["<A-h>"] = "navigate_up",
        ["<A-l>"] = "set_root",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
        ["i"] = "show_file_details", -- see `:h neo-tree-file-actions` for options to customize the window.
        ["b"] = "rename_basename",
        ["o"] = { "open", nowait = true },
        ["oc"] = "noop",
        ["od"] = "noop",
        ["og"] = "noop",
        ["om"] = "noop",
        ["on"] = "noop",
        ["os"] = "noop",
        ["ot"] = "noop",
        ["<C-oc>"] = { "order_by_created", nowait = false },
        ["<C-od>"] = { "order_by_diagnostics", nowait = false },
        ["<C-og>"] = { "order_by_git_status", nowait = false },
        ["<C-om>"] = { "order_by_modified", nowait = false },
        ["<C-on>"] = { "order_by_name", nowait = false },
        ["<C-os>"] = { "order_by_size", nowait = false },
        ["<C-ot>"] = { "order_by_type", nowait = false },
      },
      fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
        ["<down>"] = "move_cursor_down",
        ["<C-n>"] = "move_cursor_down",
        ["<up>"] = "move_cursor_up",
        ["<C-p>"] = "move_cursor_up",
        ["<Esc>"] = "close",
        ["<S-CR>"] = "close_keep_filter",
        ["<C-CR>"] = "close_clear_filter",
        ["<C-w>"] = { "<C-S-w>", raw = true },
        {
          -- normal mode mappings
          n = {
            ["j"] = "move_cursor_down",
            ["k"] = "move_cursor_up",
            ["<S-CR>"] = "close_keep_filter",
            ["<C-CR>"] = "close_clear_filter",
            ["<esc>"] = "close",
          }
        }
        -- ["<esc>"] = "noop", -- if you want to use normal mode
        -- ["key"] = function(state, scroll_padding) ... end,
      },
    },
  },
  buffers = {
    window = {
      mappings = {
        ["d"] = "buffer_delete",
        ["bd"] = "buffer_delete",
        ["<A-h>"] = "navigate_up",
        ["<A-l>"] = "set_root",
        ["o"] = { "open", nowait = true },
        ["oc"] = "noop",
        ["od"] = "noop",
        ["og"] = "noop",
        ["om"] = "noop",
        ["on"] = "noop",
        ["os"] = "noop",
        ["ot"] = "noop",
        ["<C-oc>"] = { "order_by_created", nowait = false },
        ["<C-od>"] = { "order_by_diagnostics", nowait = false },
        ["<C-om>"] = { "order_by_modified", nowait = false },
        ["<C-on>"] = { "order_by_name", nowait = false },
        ["<C-os>"] = { "order_by_size", nowait = false },
        ["<C-ot>"] = { "order_by_type", nowait = false },
      },
    },
  },
  git_status = {
    window = {
      mappings = {
        ["A"] = "git_add_all",
        ["gu"] = "noop",
        ["gU"] = "noop",
        ["ga"] = "noop",
        ["gt"] = "noop",
        ["gr"] = "noop",
        ["gc"] = "noop",
        ["gp"] = "noop",
        ["gl"] = "noop",
        ["gg"] = "noop",
        -- ["<C-gu>"] = "git_unstage_file",
        -- ["<C-gU>"] = "git_undo_last_commit",
        -- ["<C-ga>"] = "git_add_file",
        -- ["<C-gt>"] = "git_toggle_file_stage",
        -- ["<C-gr>"] = "git_revert_file",
        -- ["<C-gc>"] = "git_commit",
        -- ["<C-gp>"] = "git_push",
        -- ["<C-gl>"] = "git_pull",
        -- ["<C-gg>"] = "git_commit_and_push",
        ["o"] = { "open", nowait = true },
        ["oc"] = "noop",
        ["od"] = "noop",
        ["og"] = "noop",
        ["om"] = "noop",
        ["on"] = "noop",
        ["os"] = "noop",
        ["ot"] = "noop",
        ["<C-oc>"] = { "order_by_created", nowait = false },
        ["<C-od>"] = { "order_by_diagnostics", nowait = false },
        ["<C-om>"] = { "order_by_modified", nowait = false },
        ["<C-on>"] = { "order_by_name", nowait = false },
        ["<C-os>"] = { "order_by_size", nowait = false },
        ["<C-ot>"] = { "order_by_type", nowait = false },
      },
    },
  },
  event_handlers = {
    {
      event = events.NEO_TREE_WINDOW_AFTER_OPEN,
      handler = function(opts)
        if not firstOpen then
          return
        end

        firstOpen = false

        vim.schedule(function()
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if win ~= opts.winid and vim.api.nvim_win_is_valid(win) then
              local buf = vim.api.nvim_win_get_buf(win)

              if vim.api.nvim_get_option_value("buftype", { buf = buf }) == "" then
                pcall(vim.api.nvim_win_close, win, false)
                break
              end
            end
          end
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[buf].buftype == "" then
              vim.bo[buf].buflisted = false
            end
          end
        end)
      end,
    },
  }
})



-- Disable h and l in neo-tree
vim.api.nvim_create_autocmd("FileType", {
  pattern = "neo-tree",
  callback = function()
    vim.keymap.set("n", "h", "<Nop>", { buffer = true })
    vim.keymap.set("n", "l", "<Nop>", { buffer = true })
  end,
})
