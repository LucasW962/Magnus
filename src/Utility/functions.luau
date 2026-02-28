local Types = require("../Types")

type Predicate<V, K, R> = Types.Predicate<V, K, R>

local function truthy(): true
	return true
end

local function default_predicate<K, V>(predicate: Predicate<V, K, any>?)
	return predicate or truthy
end

return {
	truthy = truthy,
	default_predicate = default_predicate,
}
