local map = vim.keymap.set

local wk = require("which-key")

wk.add({
  { "<C-h>",      "<C-w>h",                               desc = "Move to left window" },
  { "<C-j>",      "<C-w>j",                               desc = "Move to lower window" },
  { "<C-k>",      "<C-w>k",                               desc = "Move to upper window" },
  { "<C-l>",      "<C-w>l",                               desc = "Move to right window" },

  { "<S-h>",      "<cmd>BufferLineCyclePrev<CR>",         desc = "Previous buffer" },
  { "<S-l>",      "<cmd>BufferLineCycleNext<CR>",         desc = "Next buffer" },

  -- Terminal
  { "<leader>t",  group = "terminal" },
  { "<leader>tt", ":ToggleTerm<CR>",                      desc = "Toggle terminal" },
  { "<leader>tf", ":ToggleTerm direction=float<CR>",      desc = "Toggle floating terminal" },
  { "<leader>th", ":ToggleTerm direction=horizontal<CR>", desc = "Toggle horizontal terminal" },
  { "<leader>tv", ":ToggleTerm direction=vertical<CR>",   desc = "Toggle vertical terminal" },

  -- Close buffer
  { "<leader>b",  group = "buffers" },
  { "<leader>q",  ":lua Snacks.bufdelete()<CR>",          desc = "Close buffer" },
  { "<leader>bd", ":lua Snacks.bufdelete()<CR>",          desc = "Close buffer" },
  { "<leader>bo", ":lua Snacks.bufdelete.other()<CR>",    desc = "Close others buffers" },
  { "<leader>ba", ":lua Snacks.bufdelete.all()<CR>",      desc = "Close all buffers" },
  -- Create new buffer
  { "<leader>bn", ":enew<CR>",                            desc = "New buffer" },
  {
    "<leader>Q",
    function()
      if vim.fn.confirm("Quit?", "&Yes\n&No", 2) == 1 then
        vim.cmd("quitall!")
      end
    end,
    desc = "Quit NVIM"
  },
})


-- Comment with <leader>/ in normal and visual mode using Comment.nvim
map("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", { noremap = true, silent = true })
map("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { noremap = true, silent = true })

-- Add <C-s> for saving in all modes
map("n", "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true })
map("i", "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true })
map("v", "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true })
