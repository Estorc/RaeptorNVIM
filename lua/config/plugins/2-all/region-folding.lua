local Plugins = require("utils.plugins")

Plugins.configureSettings("region-folding", {
  region_text = { start = "#region", ending = "#endregion" },
  fold_indicator = "▼"
})
