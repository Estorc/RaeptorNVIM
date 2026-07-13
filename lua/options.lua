vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.laststatus = 0
vim.opt.cmdheight = 0
vim.opt.tabstop = 2      -- number of spaces a tab displays as
vim.opt.shiftwidth = 2   -- number of spaces for auto-indent
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.softtabstop = 2  -- spaces inserted when pressing Tab

-- Add undo file
vim.opt.undofile = true

vim.g.clipboard = {
  name = "wl-clipboard",
  copy = {
    ["+"] = "wl-copy",
    ["*"] = "wl-copy --primary",
  },
  paste = {
    ["+"] = "wl-paste --no-newline",
    ["*"] = "wl-paste --no-newline --primary",
  },
  cache_enabled = 0,
}
