local Plugins = require("utils.plugins")

Plugins.configureSettings('triforce', {
  -- Enable/disable the entire plugin
  enabled = true,

  -- Select what icon engine to use to provide with filetype icons:
  --
  -- - `'builtin'` - Use the built-in icons (default)
  -- - `'mini'` - Use `mini.icons`
  icon_engine = 'builtin', ---@type 'builtin'|'mini'

  -- Enable XP, levels, achievements
  gamification_enabled = true,

  -- Backdrop control
  backdrop = {
    -- Whether to enable the backdrop (i.e. enable background dimming).
    -- CREDITS: https://github.com/gisketch/triforce.nvim/issues/50
    enabled = true,

    -- See `:h 'winblend'`
    winblend = 20,
  },

  -- Custom levels
  levels = {
    { level = 10, title = 'Deku Scrub', icon = '🌱' },
    { level = 20, title = 'Kokiri', icon = '🌳' },
    { level = 30, title = 'Hylian Soldier', icon = '🗡️' },
    { level = 40, title = 'Knight', icon = '⚔️' },
    { level = 50, title = 'Royal Guard', icon = '🛡️' },
    { level = 60, title = 'Master Swordsman', icon = '⚡' },
    { level = 70, title = 'Hero of Time', icon = '🔺' },
    { level = 80, title = 'Sage', icon = '✨' },
    { level = 90, title = 'Triforce Bearer', icon = '🔱' },
    { level = 100, title = 'Champion', icon = '👑' },
    { level = 120, title = 'Divine Beast Pilot', icon = '🦅' },
    { level = 150, title = 'Ancient Hero', icon = '🏛️' },
    { level = 180, title = 'Legendary Warrior', icon = '⚜️' },
    { level = 200, title = 'Goddess Chosen', icon = '🌟' },
    { level = 250, title = 'Demise Slayer', icon = '💀' },
    { level = 300, title = 'Eternal Legend', icon = '💫' },
    { level = 500, title = 'Kaze Emanuar', icon = '🖥️' },
  },

  -- Don't include the default levels (needs custom levels).
  override_levels = true,

  -- Custom achievements
  achievements = {},

  -- Notification settings
  notifications = {
    -- Master toggle for all notifications
    enabled = true,

    -- Show level up notifications
    level_up = true,

    -- Show achievement unlock notifications
    achievements = true,
  },

  -- Auto-save interval (in seconds)
  auto_save_interval = 300, -- Save stats every 5 minutes

  -- Add custom language support
  custom_languages = {
    gleam = { icon = '✨', name = 'Gleam' },
    odin = { icon = '🔷', name = 'Odin' },
    -- Add more languages...
  },

  -- Customize level progression (optional)
  level_progression = {
    tier_1 = { min_level = 1, max_level = 10, xp_per_level = 500 },
    tier_2 = { min_level = 11, max_level = 20, xp_per_level = 750 },
    tier_3 = { min_level = 21, max_level = 30, xp_per_level = 1250 },
    tier_4 = { min_level = 31, max_level = 40, xp_per_level = 2500 },
    tier_5 = { min_level = 41, max_level = 50, xp_per_level = 3750 },
    tier_6 = { min_level = 51, max_level = 75, xp_per_level = 5000 },
    tier_7 = { min_level = 76, max_level = 100, xp_per_level = 10000 },
    tier_8 = { min_level = 101, max_level = 150, xp_per_level = 12500 },
    tier_9 = { min_level = 151, max_level = 225, xp_per_level = 15000 },
    tier_10 = { min_level = 226, max_level = math.huge, xp_per_level = 25000 },
  },

  -- Customize XP rewards (optional)
  xp_rewards = {
    char = 1,  -- XP per character typed
    line = 1,  -- XP per new line
    save = 50, -- XP per file save
  },

  -- Add filetypes to be excluded
  ignore_ft = {},

  -- Override heatmap highlight groups (hex colors or existing hl groups)
  heat_highlights = {
    TriforceHeat1 = '#f0f0a0',
    TriforceHeat2 = '#f0a0a0',
    TriforceHeat3 = '#a0a0a0',
    TriforceHeat4 = '#707070',
    -- Or link to your colorscheme's groups:
    -- TriforceHeat1 = 'DiffText',
  },

  -- Enable some debugging messages
  debug = false,
})

if (not Plugins.isPluginInstalled('triforce')) then
  local wk = require("which-key")

  wk.add({
    { "<leader>s", group = "triforce" },
  })

  vim.keymap.set('n', '<leader>ss', require('triforce').show_profile, { desc = 'Show Triforce Stats' })
end
