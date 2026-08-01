local Plugins = require("utils.plugins")

local function get_icon(_, item)
  if not item or not item.levels then
    return "";
  end

  local output = "◈ ";

  for l, level in ipairs(item.levels) do
    if level ~= 0 then
      output = output .. level .. (l ~= #item.levels and "." or "");
    end
  end

  return output .. " ";
end

Plugins.configureSettings("markview", {
  markdown_inline = {
    tags = {
      default = {
        hl = "MarkviewCodeInfo",
        padding_left = "",
        padding_left_hl = "MarkviewCodeFg",
        padding_right = "",
        padding_right_hl = "MarkviewCodeFg"
      },
      enable = true
    }
  },
  markdown = {
    headings = {
      heading_1 = { icon_hl = "@markup.link", icon = get_icon },
      heading_2 = { icon_hl = "@markup.link", icon = get_icon },
      heading_3 = { icon_hl = "@markup.link", icon = get_icon }
    },
  },
})

if (Plugins.isPluginInstalled('markview')) then
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn = "no"
      vim.opt_local.statuscolumn = ""

      vim.opt_local.wrap = false
      vim.opt_local.cursorcolumn = false
      vim.opt_local.foldcolumn = "0"
      vim.opt_local.list = false
      vim.opt_local.spell = false
    end,
  })
end
