local Types = require("../Types")

type Predicate<T, R> = (value: Types.ValuesOf<T>, index: number, array: T) -> R

local function truthy(): true
	return true
end

--[=[
	@function count
	@within Array

	@param Array T -- array to count entries from
	@param Predicate<T, R>? (value: Types.ValuesOf<T>, index: number, array: T) -> R -- predicate used to include entries
	@return number -- number of entries that pass the predicate

	@note To get the proper type for the values, use an instantiated generic

	```lua
	local count = Magnus.Array.count

	local array = { 1, 2, 3, 4 }
	local evenCount = count<<typeof(array)>>(array, function(value) -- value is typed as number here (luau lsp)
		return value % 2 == 0
	end)
	```
]=]
local function count<T>(Array: T, Predicate: Predicate<T, any>?): number
	local counter = 0
	local finalPredicate: Predicate<T, any> = Predicate or truthy

	for i, v in Array :: any do
		if finalPredicate(v, i, Array) then
			counter += 1
		end
	end

	return counter
end

return count
