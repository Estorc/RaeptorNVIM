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
  {
    "nvchad/ui",
    config = function()
      require "nvchad"
    end
  },
  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },
  { 'OXY2DEV/markview.nvim' },
  { "petertriho/nvim-scrollbar" },
  { 'akinsho/bufferline.nvim',  version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },
  { "3rd/image.nvim" },
  FS.globRequire("plugins.editor"),
  FS.globRequire("plugins.dap"),
}
