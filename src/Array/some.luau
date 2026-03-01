local Types = require("../Types")

type Predicate<T, R> = (value: Types.ValuesOf<T>, index: number, array: T) -> R

--[=[
	@function some
	@within Array

	@param Array T -- array to scan
	@param Predicate<T, R> (value: Types.ValuesOf<T>, index: number, array: T) -> R -- callback that decides whether an element matches
	@return boolean -- whether any element matches the predicate

	@note To get the proper type for the values, use an instantiated generic

	```lua
	local some = Magnus.Array.some

	local array = { 1, 2, 3 }
	local hasEven = some<<typeof(array)>>(array, function(value) -- value is typed as number here (luau lsp)
		return value % 2 == 0
	end)
	```
]=]
local function some<T>(Array: T, Predicate: Predicate<T, any>): boolean
	for i, v in Array :: any do
		if Predicate(v, i, Array) then
			return true
		end
	end
	return false
end

return some
