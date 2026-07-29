local Plugins = require("utils.plugins")


Plugins.configureSettings('image', {
    backend = "kitty",
    integrations = {
      markdown = {
        enabled = true,
      },
    }
})
