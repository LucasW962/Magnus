local Types = require("../Types")

type Predicate<K, V, R> = Types.KeyPredicateDictionary<K, V, R>
type Dictionary<K, V> = Types.Dictionary<K, V>
type Array<T> = Types.Array<T>

local function truthy(): true
	return true
end

local function keys<K, V>(Dictionary: Dictionary<K, V>, Predicate: Predicate<K, V, any>?): Array<K>
	local DictKeys = {}
	local finalPredicate: Predicate<K, V, any> = Predicate or truthy

	for k in Dictionary do
		if finalPredicate(k, Dictionary) then
			table.insert(DictKeys, k)
		end
	end

	return DictKeys
end

return keys
