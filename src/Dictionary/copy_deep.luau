local Types = require("../Types")

type Dictionary<K, V> = Types.Dictionary<K, V>

local function copy_deep<K, V>(Dictionary: Dictionary<K, V>): Dictionary<K, V>
	local new_tbl = table.clone(Dictionary)

	for k, v in Dictionary do
		if type(v) == "table" then
			new_tbl[k] = copy_deep(v)
		end
	end
	return new_tbl
end

return copy_deep
