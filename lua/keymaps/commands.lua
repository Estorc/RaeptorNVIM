local NVIM = require('utils.nvim')

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
    vim.schedule(NVIM.closeBuffer)
    return "<C-u><CR>"
  elseif UsedCommand({ "close" }) then
    -- If a file buffer, only if empty or not the last
    vim.schedule(NVIM.closeWindow)
    return "<C-u><CR>"
  elseif UsedCommand({ "exit" }) then
    vim.schedule(function()
      NVIM.exit()
    end)
    return "<C-u><CR>"
  elseif UsedCommand({ "qa", "quitall", "qall", "quita" }) then
    vim.schedule(function()
      if (NVIM.isFileBuffer()) then
        Snacks.bufdelete.all()
        if #vim.fn.getbufinfo({ buflisted = 1 }) <= 1 and not vim.bo.modified then
          NVIM.closeAllWindowFileBuffer()
        end
      end
    end)
    return "<C-u><CR>"
  elseif UsedCommand({ "wq" }) then
    vim.cmd('write')
    vim.schedule(NVIM.closeBuffer)
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
