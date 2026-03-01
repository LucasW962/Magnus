local Types = require("../Types")

type ValuesOf<T> = Types.ValuesOf<T>

--[=[
	@function pick
	@within Array

	@param Array T -- array to pick from (use instantiated generic)
	@param ... number -- indices to include in the result, allows dupes (in provided order)
	@return { ValuesOf<T> } -- picked array

    @opposite omit

	```lua
	local pick = Magnus.Array.pick

	local array = { "a", "b", "c", "d" }
	local selected = pick<<typeof(array)>>(array, 4, 1, 1) -- { "d", "a", "a" }
	```
]=]
local function pick<T>(Array: T, ...: number): { ValuesOf<T> }
	local result = {}

	for _, index in { ... } do
		local value = (Array :: any)[index]

		if value ~= nil then
			table.insert(result, value)
		end
	end

	return result :: any
end

return pick
