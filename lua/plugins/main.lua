local FS = require("utils.fs")
return {
  { "nvim-telescope/telescope.nvim" },
  { "nvim-treesitter/nvim-treesitter" },
  { "folke/which-key.nvim",           event = "VeryLazy" },
  { "folke/persistence.nvim",         event = "BufReadPre" },
  FS.globRequire("plugins.lsp"),
  FS.globRequire("plugins.ai")
}
