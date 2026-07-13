local Plugins = require("utils.plugins")

Plugins.configureSettings('copilot', {
  suggestion = {
    enabled = true,
    auto_trigger = false,
    hide_during_completion = true,
    debounce = 15,
    trigger_on_accept = true,
    keymap = {
      accept = "<M-y>",
      accept_word = false,
      accept_line = false,
      next = "<M-l>",
      prev = "<M-h>",
      dismiss = "<M-e>",
      toggle_auto_trigger = false,
    },
  },
})
