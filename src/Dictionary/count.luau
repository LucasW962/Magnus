local Types = require("../Types")
local Util = require("../Utility")

type Dictionary<K = any, V = any> = Types.Dictionary<K, V>
type func<T... = ...any, R... = ...any> = Types.Func<T..., R...>

local function count<K, V>(Dictionary: Dictionary<K, V>, predicate: func<(V, K, Dictionary<K, V>), (any)>?): number
	local total_count = 0

	if not predicate or type(predicate) ~= "function" then
		predicate = Util.functions.truthy
	end

	local final_predicate: func<(V, K, Dictionary<K, V>), (any)> = predicate :: func<(V, K, Dictionary<K, V>), (any)>

	for k, v in Dictionary do
		if final_predicate(v, k, Dictionary) then
			total_count += 1
		end
	end

	return total_count
end

return {
	count = count,
}
