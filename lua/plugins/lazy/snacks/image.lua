return {
  -- lazy.nvim
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      image = {
        math = {
          enabled = false, -- enable math expression rendering
        }
      }
    }
  }
}
