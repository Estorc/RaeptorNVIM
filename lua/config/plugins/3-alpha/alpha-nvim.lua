local LOAD_RANDOM_IMAGE = true

local Plugins = require("utils.plugins")
local Shell = require("utils.shell")
local Logger = require("utils.logger")

local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'

-- Detect nvim height
local nvim_height = vim.fn.winheight(0)
local header

-- Find all images in lua/headers/img directory
local img_dir = vim.fn.stdpath('config') .. '/lua/headers/img'
local img_files = vim.fn.globpath(img_dir, '*', 0, 1)

-- If there are any images, pick a random one and set it as the header
if #img_files > 0 and LOAD_RANDOM_IMAGE then
  Logger.log("Found " .. #img_files .. " images in " .. img_dir, Logger.Levels.INFO)
  local random_img = img_files[math.random(#img_files)]
  Logger.log("Random image selected: " .. random_img, Logger.Levels.INFO)
  local img_ansi = Shell.runCommand("catimg" ..
    " " .. random_img .. " -H 40 | sed '1s/^.\\{9\\}//'")
  Shell.runCommand(vim.fn.stdpath('config') .. '/lua/headers/ansi2alpha' ..
    ' ' .. '"' .. img_ansi .. '" > ' .. vim.fn.stdpath('config') .. '/lua/headers/img_header.lua')
  header = require("headers.img_header")
else
  if nvim_height < 40 then
    header = require("headers.raeptor-small")
  else
    header = require("headers.raeptor-large")
  end
end
dashboard.section.header.val = header.val
dashboard.section.header.opts.hl = header.opts.hl
dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "󰱼  Find file", ":Telescope find_files<CR>"),
  dashboard.button("r", "󰄉  Recent files", ":Telescope oldfiles<CR>"),
  dashboard.button("s", "󰍉  Find text", ":Telescope live_grep<CR>"),
  dashboard.button("c", "  Configuration", ":e $MYVIMRC | :cd %:p:h | wincmd k<CR>:Neotree reveal<CR><C-w><C-w>:q<CR>"),
  dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
}
-- local handle = io.popen('fortune')
-- local fortune = handle:read("*a")
-- handle:close()
-- dashboard.section.footer.val = fortune

dashboard.section.footer.val = "Ræptor Neovim -- Plume"

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
