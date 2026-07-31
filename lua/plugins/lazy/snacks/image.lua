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
    },
    init = function()
      -- Workaround: Force Snacks to re-render images on buffer switch
      vim.api.nvim_create_autocmd("BufWinEnter", {
        pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
        callback = function(args)
          vim.schedule(function()
            -- Ensure the buffer is still valid before applying the setting
            if vim.api.nvim_buf_is_valid(args.buf) then
              -- Unload the buffer when hidden. When you switch back,
              -- Neovim is forced to reload it, re-triggering the Snacks viewer.
              vim.bo[args.buf].bufhidden = "unload"
            end
          end)
        end,
      })
    end,
  }
}
