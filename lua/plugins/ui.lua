local FS = require("utils.fs")
return {
  { "MunifTanjim/nui.nvim" },
  { "goolord/alpha-nvim",  dependencies = { 'nvim-tree/nvim-web-devicons' } },
  -- { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
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
  { 'akinsho/bufferline.nvim',  version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },
  { "3rd/image.nvim" },
  -- { "nicolas-martin/region-folding.nvim", event = { "BufReadPost", "BufNewFile" } },
  FS.globRequire("plugins.editor"),
  FS.globRequire("plugins.dap"),
  FS.globRequire("plugins.nvchad")
}
