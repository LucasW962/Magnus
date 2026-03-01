local Types = require("../Types")
local Utility = require("../Utility")

type ValuesOf<T> = Types.ValuesOf<T>

--[=[
	@function set
	@within Array

	@param Array T -- array to update (use instantiated generic)
	@param index number -- index to update 
	@param value Types.ValuesOf<T> -- replacement value
	@return { Types.ValuesOf<T> } -- array with updated value

	@note Returns a shallow copy of Array when index is out of bounds.

	```lua
	local set = Magnus.Array.set

	local array = { "a", "b", "c" }
	local nextArray = set<<typeof(array)>>(array, 2, "z") -- { "a", "z", "c" }
	```
]=]
local function set<T>(Array: T, index: number, value: ValuesOf<T>): { ValuesOf<T> }
	local result = table.clone(Array :: any)
	local length = #(Array :: any)
	local normalizedIndex = Utility.functions.normalizeIndex(length, index)

	if normalizedIndex == nil then
		return result :: any
	end

	result[normalizedIndex] = value

	return result :: any
end

return set
