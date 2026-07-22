vim.schedule(function()
  local c30 = require("base46").get_theme_tb("base_30")

  vim.api.nvim_set_hl(0, 'St_lang_sep', { fg = "#3d88d3" })
  vim.api.nvim_set_hl(0, 'St_lang', { fg = c30.white, bg = "#3d88d3" })
  vim.api.nvim_set_hl(0, 'St_lang_text', { fg = c30.white, bg = c30.lightbg })

  vim.api.nvim_set_hl(0, 'St_cmake_sep', { fg = "#b28b3c", bg = c30.lightbg })
  vim.api.nvim_set_hl(0, 'St_cmake', { fg = c30.white, bg = "#b28b3c" })
  vim.api.nvim_set_hl(0, 'St_cmake_text', { fg = c30.white, bg = c30.lightbg })

  vim.api.nvim_set_hl(0, 'St_cwd_sep', { fg = c30.red, bg = c30.lightbg })
  vim.api.nvim_set_hl(0, 'St_cwd', { fg = c30.white, bg = c30.red })
  vim.api.nvim_set_hl(0, 'St_cwd_text', { fg = c30.white, bg = c30.lightbg })

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

local options = {
  base46 = {
    theme = "vscode", -- default theme
  },
  ui = {
    cmp = {
      enabled = false,
    },

    telescope = { style = "bordered" }, -- borderless / bordered

    statusline = {
      enabled = false,
      theme = "default",
      separator_style = "default",
      order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "lang", "cmake", "cwd", "cursor", "percent" },
      modules = {
        percent = "%p%%",
        lang = function()
          if (vim.bo.filetype == nil or require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype) == nil) then
            return ""
          end
          local language = vim.bo.filetype
          if (language == "cpp") then language = "C++" end
          -- ensure first letter is uppercase
          language = language:sub(1, 1):upper() .. language:sub(2)
          local language_icon = require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype)
          return "%#St_lang_sep#\u{E0B6}%#St_lang#" .. language_icon .. " %#St_cmake_text# " .. language .. " "
        end,
        cmake = function()
          local cmake = require("cmake-tools")
          if (not cmake.is_cmake_project()) then return "" end
          local res = "%#St_cmake_sep#\u{E0B6}%#St_cmake#\u{E794} %#St_cmake_text# "
          if (cmake.get_build_target() ~= nil) then
            res = res .. table.concat(cmake.get_build_target()) .. " "
          end
          if (cmake.get_build_type() ~= nil) then
            res = res .. "[" .. cmake.get_build_type() .. "]" .. " "
          end
          return res
        end,
      }
    },

    -- lazyload it when there are 1+ buffers
    tabufline = {
      enabled = false,
    },
  },

  nvdash = {
    enabled = false,
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

  cheatsheet = {
    enabled = false,
  },

  mason = { pkgs = {}, skip = {} },

  colorify = {
    enabled = true,
    mode = "virtual", -- fg, bg, virtual
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
  },
}


return options
