local M = {}

-- regex
M.part1 = function()
	local mul_pattern = "mul%((%d%d?%d?),(%d%d?%d?)%)"

	local total = 0
	-- Get all the lines from the file containing the corrupt data
	for line in io.lines("day3/part1-input.txt") do
		-- use regex to get the values in the mul()
		for val1, val2 in string.gmatch(line, mul_pattern) do
			total = total + val1 * val2
		end
	end

	print(total)
end

M.part2 = function()
	local mul_pattern = "mul%((%d%d?%d?),(%d%d?%d?)%)"
	local do_pattern = "do%(%s*%)"
	local dont_pattern = "don't%(%s*%)"

	local enabled = true -- Initially, mul instructions are enabled
	local start_pos = 1 -- Start searching from the beginning of the string
	local total = 0

	for line in io.lines("day3/part2-input.txt") do
		start_pos = 1 -- Reset start_pos for each new line
		while true do
			local mul_start_match, mul_end_match = string.find(line, mul_pattern, start_pos)
			local do_start_match, do_end_match = string.find(line, do_pattern, start_pos)
			local dont_start_match, dont_end_match = string.find(line, dont_pattern, start_pos)

			-- Check if no more matches are found
			if not mul_start_match and not do_start_match and not dont_start_match then
				break
			end

			-- Determine the closest match
			local next_match_start = math.huge
			local match_type = nil

			if do_start_match and do_start_match < next_match_start then
				next_match_start = do_start_match
				match_type = "do"
			end

			if dont_start_match and dont_start_match < next_match_start then
				next_match_start = dont_start_match
				match_type = "dont"
			end

			if mul_start_match and mul_start_match < next_match_start then
				next_match_start = mul_start_match
				match_type = "mul"
			end

			-- Process the closest match
			if match_type == "do" then
				enabled = true
				start_pos = do_end_match + 1
			elseif match_type == "dont" then
				enabled = false
				start_pos = dont_end_match + 1
			elseif match_type == "mul" and enabled then
				-- Extract the substring using start and end positions
				local substring = line:sub(mul_start_match, mul_end_match)

				-- Match the pattern within the substring to extract the numbers
				local val1, val2 = substring:match("mul%((%d+),(%d+)%)")

				if val1 and val2 then
				  total = total + val1 * val2
				end

				start_pos = mul_end_match + 1
			else
				start_pos = next_match_start + 1
			end
		end
	end
	print(total)
end

return M
