local Types = require("../Types")

type ValuesOf<T> = Types.ValuesOf<T>

--[=[
	@function omit
	@within Array

	@param Array T -- array to omit indices from
	@param ... number -- indices to omit
	@return { Types.ValuesOf<T> } -- array without omitted indices

    @opposite pick

	```lua
	local omit = Magnus.Array.omit

	local array = { "a", "b", "c", "d" }
	local kept = omit<<typeof(array)>>(array, 2, 4) -- { "a", "c" }
	```
]=]
local function omit<T>(Array: T, ...: number): { ValuesOf<T> }
	local result = {}
	local omitted = {}

	for _, index in { ... } do
		omitted[index] = true
	end

	for index, value in Array :: any do
		if omitted[index] ~= true then
			table.insert(result, value)
		end
	end

	return result :: any
end

return omit
