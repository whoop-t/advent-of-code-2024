local M = {}
local utils = require("utils")

M.part1 = function()
	local list1 = {}
	local list2 = {}
	-- Get all the inputs values in a table
	for line in io.lines("day1/part1-input.txt") do
		local parts = utils.split(line)
		table.insert(list1, parts[1])
		table.insert(list2, parts[2])
	end

	-- Sort from low to high
	table.sort(list1)
	table.sort(list2)

	-- Loop and calculate differences
	local differences = {}
	for i = 1, #list1 do
		local diff = math.abs(list1[i] - list2[i])
		table.insert(differences, diff)
	end

	-- Add them all up
	local total = 0
	for _, v in ipairs(differences) do
		total = total + v
	end

	print(total)
end

M.part2 = function()
	local list1 = {}
	local list2 = {}
	-- Get all the inputs values in a table
	for line in io.lines("day1/part2-input.txt") do
		local parts = utils.split(line)
		table.insert(list1, parts[1])
		table.insert(list2, parts[2])
	end

	-- Double loop and calculate similarity
	local total = 0
	for i = 1, #list1 do
		local times_found = 0
		for j = 1, #list2 do
			if list1[i] == list2[j] then
				times_found = times_found + 1
			end
		end

		total = total + (list1[i] * times_found)
	end

	print(total)
end

return M
