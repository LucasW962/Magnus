local Types = require("../Types")

type Predicate<T, R> = (value: ValuesOf<T>, index: number, array: T) -> R

type ValuesOf<T> = Types.ValuesOf<T>

local function truthy(): true
	return true
end

--[=[
	@function filter
	@within Array

	@param Array T -- array to filter
	@param Predicate<T, R>? (value: Types.ValuesOf<T>, index: number, array: T) -> R -- predicate used to keep entries
	@return { Types.ValuesOf<T> } -- filtered array

	@note To get the proper type for the values, use an instantiated generic

	```lua
	local filter = Magnus.Array.filter

	local array = { 1, 2, 3, 4 }
	local evens = filter<<typeof(array)>>(array, function(value) -- value is typed as number here (luau lsp)
		return value % 2 == 0
	end)
	```
]=]
local function filter<T>(Array: T, Predicate: Predicate<T, any>?): { ValuesOf<T> }
	local result = {}
	local finalPredicate: Predicate<T, any> = Predicate or truthy

	for i, v in Array :: any do
		if finalPredicate(v, i, Array) then
			table.insert(result, v)
		end
	end

	return result :: any
end

return filter
