local M = {}
local utils = require("utils")

M.part1 = function()
	local reports = {}
	-- Read all the report inputs
	for line in io.lines("day2/part1-input.txt") do
		local report = utils.split(line)
		table.insert(reports, report)
	end

	-- Loop all the reports and calculate
	local total_safe = 0
	for _, report in ipairs(reports) do
		-- We dont need to calculate the last number in the report
		-- assume safe till we know its not
		local safe = true
		local increasing
		for j = 1, #report - 1 do
		  local first = tonumber(report[j])
		  local second = tonumber(report[j + 1])
			local diff = math.abs(first - second)
			-- First we need to get increasing or decreasing
			-- They also CANT be neither, it has to be decreasing OR increasing, not the same
			local is_increasing = first < second
			-- Only set on the first iteration
			if j == 1 then
				increasing = is_increasing
			end
			if (first == second) or (increasing ~= is_increasing) then
				safe = false
			end

			-- its NOT safe if the difference doesnt fall in line below
			if diff < 1 or diff > 3 then
				safe = false
			end
		end

		-- If safe is never flipped to false, then its goooood
		if safe then
			total_safe = total_safe + 1
		end
	end

	print(total_safe)
end

M.part2 = function() end

return M
