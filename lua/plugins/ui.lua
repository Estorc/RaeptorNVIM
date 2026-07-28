local FS = require("utils.fs")
return {
  { "MunifTanjim/nui.nvim" },
  { "goolord/alpha-nvim",        dependencies = { 'nvim-tree/nvim-web-devicons' } },
  { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
  {
    'saghen/blink.cmp',
    dependencies = {
      'saghen/blink.lib',
      -- optional: provides snippets for the snippet source
      'rafamadriz/friendly-snippets',
    },
    version = '1.*',
  },
  { 'rcarriga/nvim-notify' },
  { "folke/noice.nvim",         event = "VeryLazy", dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" } },
  { "nvim-lua/plenary.nvim" },
  { 'OXY2DEV/markview.nvim' },
  { "petertriho/nvim-scrollbar" },
  -- { 'akinsho/bufferline.nvim',  version = "*",                              dependencies = 'nvim-tree/nvim-web-devicons' },
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
  },
  { "3rd/image.nvim" },
  { 'kevinhwang91/nvim-ufo',          dependencies = 'kevinhwang91/promise-async' },
  -- { "nicolas-martin/region-folding.nvim", event = { "BufReadPost", "BufNewFile" } },
  { "nvim-zh/colorful-winsep.nvim",   config = true,                              event = { "WinLeave" } },
  { 'Tyler-Barham/floating-help.nvim' },
  { "nvzone/showkeys",                cmd = "ShowkeysToggle" },
  FS.globRequire("plugins.editor"),
  FS.globRequire("plugins.dap"),
  FS.globRequire("plugins.nvchad")
}
