local Types = require("../Types")

type PredicateDictionary<V, K, R> = Types.PredicateDictionary<V, K, R>
type PredicateArray<T, R> = Types.PredicateArray<T, R>

local function truthy(): true
	return true
end

local function dictionary_predicate<K, V>(predicate: PredicateDictionary<V, K, any>?)
	return predicate or truthy
end

local function array_predicate<T>(predicate: PredicateArray<T, any>?)
	return predicate or truthy
end

return {
	truthy = truthy,
	dictionary_predicate = dictionary_predicate,
	array_predicate = array_predicate,
}
