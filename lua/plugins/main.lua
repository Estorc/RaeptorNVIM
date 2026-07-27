local FS = require("utils.fs")
return {
  { "nvim-telescope/telescope.nvim" },
  { "nvim-treesitter/nvim-treesitter" },
  { "folke/which-key.nvim",           event = "VeryLazy" },
  { "folke/persistence.nvim",         event = "BufReadPre" },
  { 'MagicDuck/grug-far.nvim' },
  FS.globRequire("plugins.lsp"),
  FS.globRequire("plugins.ai")
}
