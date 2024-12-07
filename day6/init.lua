local M = {}
local utils = require("utils")

local function splitStr(inputstr)
  local t = {}
  for i = 1, #inputstr do
    table.insert(t, inputstr:sub(i, i))
  end
  return t
end

M.part1 = function()
  local directions = {
    ["up"] = { -1, 0 }, -- up
    ["right"] = { 0, 1 }, -- right
    ["down"] = { 1, 0 }, -- down
    ["left"] = { 0, -1 }, -- left
  }
  local cur_direction = "up"
  local cur = {}
  local map = {}
  local seen = {}
  -- create map in matrix form
  for line in io.lines("day6/part1-input.txt") do
    table.insert(map, splitStr(line))
  end

  -- find guard start
  -- we are going to assume it start pointing up/north
  for i = 1, #map do
    for j = 1, #map[i] do
      if map[i][j] == "^" then
        cur = { i, j }
      end
    end
  end

  -- Now we follow the rules and track guards movement
  -- Add seen spots as the guard walks
  repeat
    -- Check if guard left the map
    if not map[cur[1]] or not map[cur[1]][cur[2]] then
      break
    end

    -- add cur to seen list
    seen[cur[1] .. "," .. cur[2]] = true

    -- check if the next move will hit something
    if
        map[cur[1] + directions[cur_direction][1]]
        and map[cur[2] + directions[cur_direction][2]]
        and map[cur[1] + directions[cur_direction][1]][cur[2] + directions[cur_direction][2]] == "#"
    then
      if cur_direction == "up" then
        cur_direction = "right"
      elseif cur_direction == "right" then
        cur_direction = "down"
      elseif cur_direction == "down" then
        cur_direction = "left"
      elseif cur_direction == "left" then
        cur_direction = "up"
      end
    end
    -- move and add to seen
    cur = { cur[1] + directions[cur_direction][1], cur[2] + directions[cur_direction][2] }
  until false -- never stop unless break inside

  local count = 0
  for _ in pairs(seen) do
    count = count + 1
  end

  print(count)
end

M.part2 = function() end

return M
