local Types = require("../Types")

type Array<T> = Types.Array<T>
type ValuesOf<T> = Types.ValuesOf<T>

local function values<T>(Dictionary: T): Array<ValuesOf<T>>
	local result = {}

	for _, v in (Dictionary :: any) do
		table.insert(result, v)
	end

	return result :: any
end



return values
