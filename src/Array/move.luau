local Types = require("../Types")
local Utility = require("../Utility")

type ValuesOf<T> = Types.ValuesOf<T>

--[=[
	@function move
	@within Array

	@param Array T -- array to mutate immutably
	@param from number -- from index 
	@param to number -- destination index 
	@return { Types.ValuesOf<T> } -- array with value moved

	@note Returns a shallow copy when either index is out of bounds.

	```lua
	local move = Magnus.Array.move

	local array = { "a", "b", "c", "d" }
	local nextArray = move<<typeof(array)>>(array, 2, 4) -- { "a", "c", "d", "b" }
	```
]=]
local function move<T>(Array: T, from: number, to: number): { ValuesOf<T> }
	local source = Array :: any
	local length = #source
	local fromIndex = Utility.functions.normalizeIndex(length, from)
	local toIndex = Utility.functions.normalizeIndex(length, to)

	if fromIndex == nil or toIndex == nil then
		return table.clone(source) :: any
	end

	if fromIndex == toIndex then
		return table.clone(source) :: any
	end

	local result = table.clone(source)
	local movingValue = result[fromIndex]

	if fromIndex < toIndex then
		for i = fromIndex, toIndex - 1 do
			result[i] = result[i + 1]
		end
	else
		for i = fromIndex, toIndex + 1, -1 do
			result[i] = result[i - 1]
		end
	end

	result[toIndex] = movingValue

	return result :: any
end

return move
