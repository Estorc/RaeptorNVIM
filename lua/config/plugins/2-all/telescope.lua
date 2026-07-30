local Plugins = require("utils.plugins")

Plugins.configureSettings("telescope", {
  defaults = {
    layout_strategy = "horizontal",
    layout_config = { prompt_position = "top" },
    sorting_strategy = "ascending",
    winblend = 0,
    preview = {
      mime_hook = function(filepath, bufnr, opts)
        local is_image = function(image_filepath)
          -- catimg
          local image_extensions = { "png", "jpg", "ico" } -- Supported image formats
          local split_path = vim.split(image_filepath:lower(), ".", { plain = true })
          local extension = split_path[#split_path]
          return vim.tbl_contains(image_extensions, extension)
        end
        if is_image(filepath) then
          local term = vim.api.nvim_open_term(bufnr, {})
          local function send_output(_, data, _)
            for _, d in ipairs(data) do
              vim.api.nvim_chan_send(term, d .. "\r\n")
            end
          end
          vim.fn.jobstart({
            "kitten",
            "icat",
            filepath, -- Terminal image viewer command
          }, { on_stdout = send_output, stdout_buffered = true, pty = true })
        else
          require("telescope.previewers.utils").set_preview_message(
            bufnr,
            opts.winid,
            "Binary cannot be previewed"
          )
        end
      end,
    },

  },
})
