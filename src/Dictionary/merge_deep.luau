local Types = require("../Types")
local copy_deep = require("./copy_deep")

type MergeFromSig<sig> = Types.MergeFromSig<sig>

--[=[
    @function merge_deep
    @within Dictionary

    @param ... table -- dictionaries to deep merge left-to-right
    @return MergeFromSig<sig>

    @note for proper intellisense for the type of the returned table, use an instantiated generic function pack

    ```lua
    local dict_1 = {
        ["hello"] = 5
    }

    local dict_2 = {
        ["hello2"] = 7
    }

    local tbl = merge_deep<<(typeof(dict_1), typeof(dict_2)) -> ()>>()

    -- when both sides are tables, nested keys are merged recursively
    ```
]=]

local function merge_deep<sig>(...: sig): MergeFromSig<sig>
	local result = {}
	local count = select("#", ...)

	for i = 1, count do
		local source = select(i, ...) :: any

		for key, value in source do
			local current = result[key]

			if type(current) == "table" and type(value) == "table" then
				result[key] = merge_deep(current, value)
			elseif type(value) == "table" then
				result[key] = copy_deep(value)
			else
				result[key] = value
			end
		end
	end

	return result :: any
end

return merge_deep
