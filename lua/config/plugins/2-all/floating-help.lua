local Plugins = require("utils.plugins")


if Plugins.isPluginInstalled('floating-help') then
  local fh = require('floating-help')

  fh.setup({
    -- Defaults
    width = 80,                        -- Whole numbers are columns/rows
    height = 0.9,                      -- Decimals are a percentage of the editor
    position = 'E',                    -- NW,N,NE,W,C,E,SW,S,SE (C==center)
    border = 'rounded',                -- rounded,double,single
    onload = function(query_type) end, -- optional callback to be executed after help contents has been loaded
  })
  -- Only replace cmds, not search; only replace the first instance
  local function cmd_abbrev(abbrev, expansion)
    local cmd = 'cabbr ' ..
        abbrev .. ' <c-r>=(getcmdpos() == 1 && getcmdtype() == ":" ? "' .. expansion .. '" : "' .. abbrev .. '")<CR>'
    vim.cmd(cmd)
  end

  -- Redirect `:h` to `:FloatingHelp`
  cmd_abbrev('h', 'FloatingHelp')
  cmd_abbrev('help', 'FloatingHelp')
  cmd_abbrev('helpc', 'FloatingHelpClose')
  cmd_abbrev('helpclose', 'FloatingHelpClose')
end
