require("colorful-winsep").setup({
  border = { "─", "│", "╭", "╮", "╰", "╯" },
  colors = { "#c3c3c3" },
  indicator_for_2wins = {
    -- only work when the total of windows is two
    position = false, -- false to disable or choose between "center", "start", "end" and "both"
  },
})
