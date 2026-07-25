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
  { "nvim-lua/plenary.nvim" },
  { 'OXY2DEV/markview.nvim' },
  { "petertriho/nvim-scrollbar" },
  { 'akinsho/bufferline.nvim',  version = "*",                              dependencies = 'nvim-tree/nvim-web-devicons' },
  { "3rd/image.nvim" },
  { 'kevinhwang91/nvim-ufo',    dependencies = 'kevinhwang91/promise-async' },
  -- { "nicolas-martin/region-folding.nvim", event = { "BufReadPost", "BufNewFile" } },
  { "nvim-zh/colorful-winsep.nvim", config = true, event = { "WinLeave" } },
  FS.globRequire("plugins.editor"),
  FS.globRequire("plugins.dap"),
  FS.globRequire("plugins.nvchad")
}
