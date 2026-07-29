local Plugins = require("utils.plugins")

vim.g.barbar_auto_setup = false
Plugins.configureSettings('barbar', {
  auto_hide = true,
  sidebar_filetypes = {
    ['neo-tree'] = { text = '󱋣 File Explorer', align = 'center', event = "BufWipeout", }
  },
})

if (Plugins.isPluginInstalled('barbar')) then
  vim.schedule(function()
    local colors = require("base46").get_theme_tb("base_30")

    vim.api.nvim_set_hl(0, "BufferLineFill", {
      bg = colors.darker_black,
    })
    vim.api.nvim_set_hl(0, "TabLineFill", {
      bg = colors.darker_black,
    })
    vim.api.nvim_set_hl(0, "BufferTabpageFill", {
      bg = colors.darker_black,
    })

    vim.api.nvim_set_hl(0, "BufferInactive", {
      fg = "#909090",
    })
    vim.api.nvim_set_hl(0, "BufferInactiveIndex", {
      fg = "#909090",
    })

    vim.api.nvim_set_hl(0, "BufferVisible", {
      fg = "#909090",
    })
    vim.api.nvim_set_hl(0, "BufferVisibleIndex", {
      fg = "#909090",
    })
    create_autocmd(close_events, {
      buffer = tbl.buf,
      callback = function()
        if widths[side] then
          widths[side][ft] = nil
          api.set_offset(total_widths(side), nil, nil, side, {})
        end
        pcall(del_autocmd, autocmd)
      end,
      group = augroup_render,
      once = true,
    })
  end)
end
