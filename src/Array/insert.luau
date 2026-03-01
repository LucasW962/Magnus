local Types = require("../Types")
local Utility = require("../Utility")

type ValuesOf<T> = Types.ValuesOf<T>

--[=[
	@function insert
	@within Array

	@param Array T -- array to insert into (use instantiated generic)
	@param index number? -- index to insert at (normalized to 1)
	@param value ValuesOf<T> -- value to insert
	@return { ValuesOf<T> } -- array with inserted value

	@note If index is omitted, value is appended.

	```lua
	local insert = Magnus.Array.insert

	local array = { 10, 20, 30 }
	local nextArray = insert<<typeof(array)>>(array, 2, 15) -- { 10, 15, 20, 30 }
	```
]=]
local function insert<T>(Array: T, index: number?, value: ValuesOf<T>): { ValuesOf<T> }
	local source = Array :: any
	local length = #source
	local insertIndex = Utility.functions.normalizeInsertIndex(length, index)
	local result = table.create(length + 1)
	local resultIndex = 1

	for sourceIndex = 1, length do
		if sourceIndex == insertIndex then
			result[resultIndex] = value
			resultIndex += 1
		end

		result[resultIndex] = source[sourceIndex]
		resultIndex += 1
	end

	if insertIndex == length + 1 then
		result[resultIndex] = value
	end

	return result :: any
end

return insert
