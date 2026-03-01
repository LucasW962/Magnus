local Types = require("../Types")

type EntriesOf<T> = Types.EntriesOf<T>

local function entries<T>(Dictionary: T): EntriesOf<T>
	local result = {}

	for k, v in Dictionary :: any do
		table.insert(result, {
			key = k,
			value = v,
		})
	end

	return result :: any
end

return entries
