local Types = require("../Types")

type MergeFromSig<sig> = Types.MergeFromSig<sig>

--[=[
    @function merge
    @within Dictionary

    @param ... table -- dictionaries to merge left-to-right
    @return MergeFromSig<sig>

    @note for proper intellisense for the type of the returned table, use an instantiated generic function pack

    ```lua
    local dict_1 = {
        ["hello"] = 5
    }

    local dict_2 = {
        ["hello2"] = 7
    }

    local tbl = merge<<(typeof(dict_1), typeof(dict_2)) -> ()>>() -- {hello: number, hello2: number}
    ```
]=]
local function merge<sig>(...: sig): MergeFromSig<sig>
	local result = {}
	local count = select("#", ...)

	for i = 1, count do
		local source = select(i, ...) :: any
		for key, value in source do
			result[key] = value
		end
	end

	return result :: any
end

return merge
