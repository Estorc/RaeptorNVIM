local Plugins = require('utils.plugins')
Plugins.configureSettings('grug-far', {
  openTargetWindow = {
    exclude = {
      "neo-tree",
      "grug-far",
    },
    preferredLocation = 'prev',
  },
});
if Plugins.isPluginInstalled('grug-far') then
  vim.api.nvim_create_user_command("GrugFarFloat", function()
    Snacks.win({
      relative = "editor",
      width = 0.8,
      height = 0.8,
      border = "rounded",
      enter = true,
      fixbuf = false,
    })
    require("grug-far").open({
      windowCreationCommand = "buffer",
    })
  end, {})

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "grug-far",
    callback = function(args)
      vim.bo[args.buf].buflisted = false
    end,
  })
end
