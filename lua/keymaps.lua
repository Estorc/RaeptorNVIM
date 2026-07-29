local Plugins = require('utils.plugins')
local NVIM = require('utils.nvim')
local Icons = require('utils.icons')
local wk = require("which-key")

require('keymaps.commands')

function FindPluginFiles()
  require('telescope.builtin').find_files({ cwd = require('lazy.core.config').options.root })
end

wk.add({
  { "<C-h>",         "<C-w>h",                                       desc = "Move to left window" },
  { "<C-j>",         "<C-w>j",                                       desc = "Move to lower window" },
  { "<C-k>",         "<C-w>k",                                       desc = "Move to upper window" },
  { "<C-l>",         "<C-w>l",                                       desc = "Move to right window" },

  -- Terminal
  { "<leader>c",     group = "Terminal",                             icon = Icons.terminal },
  { "<leader>cc",    ":ToggleTerm direction=horizontal size=20<CR>", desc = "Toggle terminal",            icon = Icons.terminal },
  { "<leader>cf",    ":ToggleTerm direction=float<CR>",              desc = "Toggle floating terminal",   icon = Icons.terminal },
  { "<leader>ch",    ":ToggleTerm direction=horizontal size=20<CR>", desc = "Toggle horizontal terminal", icon = Icons.terminal },
  { "<leader>cv",    ":ToggleTerm direction=vertical size=60<CR>",   desc = "Toggle vertical terminal",   icon = Icons.terminal },

  -- Terminal mode: window navigation
  { "<C-h>",         [[<C-\><C-n><C-w>h]],                           desc = "Move to left window",        mode = "t" },
  { "<C-j>",         [[<C-\><C-n><C-w>j]],                           desc = "Move to lower window",       mode = "t" },
  { "<C-k>",         [[<C-\><C-n><C-w>k]],                           desc = "Move to upper window",       mode = "t" },
  { "<C-l>",         [[<C-\><C-n><C-w>l]],                           desc = "Move to right window",       mode = "t" },

  -- Terminal mode: exit
  { "<C-Esc>",       [[<C-\><C-n>]],                                 desc = "Exit terminal mode",         mode = "t" },
  { "<Esc><leader>", [[<C-\><C-n>]],                                 desc = "Exit terminal mode",         mode = "t" },

  -- Buffers
  { "<leader>b",     group = "Buffers",                              icon = Icons.buffer },
  { "<leader>bd",    ":lua Snacks.bufdelete()<CR>",                  desc = "Close buffer",               icon = Icons.removeFile },
  { "<leader>bo",    ":lua Snacks.bufdelete.other()<CR>",            desc = "Close others buffers",       icon = Icons.removeFile },
  { "<leader>ba",    ":lua Snacks.bufdelete.all()<CR>",              desc = "Close all buffers",          icon = Icons.removeFile },
  { "<leader>bn",    ":enew<CR>",                                    desc = "New buffer",                 icon = Icons.newFile },

  -- Files
  { "<leader>f",     group = "Files",                                icon = Icons.file },
  { "<leader>ff",    ":Telescope find_files<CR>",                    desc = "Search files" },
  { "<leader>fb",    ":Telescope buffers<CR>",                       desc = "Search opened files" },
  { "<leader>fp",    FindPluginFiles,                                desc = "Search plugin files" },


  -- NvChad
  { "<leader>n",     group = "NvChad",                               icon = Icons.vim },
  { "<leader>nt",    ":lua require(\"nvchad.themes\").open()<CR>",   desc = "NvChad theme" },

})

-- BarBar
if (Plugins.isPluginInstalled('barbar')) then
  wk.add({
    -- Buffer navigation
    { "<S-h>",       "<cmd>BufferPrevious<CR>",            desc = "Previous buffer" },
    { "<S-l>",       "<cmd>BufferNext<CR>",                desc = "Next buffer" },

    -- Re-order buffers
    { "<A-h>",       "<Cmd>BufferMovePrevious<CR>",        desc = "Move buffer left" },
    { "<A-l>",       "<Cmd>BufferMoveNext<CR>",            desc = "Move buffer right" },

    -- Goto buffer by position
    { "<A-1>",       "<Cmd>BufferGoto 1<CR>",              desc = "Go to buffer 1" },
    { "<A-2>",       "<Cmd>BufferGoto 2<CR>",              desc = "Go to buffer 2" },
    { "<A-3>",       "<Cmd>BufferGoto 3<CR>",              desc = "Go to buffer 3" },
    { "<A-4>",       "<Cmd>BufferGoto 4<CR>",              desc = "Go to buffer 4" },
    { "<A-5>",       "<Cmd>BufferGoto 5<CR>",              desc = "Go to buffer 5" },
    { "<A-6>",       "<Cmd>BufferGoto 6<CR>",              desc = "Go to buffer 6" },
    { "<A-7>",       "<Cmd>BufferGoto 7<CR>",              desc = "Go to buffer 7" },
    { "<A-8>",       "<Cmd>BufferGoto 8<CR>",              desc = "Go to buffer 8" },
    { "<A-9>",       "<Cmd>BufferGoto 9<CR>",              desc = "Go to buffer 9" },
    { "<A-0>",       "<Cmd>BufferLast<CR>",                desc = "Go to last buffer" },

    -- Pin/unpin
    { "<A-p>",       "<Cmd>BufferPin<CR>",                 desc = "Pin/unpin buffer" },

    -- Buffer picker
    { "<C-p>",       "<Cmd>BufferPick<CR>",                desc = "Pick buffer" },
    { "<C-S-p>",     "<Cmd>BufferPickDelete<CR>",          desc = "Pick buffer to delete" },

    -- Sort buffers
    { "<leader>bO",  group = 'Order buffers',              icon = Icons.sort },
    { "<leader>bOb", "<Cmd>BufferOrderByBufferNumber<CR>", desc = "Order by buffer number", icon = Icons.sort },
    { "<leader>bOn", "<Cmd>BufferOrderByName<CR>",         desc = "Order by name",          icon = Icons.sort },
    { "<leader>bOd", "<Cmd>BufferOrderByDirectory<CR>",    desc = "Order by directory",     icon = Icons.sort },
    { "<leader>bOl", "<Cmd>BufferOrderByLanguage<CR>",     desc = "Order by language",      icon = Icons.sort },
    { "<leader>bOw", "<Cmd>BufferOrderByWindowNumber<CR>", desc = "Order by window number", icon = Icons.sort },
  })
end

-- Search
wk.add({
  { "<leader>s",  group = "Search" },
  { "<leader>ss", ":Telescope live_grep<CR>", desc = "Search grep" },
  { "<leader>sg", ":GrugFarFloat<CR>",        desc = "Search Grug Far" },
  { "<leader>sh", ":Telescope help_tags<CR>", desc = "Search help tags" },
})

if (Plugins.isPluginInstalled('todo-comments')) then
  wk.add({
    { "<leader>st", ":TodoTelescope <CR>", desc = "Search Todo" },
  })
end

-- Triforce
if (Plugins.isPluginInstalled('triforce')) then
  wk.add({
    { "<leader>t",  group = "Triforce",               icon = Icons.triforce },
    { "<leader>ts", require('triforce').show_profile, desc = 'Show Triforce Stats' },
  })
end

wk.add({
  -- Git
  { "<leader>g", group = "git" },

  -- Toggles
  { '<leader>r', ":set relativenumber!<CR>",                                       desc = "Toggle relative number" },
  { "<leader>z", ":lua Snacks.zen({win = {width = 160}})<CR>",                     desc = "Toggle Zen Mode" },
  { "<leader>/", function() vim.cmd.normal({ args = { vim.keycode("gcc") } }) end, desc = "Toggle comment",        mode = "n" },
  { "<leader>/", function() vim.cmd.normal({ args = { vim.keycode("gc") } }) end,  desc = "Toggle comment",        mode = "x" },
})

-- Neo-tree
if (Plugins.isPluginInstalled('neo-tree')) then
  wk.add({
    { "<leader>e", "<cmd>Neotree toggle<cr>", noremap = true, silent = true, desc = "Toggle Neo-tree" },
  })
end

-- Classic
wk.add({
  { "<leader>x", NVIM.closeWindow,       desc = "Close window",     icon = Icons.close },
  { "<leader>q", NVIM.closeBuffer,       desc = "Close buffer",     icon = Icons.close },
  { "<leader>Q", NVIM.exit,              desc = "Quit NVIM" },
  { "<C-s>",     "<cmd>w<CR>",           desc = "Save file",        mode = { "n", "i", "v" }, silent = true, noremap = true },
  { "gd",        vim.lsp.buf.definition, desc = "Go to Definition", mode = "n" },
})


vim.schedule(function()
  local c30 = require("base46").get_theme_tb("base_30")

  vim.api.nvim_set_hl(0, 'WhichKeyDesc', { fg = "#ffffff" })
end)
