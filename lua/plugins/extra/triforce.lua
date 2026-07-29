return {
  {
    'gisketch/triforce.nvim',
    dependencies = { 'nvzone/volt' },
    config = function(_, opts)
      require("triforce").setup(opts)

      -- Override the helper
      local mod = require("triforce.random_stats") -- the module that defines M.format_language_name
      mod.format_language_name = function(filetype)
        -- your replacement body
        local language_names = {}
        for ft, spec in pairs(require("triforce.languages").get_langs()) do
          language_names[ft] = spec.name
        end
        return language_names[filetype] or filetype
      end
    end,
  },
}
