local Plugins = require("utils.plugins")

Plugins.configureSettings('mason-lspconfig', {
  ensure_installed = {
    "lua_ls",
    "clangd",
    "pyright",
  },
  automatic_enable = true, -- Mason v2
})
