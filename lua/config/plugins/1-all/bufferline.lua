local Plugins = require("utils.plugins")


Plugins.configureSettings('bufferline', {
  options = {
    mode = "buffers",
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        separator = true,
        text_align = "left",
      },
    },
  },
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = { "alpha" },
  callback = function()
    vim.opt_local.showtabline = 0
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.filetype ~= "alpha" then
      vim.opt.showtabline = 2
    end
  end,
})

local colors = require("base46").get_theme_tb("base_30")

vim.api.nvim_set_hl(0, "BufferLineFill", {
  bg = colors.darker_black,
})
