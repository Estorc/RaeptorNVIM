local map = vim.keymap.set

local wk = require("which-key")

wk.add({
  { "<C-h>",      "<C-w>h",                                       desc = "Move to left window" },
  { "<C-j>",      "<C-w>j",                                       desc = "Move to lower window" },
  { "<C-k>",      "<C-w>k",                                       desc = "Move to upper window" },
  { "<C-l>",      "<C-w>l",                                       desc = "Move to right window" },

  { "<S-h>",      "<cmd>BufferLineCyclePrev<CR>",                 desc = "Previous buffer" },
  { "<S-l>",      "<cmd>BufferLineCycleNext<CR>",                 desc = "Next buffer" },

  -- Terminal
  { "<leader>t",  group = "terminal" },
  { "<leader>tt", ":ToggleTerm direction=horizontal size=20<CR>", desc = "Toggle terminal" },
  { "<leader>tf", ":ToggleTerm direction=float<CR>",              desc = "Toggle floating terminal" },
  { "<leader>th", ":ToggleTerm direction=horizontal size=20<CR>", desc = "Toggle horizontal terminal" },
  { "<leader>tv", ":ToggleTerm direction=vertical size=60<CR>",   desc = "Toggle vertical terminal" },

  -- Close buffer
  { "<leader>b",  group = "buffers" },
  { "<leader>q",  ":lua Snacks.bufdelete()<CR>",                  desc = "Close buffer" },
  { "<leader>bd", ":lua Snacks.bufdelete()<CR>",                  desc = "Close buffer" },
  { "<leader>bo", ":lua Snacks.bufdelete.other()<CR>",            desc = "Close others buffers" },
  { "<leader>ba", ":lua Snacks.bufdelete.all()<CR>",              desc = "Close all buffers" },

  -- Files
  { "<leader>f",  group = "files" },
  { "<leader>ff", ":Telescope find_files<CR>",                    desc = "Find files" },
  { "<leader>fg", ":Telescope live_grep<CR>",                     desc = "Live grep" },
  { "<leader>fb", ":Telescope buffers<CR>",                       desc = "List buffers" },
  { "<leader>fh", ":Telescope help_tags<CR>",                     desc = "Help tags" },

  -- NvChad
  { "<leader>n",  group = "nvchad" },
  { "<leader>nt", ":lua require(\"nvchad.themes\").open()<CR>",   desc = "NvChad theme" },

  -- Create new buffer
  { "<leader>bn", ":enew<CR>",                                    desc = "New buffer" },
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

-- Add <C-hjkl> to move windows in terminal mode
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Move to left window" })
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Move to lower window" })
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Move to upper window" })
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Move to right window" })

-- Add <C-Esc> to exit terminal mode
vim.keymap.set("t", "<C-Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Comment with <leader>/ in normal and visual mode using Comment.nvim
vim.keymap.set("x", "<leader>/", function()
  vim.cmd.normal({ args = { vim.keycode("gc") } })
end, { desc = "Toggle comment" })

vim.keymap.set("n", "<leader>/", function()
  vim.cmd.normal({ args = { vim.keycode("gcc") } })
end, { desc = "Toggle comment" })

-- Add <C-s> for saving in all modes
map("n", "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true })
map("i", "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true })
map("v", "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true })
map("n", "gd", vim.lsp.buf.definition, {
  desc = "Go to Definition",
})
