local Logger
Logger = {
  Levels = {
    DEBUG = vim.log.levels.DEBUG,
    INFO = vim.log.levels.INFO,
    WARN = vim.log.levels.WARN,
    ERROR = vim.log.levels.ERROR,
    NONE = 100
  },
  level = vim.log.levels.INFO,
  log = function(message, level)
    if level < Logger.level then
      return
    end
    local levels = { "DEBUG", "INFO", "WARN", "ERROR" }
    local levelStr = levels[level] or "INFO"
    print(string.format("[%s] %s", levelStr, message))
  end,
  notify = function(message, level)
    if level < Logger.level then
      return
    end
    local levels = { "DEBUG", "INFO", "WARN", "ERROR" }
    local levelStr = levels[level] or "INFO"
    vim.notify(string.format("[%s] %s", levelStr, message), level)
  end,
  setLevel = function(newLevel)
    Logger.level = newLevel
  end,
  getLevel = function()
    return Logger.level
  end
}
return Logger
