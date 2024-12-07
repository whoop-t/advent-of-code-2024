local M = {}
local utils = require("utils")

M.part1 = function()
  local rules_hash = {}
  local total = 0
  -- Parse ordering rules
  for line in io.lines("day5/part1-ordering-rules.txt") do
    local t = utils.split(line, "|")
    if rules_hash[t[1]] then
      table.insert(rules_hash[t[1]], t[2])
    else
      rules_hash[t[1]] = { t[2] }
    end
  end

  -- Parse page updates and check against rules
  for line in io.lines("day5/part1-page-updates.txt") do
    local page_updates = utils.split(line, ",")
    local is_good = true

    local before = {}                                 -- array to hold values that need to come before
    for i = 1, #page_updates do
      local _, after = utils.splitTable(page_updates, i) -- get array subset that should come after cur num

      if #before > 0 then
        for j = 1, #before do
          local found = utils.contains(rules_hash[before[j]] or {}, page_updates[i])
          if not found then
            is_good = false
          end
        end
      end

      for j = 1, #after do
        local found = utils.contains(rules_hash[page_updates[i]] or {}, after[j])
        if not found then
          is_good = false
        end
      end

      table.insert(before, page_updates[i])
    end

    if is_good then
      total = total + page_updates[math.ceil(#page_updates / 2)]
    end
  end

  print(total)
end

M.part2 = function()
  local rules_hash = {}
  local total = 0
  -- Parse ordering rules
  for line in io.lines("day5/part1-ordering-rules.txt") do
    local t = utils.split(line, "|")
    if rules_hash[t[1]] then
      table.insert(rules_hash[t[1]], t[2])
    else
      rules_hash[t[1]] = { t[2] }
    end
  end

  -- Parse page updates and check against rules
  for line in io.lines("day5/part1-page-updates.txt") do
    local page_updates = utils.split(line, ",")
    local is_good = true

    local before = {}                                 -- array to hold values that need to come before
    for i = 1, #page_updates do
      local _, after = utils.splitTable(page_updates, i) -- get array subset that should come after cur num

      if #before > 0 then
        for j = 1, #before do
          local found = utils.contains(rules_hash[before[j]] or {}, page_updates[i])
          if not found then
            is_good = false
          end
        end
      end

      for j = 1, #after do
        local found = utils.contains(rules_hash[page_updates[i]] or {}, after[j])
        if not found then
          is_good = false
        end
      end

      table.insert(before, page_updates[i])
    end

    if not is_good then
      local array = utils.split(line, ",")
      local n = #array
      -- custom bubble sort
      for i = 1, n - 1 do
        for j = 1, n - i do
          if not utils.contains(rules_hash[array[j]] or {}, array[j + 1]) then
            -- Swap elements
            array[j], array[j + 1] = array[j + 1], array[j]
          end
        end
      end

      utils.print_table(array)

      total = total + array[math.ceil(#page_updates / 2)]
    end
  end

  print(total)
end

return M
