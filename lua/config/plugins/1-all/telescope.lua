local Plugins = require("utils.plugins")

Plugins.configureSettings("telescope", {
  defaults = {
    layout_strategy = "horizontal",
    layout_config = { prompt_position = "top" },
    sorting_strategy = "ascending",
    winblend = 0,
  },
})

Plugins.configureKeymaps("telescope", {
  {
    mode = "n",
    lhs = "<leader>fp",
    rhs = "<cmd>lua require('telescope.builtin').find_files({ cwd = require('lazy.core.config').options.root })<cr>",
    opts = { noremap = true, silent = true },
    desc = "Find Plugin File",
  },
  {
    mode = "n",
    lhs = "<leader>ff",
    rhs = "<cmd>Telescope find_files<cr>",
    opts = { noremap = true, silent = true },
    desc = "Find Files",
  },
  {
    mode = "n",
    lhs = "<leader>fg",
    rhs = "<cmd>Telescope live_grep<cr>",
    opts = { noremap = true, silent = true },
    desc = "Live Grep",
  },
  {
    mode = "n",
    lhs = "<leader>fb",
    rhs = "<cmd>Telescope buffers<cr>",
    opts = { noremap = true, silent = true },
    desc = "Find Buffers",
  },
  {
    mode = "n",
    lhs = "<leader>fh",
    rhs = "<cmd>Telescope help_tags<cr>",
    opts = { noremap = true, silent = true },
    desc = "Find Help Tags",
  },
})
