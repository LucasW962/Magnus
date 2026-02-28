local Types = require("../Types")
local Utility = require("../Utility")

type Predicate<V, K, R> = Types.Predicate
type Dictionary<K, V> = Types.Dictionary<K, V>
type Array<T> = Types.Array<T>

local function keys<K, V>(Dictionary: Dictionary<K, V>, Predicate: Predicate<K, V, any>?): Array<K>
	local DictKeys = {}

	Predicate = Utility.functions.default_predicate(Predicate)

	for k in Dictionary do
		if Predicate(nil, k, Dictionary) then
			table.insert(DictKeys, k)
		end
	end

	return DictKeys
end

return keys
