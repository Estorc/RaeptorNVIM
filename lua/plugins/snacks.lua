local FS = require("utils.fs")
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
      animate = { enabled = true },
      bigfile = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      -- notifier = { enabled = true },
      bufdelete = { enabled = true },
      image = { enabled = false },
      rename = { enabled = true },
      quickfile = { enabled = true },
      toggle = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      dim = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
  FS.globRequire("plugins.snacks"),
}
