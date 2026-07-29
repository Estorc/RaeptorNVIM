vim.schedule(function()
  local c30 = require("base46").get_theme_tb("base_30")
  local c16 = require("base46").get_theme_tb("base_16")

  vim.api.nvim_set_hl(0, "StatusLine", {
    fg = c30.white,
    bg = c16.base00, -- or darker_black, one_bg, etc.
  })

  vim.api.nvim_set_hl(0, "StatusLineNC", {
    fg = c30.grey,
    bg = c16.base00,
  })

  require("base46").load_all_highlights()
end)
-- put this after lazy setup

-- (method 1, For heavy lazyloaders)
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- require("nvconfig").base46.theme = 'vscode'
-- require("base46").load_all_highlights()
