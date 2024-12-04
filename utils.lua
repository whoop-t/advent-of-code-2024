local M = {}

-- Split strings/lines from a txt file
M.split = function(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

M.print_table = function(tbl, indent)
  indent = indent or 0
  for key, value in pairs(tbl) do
    local prefix = string.rep("  ", indent) -- Indentation for nested levels
    if type(value) == "table" then
      print(prefix .. key .. ":")
      print_table(value, indent + 1)
    else
      print(prefix .. key .. ": " .. tostring(value))
    end
  end
end

return M
