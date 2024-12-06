local M = {}
local answer = { "X", "M", "A", "S" }

local function check(matrix, q)
  for i = 1, #q do
    if not matrix[q[i][1]] or not matrix[q[i][1]][q[i][2]] or matrix[q[i][1]][q[i][2]] ~= answer[i + 1] then
      return false
    end
  end

  return true
end

M.part1 = function()
  -- Get all the lines from the file and put them in a table
  local matrix = {}
  local total_found = 0
  for line in io.lines("day4/part1-input.txt") do
    -- Loop the line characters and put them in matrix
    local array = {}
    for i = 1, #line do
      local c = line:sub(i, i)
      table.insert(array, c)
    end
    table.insert(matrix, array)
  end

  -- Go through matrix and fan out to look for words
  for r = 1, #matrix do
    for c = 1, #matrix[r] do
      -- If we hit an X, then fan out(DFS or BFS) and see if we can find a word
      if matrix[r][c] == answer[1] then
        -- Check in all directions
        local cur_total = 0
        -- Cardinal
        cur_total = cur_total + (check(matrix, { { r, c - 1 }, { r, c - 2 }, { r, c - 3 } }) and 1 or 0)
        cur_total = cur_total + (check(matrix, { { r, c + 1 }, { r, c + 2 }, { r, c + 3 } }) and 1 or 0)
        cur_total = cur_total + (check(matrix, { { r - 1, c }, { r - 2, c }, { r - 3, c } }) and 1 or 0)
        cur_total = cur_total + (check(matrix, { { r + 1, c }, { r + 2, c }, { r + 3, c } }) and 1 or 0)
        --Diagonal
        cur_total = cur_total + (check(matrix, { { r - 1, c - 1 }, { r - 2, c - 2 }, { r - 3, c - 3 } }) and 1 or 0)
        cur_total = cur_total + (check(matrix, { { r - 1, c + 1 }, { r - 2, c + 2 }, { r - 3, c + 3 } }) and 1 or 0)
        cur_total = cur_total + (check(matrix, { { r + 1, c - 1 }, { r + 2, c - 2 }, { r + 3, c - 3 } }) and 1 or 0)
        cur_total = cur_total + (check(matrix, { { r + 1, c + 1 }, { r + 2, c + 2 }, { r + 3, c + 3 } }) and 1 or 0)

        total_found = total_found + cur_total
      end
    end
  end

  print(total_found)
end

M.part2 = function() end

return M
