local Types = require("../Types")
local Util = require("../Utility")

type Dictionary<K = any, V = any> = Types.Dictionary<K, V>
type Predicate<V = any, K = any, R = any> = Types.Predicate<V, K, R>

local function count<K, V>(Dictionary: Dictionary<K, V>, predicate: Predicate<V, K, any>?): number
	local total_count = 0

	local final_predicate: Predicate<V, K, any>

	if not predicate or type(predicate) ~= "function" then
		final_predicate = function(_value: V, _key: K, _dictionary: Dictionary<K, V>): boolean
			return Util.functions.truthy()
		end
	else
		final_predicate = predicate
	end

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
