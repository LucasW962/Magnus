local Types = require("../Types")
local Utility = require("../Utility")

type ValuesOf<T> = Types.ValuesOf<T>

--[=[
	@function remove_index
	@within Array

	@param Array T -- array to remove from (use instantiated generic)
	@param index number -- index to remove (supports negative index)
	@return { Types.ValuesOf<T> } -- array without the removed index

	@note Returns a shallow copy of Array when index is out of bounds.

	```lua
	local remove_index = Magnus.Array.remove_index

	local array = { "x", "y", "z" }
	local nextArray = remove_index<<typeof(array)>>(array, 2) -- { "x", "z" }
	```
]=]
local function remove_index<T>(Array: T, index: number): { ValuesOf<T> }
	local source = Array :: any
	local length = #source
	local removeIndex = Utility.functions.normalizeIndex(length, index)

	if removeIndex == nil then
		return table.clone(source) :: any
	end

	local result = table.create(math.max(0, length - 1))
	local resultIndex = 1

	for sourceIndex = 1, length do
		if sourceIndex ~= removeIndex then
			result[resultIndex] = source[sourceIndex]
			resultIndex += 1
		end
	end

	return result :: any
end

return remove_index
