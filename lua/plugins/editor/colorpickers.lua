return {
  {
    "mikevskater/nvim-colorpicker",
    dependencies = { "mikevskater/nvim-float" },
    cmd = { "ColorPicker", "ColorPickerAtCursor", "ColorPickerMini" },
    keys = {
      { "<leader>cp", "<Plug>(colorpicker)",                  desc = "Color Picker" },
      { "<leader>cc", "<Plug>(colorpicker-at-cursor)",        desc = "Pick at Cursor" },
      { "<leader>cm", "<Plug>(colorpicker-mini)",             desc = "Mini Picker" },
      { "<leader>ch", "<Plug>(colorpicker-highlight-toggle)", desc = "Toggle Highlighting" },
    },
    opts = {
      alpha_enabled = true,
      presets = { "web", "tailwind" },
      highlight = {
        enable = true,
        filetypes = { "css", "scss", "html" },
      },
    },
  },
  {
    "eero-lehtinen/oklch-color-picker.nvim",
    event = "VeryLazy",
    version = "*",
    keys = {
      {
        "<leader>v",
        function() require("oklch-color-picker").pick_under_cursor() end,
        desc = "Color pick under cursor",
      },
    },
    ---@type oklch.Opts
    opts = {
      highlight = {
        enabled = false
      }
    },
  }
}
