local Logger = require("utils.logger")
local FS
FS = {
  isFile = function(path)
    local stat = vim.loop.fs_stat(path)
    return stat and stat.type == "file"
  end,

  isDirectory = function(path)
    local stat = vim.loop.fs_stat(path)
    return stat and stat.type == "directory"
  end,

  exists = function(path)
    return vim.loop.fs_stat(path) ~= nil
  end,

  globRequire = function(pattern)
    local result = {}
    -- Recursively find all Lua files matching the pattern and require them
    pattern = vim.fn.stdpath("config") .. "/lua/" .. pattern:gsub("%.", "/") .. "/**/*.lua"
    local files = vim.fn.glob(pattern, true, true)
    Logger.log("Loading files from pattern: " .. pattern, vim.log.levels.INFO)
    Logger.log("Found files: " .. table.concat(files, ", "), vim.log.levels.INFO)
    for _, file in ipairs(files) do
      -- Remove the leading path and the .lua extension, then replace / with . to get the module name
      local module_name = file:gsub(vim.fn.stdpath("config") .. "/lua/", ""):gsub("%.lua$", ""):gsub("/", ".")
      result[#result + 1] = require(module_name)
    end
    return result
  end
}
return FS
