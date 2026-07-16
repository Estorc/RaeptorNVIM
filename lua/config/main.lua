local FS = require("utils.fs")
local Plugins = require("utils.plugins")
local Raeptor = require("raeptor")
local Logger = require("utils.logger")

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
math.randomseed(os.time())
Logger.setLevel(Logger.Levels.NONE)
Plugins.initializeLazy()
FS.globRequire("config.plugins")
require("options")
require("keymaps")
require("autocmd")
Logger.setLevel(Logger.Levels.INFO)
