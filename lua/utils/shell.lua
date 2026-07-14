local Shell
Shell = {
  runCommand = function(command)
    local handle = io.popen(command)
    if not handle then
      return nil, "Failed to execute command: " .. command
    end
    local result = handle:read("*a")
    handle:close()
    return result
  end,

  commandExist = function(command)
    -- Check if command -v [command] return -1
    local handle = io.popen("command -v " .. command .. " >/dev/null 2>&1; echo $?")
    if not handle then
      return false
    end
    local result = handle:read("*a")
    handle:close()
    return tonumber(result) == 0
  end,
}
return Shell
