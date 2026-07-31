local Plugins = require('utils.plugins')
local NVIM = require('utils.nvim')
local Icons = require('utils.icons')
local wk = require("which-key")

require('keymaps.commands')

function FindPluginFiles()
  Snacks.picker.files({ cwd = require('lazy.core.config').options.root })
end

local function TableConcat(t1, t2)
  -- loop over t2 items
  for _, v in ipairs(t2) do
    -- append entries to t1
    table.insert(t1, v)
  end
  -- return merged table
  return t1
end

-- o  %             <Plug>(MatchitOperationForward)
-- x  %             <Plug>(MatchitVisualForward)
-- n  %             <Plug>(MatchitNormalForward)

local AZERTY = true
vim.schedule(function()
  local keymapsToDestroy = {
    { '&' }, -- defaults to { 'n' }
    { 'Y', modes = { 'n', 'x' } },
    { '!', modes = { 'n', 'x', 'o' } },
    { '%', modes = { 'n', 'x', 'o' } },
  }

  if AZERTY then
    keymapsToDestroy = TableConcat(keymapsToDestroy, {
    })
  end

  for _, keymapToDestroy in ipairs(keymapsToDestroy) do
    local key = keymapToDestroy[1]
    local modes = keymapToDestroy.modes or { 'n' }

    if type(modes) == 'string' then
      modes = { modes }
    end

    for _, mode in ipairs(modes) do
      pcall(vim.keymap.del, mode, key)
      wk.add({
        { key, '<Nop>', noremap = true, silent = true, mode = mode, hidden = true }
      })
    end
  end

  if AZERTY then
    wk.add({
      { 'ù', '<Plug>(MatchitNormalForward)',    mode = 'n', desc = 'Matching (){}[]', icon = Icons.braces },
      { 'ù', '<Plug>(MatchitVisualForward)',    mode = 'x', desc = 'Matching (){}[]', icon = Icons.braces },
      { 'ù', '<Plug>(MatchitOperationForward)', mode = 'o', desc = 'Matching (){}[]', icon = Icons.braces },
    })
  else
    wk.add({
      { '%', '<Plug>(MatchitNormalForward)',    mode = 'n', desc = 'Matching (){}[]' },
      { '%', '<Plug>(MatchitVisualForward)',    mode = 'x', desc = 'Matching (){}[]' },
      { '%', '<Plug>(MatchitOperationForward)', mode = 'o', desc = 'Matching (){}[]' },
    })
  end
  wk.add({
    { '$', '$',   mode = 'oxn', desc = 'End of line',  icon = Icons.endd },

    { '>', '>gv', mode = 'x',   desc = 'Indent right', icon = Icons.indent_increase },
    { '<', '<gv', mode = 'x',   desc = 'Indent left',  icon = Icons.indent_decrease },
    { '>', '>',   mode = 'n',   desc = 'Indent right', icon = Icons.indent_increase },
    { '<', '<',   mode = 'n',   desc = 'Indent left',  icon = Icons.indent_decrease },

    { 'v', 'v',   mode = 'oxn', desc = 'Visual',       icon = Icons.select },
    { 'V', 'V',   mode = 'oxn', desc = 'Visual Line',  icon = Icons.select },
  })


  wk.add({
    { '<leader>',      group = "Specials",                             icon = Icons.keyboard },
    { "<localleader>", group = "Local",                                icon = Icons.keyboard },

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
    { "<leader>ff",    Snacks.picker.files,                            desc = "Search files" },
    { "<leader>fb",    Snacks.picker.buffers,                          desc = "Search opened files" },
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
      -- { "<A-1>",       "<Cmd>BufferGoto 1<CR>",              desc = "Go to buffer 1" },
      -- { "<A-2>",       "<Cmd>BufferGoto 2<CR>",              desc = "Go to buffer 2" },
      -- { "<A-3>",       "<Cmd>BufferGoto 3<CR>",              desc = "Go to buffer 3" },
      -- { "<A-4>",       "<Cmd>BufferGoto 4<CR>",              desc = "Go to buffer 4" },
      -- { "<A-5>",       "<Cmd>BufferGoto 5<CR>",              desc = "Go to buffer 5" },
      -- { "<A-6>",       "<Cmd>BufferGoto 6<CR>",              desc = "Go to buffer 6" },
      -- { "<A-7>",       "<Cmd>BufferGoto 7<CR>",              desc = "Go to buffer 7" },
      -- { "<A-8>",       "<Cmd>BufferGoto 8<CR>",              desc = "Go to buffer 8" },
      -- { "<A-9>",       "<Cmd>BufferGoto 9<CR>",              desc = "Go to buffer 9" },
      -- { "<A-0>",       "<Cmd>BufferLast<CR>",                desc = "Go to last buffer" },

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
    { "<leader>s", group = "Search" },
  })

  if (Plugins.isPluginInstalled('grug-far')) then
    wk.add({
      { "<leader>sg", ":GrugFarFloat<CR>", desc = "Search Grug Far" },
    })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { 'grug-far' },
      callback = function()
        wk.add({ "<ESC>", NVIM.closeBuffer, desc = "Close GrugFar", buffer = true })
      end
    })
  end

  if (Plugins.isPluginInstalled('snacks')) then
    wk.add({
      { "<leader>ss", Snacks.picker.grep, desc = "Search grep" },
      { "<leader>sh", Snacks.picker.help, desc = "Search help tags" },
    })
  end

  if (Plugins.isPluginInstalled('todo-comments')) then
    wk.add({
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" }
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

  -- Markview Checkbox
  if (Plugins.isPluginInstalled('markview')) then
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { 'markdown' },
      callback = function()
        wk.add({ "<localleader>m", "<cmd>Checkbox toggle<cr>", desc = "Toggle checkbox", buffer = true })
      end
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

  -- Floating help
  if (Plugins.isPluginInstalled('floating-help')) then
    local fh = require('floating-help')
    wk.add({
      { '<F1>', fh.toggle,                                                    desc = 'Open help',   icon = Icons.help },
      { '<F2>', function() fh.open('t=cppman', vim.fn.expand('<cword>')) end, desc = 'Open cppman', icon = Icons.help },
      { '<F3>', function() fh.open('t=man', vim.fn.expand('<cword>')) end,    desc = 'Open man',    icon = Icons.help },
    })
  end


  vim.schedule(function()
    local c30 = require("base46").get_theme_tb("base_30")

    vim.api.nvim_set_hl(0, 'WhichKeyDesc', { fg = "#ffffff" })
  end)
end)
