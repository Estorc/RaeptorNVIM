local Plugins = require("utils.plugins")


Plugins.configureSettings('image', {
  backend = "kitty",
  integrations = {
    markdown = {
      enabled = true,
    },
  }
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "image_nvim",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.statuscolumn = ""
  end,
})
