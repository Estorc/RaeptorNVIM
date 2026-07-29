local FS = require("utils.fs")
local Plugins = require("utils.plugins")
local Logger = require("utils.logger")

-- NvChad
package.path = package.path .. ';' .. vim.fn.stdpath('config') .. '/lua/config/plugins/1-nvchad/?.lua'
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
-- Prepare Random
math.randomseed(os.time())
Logger.setLevel(Logger.Levels.NONE)
Plugins.initializeLazy()
FS.globRequire("config.plugins")
require("options")
require("keymaps")
require("autocmd")
Logger.setLevel(Logger.Levels.INFO)
