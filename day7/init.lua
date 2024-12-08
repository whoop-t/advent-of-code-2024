local M = {}
local utils = require("utils")

-- bit shifting to get combos
-- eg 6 in binary is 110
-- 110 can translate to + + *
-- 6 % 2 is getting last bit so 0
-- next you shift right eg math.floor(6 / 2) = 3 then keep doing it
local function generate_combinations(n)
	local total_combinations = 2 ^ (n - 1) -- Total combinations of + and *
	local operations = { "+", "*" }
	local combinations = {}

	-- Loop over all possible combinations
	for i = 0, total_combinations - 1 do
		local combination = {}
		local value = i
		for _ = 1, n - 1 do
			-- Determine if the current digit is 0 (for "+") or 1 (for "*")
			local op_index = (value % 2) + 1
			table.insert(combination, operations[op_index])
			value = math.floor(value / 2) -- Move to the next bit
		end
		table.insert(combinations, combination)
	end

	return combinations
end

M.part1 = function()
	local total = 0

	for line in io.lines("day7/part1-input.txt") do
		local values = utils.split(line)
		local goal = tonumber(values[1]:sub(1, -2)) -- remove the colon from the end

		-- get all possible operator combos based on length of nums
		local combos = generate_combinations(#values - 1)
		for i, operators in ipairs(combos) do
			local result = values[2] -- skip goal value
			for i = 1, #operators do
				local op = operators[i]
				local next_number = values[i + 2]

				if op == "+" then
					result = tonumber(result) + tonumber(next_number)
				elseif op == "*" then
					result = tonumber(result) * tonumber(next_number)
				else
					error("Unsupported operator: " .. op)
				end
			end
			if goal == result then
				total = total + result
				break
			end
		end
	end

	print(total)
end

return M
