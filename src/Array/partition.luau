local Types = require("../Types")

type ValuesOf<T> = Types.ValuesOf<T>
type Predicate<T, R> = (value: ValuesOf<T>, index: number, array: T) -> R

local function truthy(): true
	return true
end

--[=[
	@function partition
	@within Array

	@param Array T -- array to split
	@param Predicate<T, R>? (value: Types.ValuesOf<T>, index: number, array: T) -> R -- predicate used for split
	@return { Types.ValuesOf<T> }, { Types.ValuesOf<T> } -- pass bucket, fail bucket

	@note for proper intellisense, use an instantiated generic for T which is the typeof array

	```lua
	local partition = Magnus.Array.partition

	local array = { 1, 2, 3, 4 }
	local pass, fail = partition<<typeof(array)>>(array, function(value)
		return value % 2 == 0
	end) -- pass: {2, 4}, fail: {1, 3}
	```
]=]
local function partition<T>(Array: T, Predicate: Predicate<T, any>?): ({ ValuesOf<T> }, { ValuesOf<T> })
	local passed = {}
	local failed = {}
	local finalPredicate: Predicate<T, any> = Predicate or truthy

	for index, value in Array :: any do
		if finalPredicate(value, index, Array) then
			table.insert(passed, value)
		else
			table.insert(failed, value)
		end
	end

	return passed :: any, failed :: any
end

return partition
