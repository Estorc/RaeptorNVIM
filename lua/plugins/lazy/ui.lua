local FS = require("utils.fs")
return {
  { "MunifTanjim/nui.nvim" },
  { "goolord/alpha-nvim",             dependencies = { 'nvim-tree/nvim-web-devicons' } },
  { 'nvim-lualine/lualine.nvim',      dependencies = { 'nvim-tree/nvim-web-devicons' } },
  { 'saghen/blink.cmp',               dependencies = { 'saghen/blink.lib', 'rafamadriz/friendly-snippets' }, version = '1.*' },
  { 'rcarriga/nvim-notify' },
  { "folke/noice.nvim",               dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },     event = "VeryLazy", },
  { "nvim-lua/plenary.nvim" },
  { "petertriho/nvim-scrollbar" },
  -- { "3rd/image.nvim" },
  { 'kevinhwang91/nvim-ufo',          dependencies = 'kevinhwang91/promise-async' },
  { "nvim-zh/colorful-winsep.nvim",   config = true,                                                         event = { "WinLeave" } },
  { 'Tyler-Barham/floating-help.nvim' },
  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    config = function(_, opts)
      require("showkeys").setup(opts)
      local state = require "showkeys.state"
      local mod = require('showkeys.utils')
      local update_win_w = function()
        local keyslen = #state.keys
        state.w = keyslen + 1 + (2 * keyslen) -- 2 spaces around each key

        for _, v in ipairs(state.keys) do
          state.w = state.w + vim.fn.strwidth(v.txt)
        end

        mod.gen_winconfig()
        if (state.win and vim.api.nvim_win_is_valid(state.win)) then
          vim.api.nvim_win_set_config(state.win, state.config.winopts)
        end
      end

      mod.redraw = function()
        update_win_w()
        mod.draw()
      end

      mod.clear_and_close = function()
        state.keys = {}
        mod.redraw()
        local tmp = state.win
        state.win = nil
        if (tmp and vim.api.nvim_win_is_valid(tmp)) then
          vim.api.nvim_win_close(tmp, true)
        end
      end
    end
  },
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { 'Bekaboo/dropbar.nvim',     dependencies = { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
  FS.globRequire("plugins.lazy.editor"),
  FS.globRequire("plugins.lazy.dap"),
  FS.globRequire("plugins.lazy.nvchad"),
  FS.globRequire("plugins.lazy.markdown"),
}
