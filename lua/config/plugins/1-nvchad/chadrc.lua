local options = {
  base46 = {
    theme = "vscode", -- default theme
    hl_override = {
      WhichKeyDesc = {
        fg = "#ffffff", -- any color
        bold = false,
        italic = false,
      },
      WhichKeyGroup = {
        fg = "#b3eb7a", -- any color
        bold = true,
        italic = false,
      },
    },
  },
  colorify = {
    enabled = true,
    mode = "virtual", -- fg, bg, virtual
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
  },
  term = {
    base46_colors = true,
    winopts = { number = false },
    sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
    float = {
      relative = "editor",
      row = 0.3,
      col = 0.25,
      width = 0.5,
      height = 0.4,
      border = "single",
    },
  },
  lsp = { signature = true },
  ui = {
    telescope = { style = "bordered" }, -- borderless / bordered

    cmp = { enabled = false },
    statusline = { enabled = false },
    tabufline = { enabled = false },
  },
  nvdash = { enabled = false },
  cheatsheet = { enabled = false },
  mason = { pkgs = {}, skip = {} },
}


return options
