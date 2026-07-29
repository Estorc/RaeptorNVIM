local Plugins = require("utils.plugins")

local colors = {
  blue       = '#80a0ff',
  blue_2     = '#99b3ff',
  blue_3     = '#b3c6ff',
  blue_4     = '#ccd9ff',
  blue_5     = '#e6ecff',

  cyan       = '#79dac8',
  black      = '#080808',
  light_grey = '#c6c6c6',
  white      = '#ffffff',
  red        = '#ff5189',

  violet     = '#d183e8',
  violet_2   = '#dab0ee',
  violet_3   = '#e3c1f3',
  violet_4   = '#ecd3f8',
  violet_5   = '#f6e9fc',

  grey       = '#303030',
  yellow     = '#e0af68',
  green      = '#9ece6a',
}

local middle_cache = { value = "", last = 0 }
local function lualine_middle()
  if Plugins.isPluginInstalled('triforce') then
    local now = vim.uv.now()                -- ms since startup
    if now - middle_cache.last > 10000 then -- 10s
      local stats = require('triforce').get_stats()
      local levels = require('triforce.levels').get_all_levels(stats)
      local maxLevel = { level = 0, title = "Unknown" }
      for _, level in pairs(levels) do
        if level.level > maxLevel.level and level.unlocked then
          maxLevel = level
        end
      end
      middle_cache.value = maxLevel.title .. " Lv." .. stats.level
      middle_cache.last = now
    end
    return middle_cache.value
  else
    return "RæptorNVIM - Plume"
  end
end


local function lualine_time()
  return os.date("%H:%M:%S")
end


local function lualine_lang()
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if not ok then
    return ""
  end

  local filetype = vim.bo.filetype
  if filetype == nil or filetype == "" then
    return ""
  end

  local language_icon = devicons.get_icon_by_filetype(filetype)
  if language_icon == nil then
    return ""
  end

  local language = filetype
  if language == "cpp" then
    language = "C++"
  else
    language = language:sub(1, 1):upper() .. language:sub(2)
  end

  return language_icon .. " " .. language
end

local function lualine_cmake()
  local ok, cmake = pcall(require, "cmake-tools")
  if not ok then
    return ""
  end

  if not cmake.is_cmake_project() then
    return ""
  end

  local res = ""

  local target = cmake.get_build_target()
  if target ~= nil then
    if type(target) == "table" then
      res = res .. " " .. table.concat(target)
    else
      res = res .. " " .. tostring(target)
    end
  end

  local build_type = cmake.get_build_type()
  if build_type ~= nil then
    res = res .. " [" .. build_type .. "]"
  end

  return res
end

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.light_grey, bg = colors.grey },
    c = { fg = colors.light_grey },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.light_grey, bg = colors.black },
    b = { fg = colors.light_grey, bg = colors.black },
    c = { fg = colors.light_grey },
  },
}

Plugins.configureSettings('lualine', {
  options = {
    icons_enabled = true,
    theme = bubbles_theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = { "alpha" },
      winbar = { "alpha" },
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
    lualine_b = {
      {
        lualine_time,
        icon = "",
        color = { fg = colors.black, bg = colors.violet_2, gui = "bold" },
        separator = { left = "", right = "" },
        padding = { left = 1, right = 1 },
      },
      {
        'filename',
        color = { fg = colors.black, bg = colors.violet_3, gui = 'bold' },
        separator = { left = '', right = '' },
        padding = { left = 1, right = 1 },
      },
      {
        'branch',
        color = { fg = colors.black, bg = colors.violet_4, gui = 'bold' },
        separator = { left = '', right = '' },
        padding = { left = 1, right = 1 },
      },
    },
    lualine_c = {
      '%=', --[[ add your center components here in place of this comment ]]
      {
        lualine_middle,
        color = { fg = colors.black, bg = colors.white, gui = "bold" },
        separator = { left = "", right = "" },
        padding = { left = 1, right = 1 },
      },
    },
    lualine_x = {},
    lualine_y = {
      {
        lualine_lang,
        color = { fg = colors.black, bg = colors.blue_4, gui = 'bold' },
        separator = { left = '', right = '' },
        padding = { left = 1, right = 1 },
      },
      {
        lualine_cmake,
        color = { fg = colors.black, bg = colors.blue_3, gui = 'bold' },
        separator = { left = '', right = '' },
        padding = { left = 1, right = 1 },
      },
      {
        'progress',
        color = { fg = colors.black, bg = colors.blue_2, gui = 'bold' },
        separator = { left = '', right = '' },
        padding = { left = 1, right = 1 },
      }
    },
    lualine_z = {
      {
        'location',
        color = { fg = colors.black, bg = colors.blue, gui = 'bold' },
        separator = { right = '' },
        left_padding = 2
      },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
})
