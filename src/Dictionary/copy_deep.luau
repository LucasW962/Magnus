local Types = require("../Types")

type Dictionary<K, V> = Types.Dictionary<K, V>

--[=[
	@function copy_deep
	@within Dictionary

	@param Dictionary Dictionary<K, V> -- dictionary to deep clone
	@return Dictionary<K, V> -- deep cloned dictionary

	@note nested table values are recursively cloned
]=]
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
