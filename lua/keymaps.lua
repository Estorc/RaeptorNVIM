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

local AZERTY = true
vim.schedule(function()
  local keymapsToDestroy = {
    { '&' }, -- defaults to { 'n' }
    { '<C-w>T' },
    { 'gt' },
    { 'gT' },
    { 'M' },
    { 'Y',     modes = { 'n', 'x' } },
    { '!',     modes = { 'n', 'x', 'o' } },
    { '%',     modes = { 'n', 'x', 'o' } },
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

  -- Groups
  wk.add({
    { '<leader>',      group = "Specials",  icon = Icons.keyboard,  mode = 'nxo' },
    { "<localleader>", group = "Local",     icon = Icons.keyboard,  mode = 'nxo' },

    { 'a',             group = 'Around',    icon = Icons.around,    mode = 'nox' },
    { 'i',             group = 'Inside',    icon = Icons.around,    mode = 'nox' },
    { '"',             group = 'Registers', icon = Icons.registers, mode = 'nxo' },
    { '`',             group = 'Marks',     icon = Icons.marks,     mode = 'nxo' },
    { '\'',            group = 'Marks',     icon = Icons.marks,     mode = 'nxo' },
    { 'g',             group = 'Global',    icon = Icons.braces,    mode = 'nxo' },
    { 'z',             group = 'View',      icon = Icons.view,      mode = 'nxo' },
    { '<C-w>',         group = 'Window',    icon = Icons.window,    mode = 'nxo' },
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


  wk.add({

    { "K", desc = "Read documentation",      icon = Icons.documentation },
    { 'd', 'd',                              mode = 'oxn',              desc = 'Delete',                icon = Icons.delete },
    { 'y', 'y',                              mode = 'oxn',              desc = 'Yank',                  icon = Icons.copy },
    { 'c', 'c',                              mode = 'oxn',              desc = 'Change',                icon = Icons.edit },
    { 'r', 'r',                              mode = 'oxn',              desc = 'Replace',               icon = Icons.edit },

    { '/', '/',                              mode = 'oxn',              desc = 'Search forward' },
    { '?', '?',                              mode = 'oxn',              desc = 'Search backward' },

    { 'h', 'h',                              mode = 'oxn',              desc = 'Left',                  icon = Icons.left },
    { 'j', 'j',                              mode = 'oxn',              desc = 'Down',                  icon = Icons.down },
    { 'k', 'k',                              mode = 'oxn',              desc = 'Up',                    icon = Icons.up },
    { 'l', 'l',                              mode = 'oxn',              desc = 'Right',                 icon = Icons.right },

    { '[', group = 'Move to previous token', icon = Icons.moveBackward, mode = 'nxo' },
    { ']', group = 'Move to next token',     icon = Icons.moveForward,  mode = 'nxo' },

    { 'w', 'w',                              mode = 'oxn',              desc = 'Next word',             icon = Icons.moveForward },
    { 'W', 'W',                              mode = 'oxn',              desc = 'Next WORD',             icon = Icons.moveForward },
    { 't', 't',                              mode = 'oxn',              desc = 'Move before next char', icon = Icons.moveForward },
    { 'T', 'T',                              mode = 'oxn',              desc = 'Move before prev char', icon = Icons.moveBackward },
    { 'b', 'b',                              mode = 'oxn',              desc = 'Prev word',             icon = Icons.moveBackward },
    { 'B', 'B',                              mode = 'oxn',              desc = 'Prev WORD',             icon = Icons.moveBackward },
    { 'e', 'e',                              mode = 'oxn',              desc = 'Next end of word',      icon = Icons.moveForward },
    { 'E', 'E',                              mode = 'oxn',              desc = 'Next end of WORD',      icon = Icons.moveForward },
    { ';', ';',                              mode = 'oxn',              desc = 'Next ftFT',             icon = Icons.moveForward },
    { ',', ',',                              mode = 'oxn',              desc = 'Prev ftFT',             icon = Icons.moveBackward },

    { '{', '{',                              mode = 'oxn',              desc = 'Prev empty line',       icon = Icons.moveBackward },
    { '}', '}',                              mode = 'oxn',              desc = 'Next empty line',       icon = Icons.moveForward },


    { '0', '0',                              mode = 'oxn',              desc = 'Start of line',         icon = Icons.start },
    { '^', '^',                              mode = 'oxn',              desc = 'Start of line (no ws)', icon = Icons.start },
    { '$', '$',                              mode = 'oxn',              desc = 'End of line',           icon = Icons.endd },

    { 'f', 'f',                              mode = 'oxn',              desc = 'Move to next char',     icon = Icons.moveForward },
    { 'F', 'F',                              mode = 'oxn',              desc = 'Move to prev char',     icon = Icons.moveBackward },
    { 't', 't',                              mode = 'oxn',              desc = 'Move before next char', icon = Icons.moveForward },
    { 'T', 'T',                              mode = 'oxn',              desc = 'Move before prev char', icon = Icons.moveBackward },
    { ';', ';',                              mode = 'oxn',              desc = 'Next ftFT',             icon = Icons.moveForward },
    { ',', ',',                              mode = 'oxn',              desc = 'Prev ftFT',             icon = Icons.moveBackward },

    { '>', '>gv',                            mode = 'x',                desc = 'Indent right',          icon = Icons.indentIncrease },
    { '<', '<gv',                            mode = 'x',                desc = 'Indent left',           icon = Icons.indentDecrease },
    { '>', '>',                              mode = 'n',                desc = 'Indent right',          icon = Icons.indentIncrease },
    { '<', '<',                              mode = 'n',                desc = 'Indent left',           icon = Icons.indentDecrease },

    { 'v', 'v',                              mode = 'xn',               desc = 'Visual',                icon = Icons.select },
    { 'V', 'V',                              mode = 'xn',               desc = 'Visual Line',           icon = Icons.select },

    { 'G', 'G',                              mode = 'oxn',              hidden = true },
  })

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

    { "<C-h>",         "<C-w>h",                                       desc = "Move to left window",        icon = Icons.windowLeft },
    { "<C-j>",         "<C-w>j",                                       desc = "Move to lower window",       icon = Icons.windowDown },
    { "<C-k>",         "<C-w>k",                                       desc = "Move to upper window",       icon = Icons.windowUp },
    { "<C-l>",         "<C-w>l",                                       desc = "Move to right window",       icon = Icons.windowRight },

    -- Terminal
    { "<leader>c",     group = "Terminal",                             icon = Icons.terminal },
    { "<leader>cc",    ":ToggleTerm direction=horizontal size=20<CR>", desc = "Toggle terminal",            icon = Icons.terminal },
    { "<leader>cf",    ":ToggleTerm direction=float<CR>",              desc = "Toggle floating terminal",   icon = Icons.terminal },
    { "<leader>ch",    ":ToggleTerm direction=horizontal size=20<CR>", desc = "Toggle horizontal terminal", icon = Icons.terminal },
    { "<leader>cv",    ":ToggleTerm direction=vertical size=60<CR>",   desc = "Toggle vertical terminal",   icon = Icons.terminal },

    -- Terminal mode: window navigation
    { "<C-h>",         [[<C-\><C-n><C-w>h]],                           desc = "Move to left window",        mode = "t",              icon = Icons.windowLeft },
    { "<C-j>",         [[<C-\><C-n><C-w>j]],                           desc = "Move to lower window",       mode = "t",              icon = Icons.windowDown },
    { "<C-k>",         [[<C-\><C-n><C-w>k]],                           desc = "Move to upper window",       mode = "t",              icon = Icons.windowUp },
    { "<C-l>",         [[<C-\><C-n><C-w>l]],                           desc = "Move to right window",       mode = "t",              icon = Icons.windowRight },

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
      { "<S-h>",       "<cmd>BufferPrevious<CR>",            desc = "Previous buffer",        icon = Icons.fileLeft },
      { "<S-l>",       "<cmd>BufferNext<CR>",                desc = "Next buffer",            icon = Icons.fileRight },

      -- Re-order buffers
      { "<A-h>",       "<Cmd>BufferMovePrevious<CR>",        desc = "Move buffer left",       icon = Icons.fileLeft },
      { "<A-l>",       "<Cmd>BufferMoveNext<CR>",            desc = "Move buffer right",      icon = Icons.fileRight },

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
      { "<A-p>",       "<Cmd>BufferPin<CR>",                 desc = "Pin/unpin buffer",       icon = Icons.pin },

      -- Buffer picker
      { "<C-p>",       "<Cmd>BufferPick<CR>",                desc = "Pick buffer",            icon = Icons.fileFind },
      { "<C-S-p>",     "<Cmd>BufferPickDelete<CR>",          desc = "Pick buffer to delete",  icon = Icons.fileFind },

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
    { "<C-s>",     "<cmd>w<CR>",           desc = "Save file",        mode = { "n", "i", "v" }, silent = true, noremap = true, icon = Icons.save },
    { "gd",        vim.lsp.buf.definition, desc = "Go to Definition", mode = "n" },
    { '~',         '~',                    mode = 'oxn',              desc = 'Toggle case' },
  })
end)
