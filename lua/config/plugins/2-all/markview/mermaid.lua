local Plugins = require("utils.plugins")

Plugins.configureSettings("mermaid", {
  format = {
    shift_width = 4, -- Indentation size (spaces)
  },
  lint = {
    enabled = true,   -- Enable diagnostics via mmdc
    command = "mmdc", -- Path to mermaid-cli executable
  },
  preview = {
    renderer = "mermaid.js", -- "mermaid.js" or "beautiful-mermaid"
    theme = "default",       -- Theme name (renderer-specific)
  },
})
