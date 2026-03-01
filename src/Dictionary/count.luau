local Types = require("../Types")

type Predicate<T, R = any> = (value: Types.ValuesOf<T>, key: Types.KeysOf<T>, dictionary: T) -> R

local function truthy(): true
	return true
end

--[=[
    @function count
    @within Dictionary

    @param Dictionary T -- the dictionary to count items
    @param predicate<T, R>? (value: Types.ValuesOf<T>, key: Types.KeysOf<T>, dictionary: T) -> R -- how the dictionary should be filtered
    @return number -- number of items in dictionary

    @note for proper usage, use an instantiated generic to pass the type of the Dictionary in for T

    ```lua
    
   local dict = {
    ["hello"] = 5,
    ["hello_world"] = 7,
    ["yoda"] = true
    }

    local counted = count<<typeof(dict)>>(dict) -- 3
    local predicated = count<<typeof(dict)>>(dict, function(value, key, dict)
        return typeof(value) == "number" -- 2
    end)


    ```
]=]
local function count<T>(Dictionary: T, predicate: Predicate<T, any>?): number
	local total_count = 0
	local final_predicate: Predicate<T, any> = predicate or truthy

	for k, v in Dictionary :: any do
		if final_predicate(v, k, Dictionary) then
			total_count += 1
		end
	end

	return total_count
end

return count
