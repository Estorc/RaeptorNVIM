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
