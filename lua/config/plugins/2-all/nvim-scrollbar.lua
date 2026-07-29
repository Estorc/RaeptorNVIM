require("scrollbar").setup({
  handlers = {
    cursor = false,
  },
  excluded_buftypes = {
    -- lsp hover, signature help, etc.
    "nofile",
  },
  excluded_filetypes = {
  },
})
