local Logger = require("utils.logger")
local Plugins
Plugins = {
  initializeLazy = function()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
      local lazyrepo = "https://github.com/folke/lazy.nvim.git"
      local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
      if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
          { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
          { out,                            "WarningMsg" },
          { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
      end
    end
    vim.opt.rtp:prepend(lazypath)

    vim.g.mapleader = " "
    vim.g.maplocalleader = " "
  end,

  isPluginInstalled = function(plugin_name)
    local ok, _ = pcall(require, plugin_name)
    return ok
  end,

  configureSettings = function(plugin_name, config)
    if Plugins.isPluginInstalled(plugin_name) then
      Logger.log("Configuring plugin '" .. plugin_name .. "' with config: " .. vim.inspect(config), vim.log.levels.DEBUG)
      require(plugin_name).setup(config or {})
      Logger.log("Plugin '" .. plugin_name .. "' configured successfully.", vim.log.levels.INFO)
    else
      Logger.log("Plugin '" .. plugin_name .. "' is not installed. Configuration skipped.", vim.log.levels.WARN)
    end
  end,

  configureKeymaps = function(plugin_name, keymaps)
    if Plugins.isPluginInstalled(plugin_name) then
      Logger.log("Configuring keymaps for plugin '" .. plugin_name .. "' with keymaps: " .. vim.inspect(keymaps),
        vim.log.levels.DEBUG)
      for _, keymap in ipairs(keymaps) do
        local mode = keymap.mode or "n"
        local lhs = keymap.lhs
        local rhs = keymap.rhs
        local opts = keymap.opts or { noremap = true, silent = true }
        if not lhs or not rhs then
          Logger.log("Invalid keymap for plugin '" .. plugin_name .. "': missing 'lhs' or 'rhs'.", vim.log.levels.ERROR)
          return
        end
        if keymap.desc then
          opts.desc = keymap.desc
        end
        vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
      end
      Logger.log("Keymaps for plugin '" .. plugin_name .. "' configured successfully.", vim.log.levels.INFO)
    else
      Logger.log("Plugin '" .. plugin_name .. "' is not installed. Keymaps not configured.", vim.log.levels.WARN)
    end
  end
}

return Plugins
