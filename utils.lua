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
      M.print_table(value, indent + 1)
    else
      print(prefix .. key .. ": " .. tostring(value))
    end
  end
end

M.contains = function(array, value)
  for _, v in ipairs(array) do
    if v == value then
      return true
    end
  end
  return false
end

M.splitTable = function(tbl, index)
  local firstPart = {}
  local secondPart = {}

  for i = 1, index do
    table.insert(firstPart, tbl[i])
  end

  for i = index + 1, #tbl do
    table.insert(secondPart, tbl[i])
  end

  return firstPart, secondPart
end

return M
