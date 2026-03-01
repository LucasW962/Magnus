local Types = require("../Types")

type Array<T> = Types.Array<T>
type ValuesOf<T> = Types.ValuesOf<T>

--[=[
	@function values
	@within Dictionary

	@param Dictionary T -- the Dictionary to get values from
	@return Array<ValuesOf<T>> -- array containing all dictionary values

	@note for proper usage, use an instantiated generic to pass the type of the Dictionary in for T

	```lua
	local values = Magnus.Dictionary.values

	local dict = {
		["hello"] = 5,
		["yoda"] = true,
	}

	local out = values<<typeof(dict)>>(dict)
	```
]=]
local function values<T>(Dictionary: T): Array<ValuesOf<T>>
	local result = {}

	for _, v in (Dictionary :: any) do
		table.insert(result, v)
	end

	return result :: any
end



return values
