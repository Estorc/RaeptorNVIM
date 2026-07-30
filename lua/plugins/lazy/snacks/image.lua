return {
  -- lazy.nvim
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      image = {
        convert = {
          magick = {
            default = {
              "{src}[0]",
              "-filter",
              "point",
              "-resize",
              "1920x1080>",
            },
          },
        },
        math = {
          enabled = false, -- enable math expression rendering
        }
      }
    }
  }
}
