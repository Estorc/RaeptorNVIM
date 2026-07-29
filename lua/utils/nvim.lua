local NVIM
NVIM = {
  isFileBuffer = function(buffer)
    if buffer then
      return vim.bo[buffer].buftype == '' or
          (vim.bo[buffer].buftype == 'nowrite' and vim.bo[buffer].filetype == 'image_nvim')
    else
      return vim.bo.buftype == '' or (vim.bo.buftype == 'nowrite' and vim.bo.filetype == 'image_nvim')
    end
  end,

  exit = function()
    if vim.fn.confirm("Quit NVIM?", "&Yes\n&No", 2) == 1 then
      vim.cmd("quitall!")
    end
  end,

  closeAllWindowFileBuffer = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)

      if NVIM.isFileBuffer(buf) then
        vim.api.nvim_win_close(win, true)
      end
    end
    -- Close the possible last file buffers
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if NVIM.isFileBuffer(buf) then
        vim.bo[buf].buflisted = false
      end
    end
  end,

  countFileBuffer = function()
    local count = 0

    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)

      if NVIM.isFileBuffer(buf) then
        count = count + 1
      end
    end

    return count
  end,

  closeWindow = function()
    if (not NVIM.isFileBuffer()) or NVIM.countFileBuffer() > 1 then
      vim.cmd('close')
    end
  end,

  closeBuffer = function()
    local isAFileBuffer = NVIM.isFileBuffer()
    if #vim.fn.getbufinfo({ buflisted = 1 }) <= 1 then
      if vim.bo.modified then
        local filename = vim.api.nvim_buf_get_name(0);
        local newFile = false
        if (filename == '') then
          -- Ask for name for the file, empty = no save
          filename = vim.fn.input("Save file as: ")
          newFile = true
        end
        if (filename ~= '') then
          local result = vim.fn.confirm("Save changes to \"" .. filename .. "\"?", "&Yes\n&No\n&Cancel",
            2)
          if result == 1 then
            vim.cmd("w " .. filename)
          end
          if result == 2 and not newFile then
            vim.cmd("edit!")
          end
          if result == 3 then
            return
          end
        end
      end
      vim.cmd('q')
      if isAFileBuffer then
        NVIM.closeAllWindowFileBuffer()
      end
    else
      if vim.bo.filetype == 'neo-tree' then
        vim.cmd('Neotree close')
        return
      end
      Snacks.bufdelete()
      if not isAFileBuffer then
        NVIM.closeWindow()
      end
    end
  end,
}
return NVIM
