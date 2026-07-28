local Plugins = require("utils.plugins")

vim.g.barbar_auto_setup = false
Plugins.configureSettings('barbar', {
  auto_hide = true,
  sidebar_filetypes = {
    ['neo-tree'] = { text = '󱋣 File Explorer', align = 'center', event = "BufWipeout", }
  },
})

if (Plugins.isPluginInstalled('barbar')) then
  local wk = require("which-key")
  wk.add({

    { "<S-h>", "<cmd>BufferPrevious<CR>", desc = "Previous buffer" },
    { "<S-l>", "<cmd>BufferNext<CR>",     desc = "Next buffer" },
  })

  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }

  -- Re-order to previous/next
  map('n', '<A-h>', '<Cmd>BufferMovePrevious<CR>', opts)
  map('n', '<A-l>', '<Cmd>BufferMoveNext<CR>', opts)

  -- Goto buffer in position...
  map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
  map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
  map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
  map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
  map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
  map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
  map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
  map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
  map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
  map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

  -- Pin/unpin buffer
  map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)

  -- Goto pinned/unpinned buffer
  --                 :BufferGotoPinned
  --                 :BufferGotoUnpinned

  -- Wipeout buffer
  --                 :BufferWipeout

  -- Close commands
  --                 :BufferCloseAllButCurrent
  --                 :BufferCloseAllButPinned
  --                 :BufferCloseAllButCurrentOrPinned
  --                 :BufferCloseBuffersLeft
  --                 :BufferCloseBuffersRight

  -- Magic buffer-picking mode
  map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
  map('n', '<C-s-p>', '<Cmd>BufferPickDelete<CR>', opts)

  -- Sort automatically by...
  map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
  map('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', opts)
  map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
  map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
  map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)


  -- vim.api.nvim_create_autocmd("FileType", {
  --   pattern = { "alpha" },
  --   callback = function()
  --     vim.opt_local.showtabline = 0
  --   end,
  -- })
  --
  -- vim.api.nvim_create_autocmd("BufEnter", {
  --   callback = function()
  --     if vim.bo.filetype ~= "alpha" then
  --       vim.opt.showtabline = 2
  --     end
  --   end,
  -- })

  vim.schedule(function()
    local colors = require("base46").get_theme_tb("base_30")

    vim.api.nvim_set_hl(0, "BufferLineFill", {
      bg = colors.darker_black,
    })
    vim.api.nvim_set_hl(0, "TabLineFill", {
      bg = colors.darker_black,
    })
    vim.api.nvim_set_hl(0, "BufferTabpageFill", {
      bg = colors.darker_black,
    })

    vim.api.nvim_set_hl(0, "BufferInactive", {
      fg = "#909090",
    })
    vim.api.nvim_set_hl(0, "BufferInactiveIndex", {
      fg = "#909090",
    })

    vim.api.nvim_set_hl(0, "BufferVisible", {
      fg = "#909090",
    })
    vim.api.nvim_set_hl(0, "BufferVisibleIndex", {
      fg = "#909090",
    })
  end)
end
