local Types = require("../Types")

type OmitFromSig<object, sig> = Types.OmitFromSig<object, sig>

--[=[
	@function omit
	@within Dictionary

	@param Dictionary T -- dictionary to omit keys from
	@param ... Types.KeysOf<T> -- keys to omit
	@return OmitFromSig<T, sig> -- dictionary without omitted keys

	@note for proper intellisense for omitted literal keys, use an instantiated generic function pack
    @opposite pick

	```lua
	local omit = Magnus.Dictionary.omit

	local dict = {
		["hello"] = true,
		["yoda"] = 67,
		depthed = {
			["hello"] = "c",
		},
	}

	local without = omit<<typeof(dict), ("hello", "yoda") -> ()>>(dict, "hello", "yoda")
	```
]=]
local function omit<T, sig>(Dictionary: T, ...: sig): OmitFromSig<T, sig>
	local result = {}
	local omitted = {}

	for _, key in { ... } :: any do
		omitted[key] = true
	end

	for key, value in Dictionary :: any do
		if omitted[key] ~= true then
			result[key] = value
		end
	end

	return result :: any
end

return omit
