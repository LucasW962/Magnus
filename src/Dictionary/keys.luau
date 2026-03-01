local Types = require("../Types")

type Array<T> = Types.Array<T>
type KeysOf<T> = Types.KeysOf<T>
type Predicate<T, R = any> = (key: KeysOf<T>, dictionary: T) -> R

local function truthy(): true
	return true
end

local function keys<T>(Dictionary: T, Predicate: Predicate<T, any>?): Array<KeysOf<T>>
	local DictKeys = {}
	local finalPredicate: Predicate<T, any> = Predicate or truthy

	for k in (Dictionary :: any) do
		if finalPredicate(k, Dictionary) then
			table.insert(DictKeys, k)
		end
	end

	return DictKeys :: any
end

return keys
