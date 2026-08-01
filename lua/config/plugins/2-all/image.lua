local Plugins = require("utils.plugins")


Plugins.configureSettings('image', {
  backend = "kitty",
  integrations = {
    markdown = {
      enabled = true,
    },
  }
})


if Plugins.isPluginInstalled('image') then
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "image_nvim",
    callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn = "no"
      vim.opt_local.statuscolumn = ""

      vim.opt_local.wrap = false
      vim.opt_local.cursorcolumn = false
      vim.opt_local.foldcolumn = "0"
      vim.opt_local.list = false
      vim.opt_local.spell = false
    end,
  })
end
