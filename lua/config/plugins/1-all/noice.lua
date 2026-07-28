local Plugins = require("utils.plugins")

Plugins.configureSettings('noice', {
  cmdline = {
    enabled = true,
  },

  messages = {
    enabled = false,
  },

  popupmenu = {
    enabled = false,
  },

  notify = {
    enabled = true,
    view = "notify",
  },

  lsp = {
    progress = {
      enabled = false,
    },
    hover = {
      enabled = false,
    },
    signature = {
      enabled = false,
    },
  },
})
