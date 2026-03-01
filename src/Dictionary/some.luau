local Types = require("../Types")

type Predicate<T, R = any> = (value: Types.ValuesOf<T>, key: Types.KeysOf<T>, dictionary: T) -> R

--[=[
	@function some
	@within Dictionary

	@param Dictionary T -- the Dictionary to scan
	@param Predicate<T, R> (value: Types.ValuesOf<T>, key: Types.KeysOf<T>, dictionary: T) -> R -- callback that decides whether an element matches
	@return boolean -- whether any entry matches the predicate

	@note for proper usage, use an instantiated generic to pass the type of the Dictionary in for T

	```lua
	local some = Magnus.Dictionary.some

	local dict = {
		["hello"] = 5,
		["world"] = true,
	}

	local hasNumber = some<<typeof(dict)>>(dict, function(value)
		return typeof(value) == "number"
	end)
	```
]=]
local function some<T>(Dictionary: T, Predicate: Predicate<T, any>): boolean
	for k, v in Dictionary :: any do
		if Predicate(v, k, Dictionary) then
			return true
		end
	end

	return false
end

return some
