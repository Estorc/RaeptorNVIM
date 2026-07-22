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
vim.opt.autoread = false
vim.o.wrap = false
vim.o.confirm = true
vim.o.cursorline = true

-- Add undo file
vim.opt.undofile = true


-- Enable treesitter folding (required for function folding)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldcolumn = '1' -- '0' is not bad
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = { current_line = true },
  underline = true,
  update_in_insert = false
})
