local Plugins = require("utils.plugins")

Plugins.configureSettings("persistence", {

})

-- vim.api.nvim_create_autocmd("VimLeavePre", {
--   callback = function()
--     require("persistence").save()
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("VimEnter", {
--   nested = true,
--   callback = function()
--     require("persistence").load()
--   end,
-- })
