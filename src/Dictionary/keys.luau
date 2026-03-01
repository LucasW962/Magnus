local Types = require("../Types")

type Array<T> = Types.Array<T>
type KeysOf<T> = Types.KeysOf<T>
type Predicate<T, R = any> = (key: KeysOf<T>, dictionary: T) -> R

--[=[
	@function keys
	@within Dictionary

	@param Dictionary T -- the Dictionary to get keys from
	@param Predicate<T, R>? (key: Types.KeysOf<T>, dictionary: T) -> R -- key predicate used to filter returned keys
	@return Array<KeysOf<T>> -- keys that pass the predicate

	@note for proper usage, use an instantiated generic to pass the type of the Dictionary in for T

	```lua
	local keys = Magnus.Dictionary.keys

	local dict = {
		["bob"] = true,
		["hello"] = {
			["world"] = 5,
		},
		["yoda"] = true,
	}

	local allKeys = keys<<typeof(dict)>>(dict)
	local filtered = keys<<typeof(dict)>>(dict, function(key)
		return key == "hello"
	end)
	```
]=]
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
