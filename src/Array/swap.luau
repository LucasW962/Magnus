local Types = require("../Types")
local Utility = require("../Utility")

type ValuesOf<T> = Types.ValuesOf<T>

--[=[
	@function swap
	@within Array

	@param Array T -- array to swap (use instantiated generic)
	@param firstIndex number -- first index 
	@param secondIndex number -- second index 
	@return { ValuesOf<T> } -- array with swapped values

	@note Returns a shallow copy when either index is out of bounds.

	```lua
	local swap = Magnus.Array.swap

	local array = { 1, 2, 3, 4 }
	local nextArray = swap<<typeof(array)>>(array, 1, 4) -- { 4, 2, 3, 1 }
	```
]=]
local function swap<T>(Array: T, firstIndex: number, secondIndex: number): { ValuesOf<T> }
	local result = table.clone(Array :: any)
	local length = #(Array :: any)
	local normalizedFirst = Utility.functions.normalizeIndex(length, firstIndex)
	local normalizedSecond = Utility.functions.normalizeIndex(length, secondIndex)

	if normalizedFirst == nil or normalizedSecond == nil then
		return result :: any
	end

	if normalizedFirst == normalizedSecond then
		return result :: any
	end

	local firstValue = result[normalizedFirst]
	result[normalizedFirst] = result[normalizedSecond]
	result[normalizedSecond] = firstValue

	return result :: any
end

return swap
