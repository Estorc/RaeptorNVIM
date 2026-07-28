return {
  { "ankushbhagats/match.nvim" },
  {
    'MagicDuck/grug-far.nvim',
    config = function()
      local utils = require("grug-far.utils")

      local original = utils.getOpenTargetWin

      utils.getOpenTargetWin = function(context, buf)
        -- If grug-far itself is floating, force using a normal window
        local current = vim.api.nvim_get_current_win()
        if vim.api.nvim_win_get_config(current).relative ~= "" then
          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(win).relative == "" then
              context.prevWin = win
              break
            end
          end
        end

        vim.api.nvim_win_close(current, true)

        return original(context, buf)
      end

      require("grug-far").setup({
        -- your config
      })
    end,
  },
}
