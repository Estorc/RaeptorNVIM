local LOAD_RANDOM_IMAGE = true

local Plugins = require("utils.plugins")
local Shell = require("utils.shell")
local Logger = require("utils.logger")

if not Plugins.isPluginInstalled('alpha') then
  return
end



local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'

-- Detect nvim height
local nvim_height = vim.fn.winheight(0)
local padding = 1
local header_height = (nvim_height - 20) + (35 - 28 - padding)
local header

-- Check if catimg exist
if not Shell.commandExist("catimg") or not Shell.commandExist("ansi2alpha") then
  LOAD_RANDOM_IMAGE = false
  Logger.notify("catimg not found, random image loading disabled", vim.log.levels.WARN)
end


Logger.notify("Welcome aboard, Captain!", vim.log.levels.INFO)

-- Find all images in lua/headers/img directory
local img_dir = vim.fn.stdpath('config') .. '/lua/headers/img'
local img_files = vim.fn.globpath(img_dir, '*', 0, 1)

-- If there are any images, pick a random one and set it as the header
if #img_files > 0 and LOAD_RANDOM_IMAGE then
  Logger.log("Found " .. #img_files .. " images in " .. img_dir, Logger.Levels.INFO)
  local random_img = img_files[math.random(#img_files)]
  Logger.log("Random image selected: " .. random_img, Logger.Levels.INFO)
  local img_ansi = Shell.runCommand("catimg" ..
    " " .. random_img .. " -H " .. header_height * 2 .. " | sed '1s/^.\\{9\\}//'")
  Logger.log("Image ANSI output: " .. img_ansi, Logger.Levels.INFO)
  Shell.runCommand('ansi2alpha "' .. img_ansi .. '" > ' .. vim.fn.stdpath('config') .. '/lua/headers/img_header.lua')
  header = require("headers.img_header")
else
  if header_height < require("headers.raeptor-large").height - padding then
    header = require("headers.raeptor-small")
  else
    header = require("headers.raeptor-large")
  end
end
dashboard.section.header.val = header.val
dashboard.section.header.opts.hl = header.opts.hl
padding = math.floor((header_height - header.height) / 2) + 2
dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "󰱼  Find file", ":Telescope find_files<CR>"),
  dashboard.button("s", "󰍉  Find text", ":Telescope live_grep<CR>"),
  dashboard.button("c", "  Configuration", ":e $MYVIMRC | :cd %:p:h | wincmd k<CR>:Neotree reveal<CR><C-w><C-w>:q<CR>"),
  dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
}
dashboard.config.layout[1].val = padding
-- local handle = io.popen('fortune')
-- local fortune = handle:read("*a")
-- handle:close()
-- dashboard.section.footer.val = fortune

dashboard.section.footer.val = "󰃰 " .. os.date("%I:%M %p") .. "- " .. os.date("%A, %B %d, %Y") ..
    " -  Ræptor NVIM - 󰛓 Plume - " ..
    vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch

dashboard.config.opts.noautocmd = true

vim.cmd [[autocmd User AlphaReady echo 'ready']]

alpha.setup(dashboard.config)


vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.schedule(function()
      if vim.bo.filetype == "alpha" then
        vim.opt_local.laststatus = 0
      else
        vim.opt_local.laststatus = 3
      end
    end)
  end,
})
