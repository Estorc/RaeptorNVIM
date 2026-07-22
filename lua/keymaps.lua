local map = vim.keymap.set

local wk = require("which-key")


function ExitNVIM()
  if vim.fn.confirm("Quit NVIM?", "&Yes\n&No", 2) == 1 then
    vim.cmd("quitall!")
  end
end

function CloseAllWindowFileBuffer()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)

    if vim.bo[buf].buftype == "" then
      vim.api.nvim_win_close(win, true)
    end
  end
  -- Close the possible last file buffers
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "" then
      vim.bo[buf].buflisted = false
    end
  end
end

function CloseWindow()
  if vim.bo.buftype ~= '' or CountFileBuffer() > 1 then
    vim.cmd('close')
  end
end

function CloseBuffer()
  local isAFileBuffer = vim.bo.buftype == ''
  if #vim.fn.getbufinfo({ buflisted = 1 }) <= 1 then
    if vim.bo.modified then
      local result = vim.fn.confirm("Save changes to \"" .. vim.api.nvim_buf_get_name(0) .. "\"?", "&Yes\n&No\n&Cancel",
        2)
      if result == 1 then
        vim.cmd("w")
      end
      if result == 2 then
        vim.cmd("edit!")
      end
      if result == 3 then
        return
      end
    end
    vim.cmd('q')
    if isAFileBuffer then
      CloseAllWindowFileBuffer()
    end
  else
    if vim.bo.filetype == 'neo-tree' then
      vim.cmd('Neotree close')
      return
    end
    Snacks.bufdelete()
    if not isAFileBuffer then
      CloseWindow()
    end
  end
end

function CountFileBuffer()
  local count = 0

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)

    if vim.bo[buf].buftype == "" then
      count = count + 1
    end
  end

  return count
end

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
  {
    "<leader>q",
    CloseBuffer,
    desc = "Close buffer"
  },
  { "<leader>bd", ":lua Snacks.bufdelete()<CR>",                desc = "Close buffer" },
  { "<leader>bo", ":lua Snacks.bufdelete.other()<CR>",          desc = "Close others buffers" },
  { "<leader>ba", ":lua Snacks.bufdelete.all()<CR>",            desc = "Close all buffers" },

  -- Files
  { "<leader>f",  group = "files" },
  { "<leader>ff", ":Telescope find_files<CR>",                  desc = "Find files" },
  { "<leader>fg", ":Telescope live_grep<CR>",                   desc = "Live grep" },
  { "<leader>fb", ":Telescope buffers<CR>",                     desc = "List buffers" },
  { "<leader>fh", ":Telescope help_tags<CR>",                   desc = "Help tags" },

  -- NvChad
  { "<leader>n",  group = "nvchad" },
  { "<leader>nt", ":lua require(\"nvchad.themes\").open()<CR>", desc = "NvChad theme" },

  -- Create new buffer
  { "<leader>bn", ":enew<CR>",                                  desc = "New buffer" },
  {
    "<leader>Q",
    ExitNVIM,
    desc = "Quit NVIM"
  },
  {
    "<leader>x",
    CloseWindow,
    desc = "Close window"
  },
  {
    '<leader>r',
    ":set relativenumber!<CR>",
    desc = "Toggle relative number"
  }
})

-- Add <C-hjkl> to move windows in terminal mode
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Move to left window" })
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Move to lower window" })
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Move to upper window" })
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Move to right window" })

-- Add <C-Esc> to exit terminal mode
map("t", "<C-Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
map("t", "<Esc><leader>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })


-- Comment with <leader>/ in normal and visual mode using Comment.nvim
map("x", "<leader>/", function()
  vim.cmd.normal({ args = { vim.keycode("gc") } })
end, { desc = "Toggle comment" })

map("n", "<leader>/", function()
  vim.cmd.normal({ args = { vim.keycode("gcc") } })
end, { desc = "Toggle comment" })

-- Add <C-s> for saving in all modes
map("n", "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true })
map("i", "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true })
map("v", "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true })
map("n", "gd", vim.lsp.buf.definition, {
  desc = "Go to Definition",
})

function UsedCommand(command_list)
  if vim.fn.getcmdtype() == ":" then
    for _, command in ipairs(command_list) do
      local pattern = "%f[%w]" .. command .. "!?%f[%W]"
      if vim.fn.getcmdline():match(pattern) then
        return true
      end
    end
  end
  return false
end

-- Disable :q :wq :q! :wq!, etc
vim.keymap.set("c", "<CR>", function()
  if UsedCommand({ "q", "quit" }) then
    vim.schedule(CloseBuffer)
    return "<C-u><CR>"
  elseif UsedCommand({ "close" }) then
    -- If a file buffer, only if empty or not the last
    vim.schedule(CloseWindow)
    return "<C-u><CR>"
  elseif UsedCommand({ "exit" }) then
    vim.schedule(function()
      ExitNVIM()
    end)
    return "<C-u><CR>"
  elseif UsedCommand({ "qa", "quitall", "qall", "quita" }) then
    vim.schedule(function()
      if (vim.bo.buftype == '') then
        Snacks.bufdelete.all()
        if #vim.fn.getbufinfo({ buflisted = 1 }) <= 1 and not vim.bo.modified then
          CloseAllWindowFileBuffer()
        end
      end
    end)
    return "<C-u><CR>"
  elseif UsedCommand({ "wq" }) then
    vim.cmd('write')
    vim.schedule(CloseBuffer)
    return "<C-u><CR>"
  elseif UsedCommand({}) then
    vim.schedule(function()
      vim.notify("VIM command was disabled to prevent layout breaking.", vim.log.levels.INFO)
    end)
    return "<C-u><CR>"
  else
    return "<CR>"
  end
end, { expr = true })
