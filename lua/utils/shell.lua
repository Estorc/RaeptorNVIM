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
  end
}
return Shell
