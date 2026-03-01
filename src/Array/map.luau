local Types = require("../Types")

type ValuesOf<T> = Types.ValuesOf<T>
type Mapper<T, U> = (value: ValuesOf<T>, index: number, array: T) -> U?

--[=[
	@function map
	@within Array

	@param Array T -- array to map
	@param Mapper<T, U> (value: Types.ValuesOf<T>, index: number, array: T) -> U? -- mapper callback
	@return {U} -- mapped array

	@note To get the proper type for the values, use an instantiated generic

	```lua
	local map = Magnus.Array.map

	local array = { 1, 2, 3 }
	local doubled = map<<typeof(array), number>>(array, function(value) -- value is typed as number here and what is returned
		return value * 2
	end)

    --exp 2

    local array = { "hello", "world" }
	local doubled = map<<typeof(array), string>>(array, function(value) -- value is string
		return value:upper()
	end)
	```
]=]
local function map<T, U>(Array: T, Mapper: Mapper<T, U>): { U }
	local mapped = {}

	for index, value in Array :: any do
		local mappedValue = Mapper(value, index, Array)

		if mappedValue ~= nil then
			table.insert(mapped, mappedValue)
		end
	end

	return mapped
end

return map
