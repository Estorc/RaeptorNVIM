return {
  {
    'Thiago4532/mdmath.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    dir = vim.fn.stdpath('config') .. "/lua/plugins/raeptor-markdown.nvim",
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
}
