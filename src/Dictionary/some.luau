local Types = require("../Types")

type Dictionary<K, V> = Types.Dictionary<K, V>
type Predicate<V, K, R = any> = Types.PredicateDictionary<V, K, R>

local function some<K, V>(Dictionary: Dictionary<K, V>, Predicate: Predicate<V, K>): boolean
	for k, v in Dictionary do
		if Predicate(v, k, Dictionary) then
			return true
		end
	end

	return false
end

return some
