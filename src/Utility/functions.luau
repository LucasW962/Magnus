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

local function normalizeIndex(length: number, index: number): number?
	if type(index) ~= "number" then
		return nil
	end

	local normalized = if index < 1 then length + index else index
	normalized = math.floor(normalized)

	if normalized < 1 or normalized > length then
		return nil
	end

	return normalized
end

local function normalizeInsertIndex(length: number, index: number?): number
	if type(index) ~= "number" then
		return length + 1
	end

	local normalized = if index < 1 then (length + index + 1) else index
	normalized = math.floor(normalized)

	if normalized < 1 then
		return 1
	end

	if normalized > (length + 1) then
		return length + 1
	end

	return normalized
end

return {
	truthy = truthy,
	dictionary_predicate = dictionary_predicate,
	array_predicate = array_predicate,
	normalizeIndex = normalizeIndex,
	normalizeInsertIndex = normalizeInsertIndex,
}
