local Types = require("../Types")

type PickFromSig<object, sig> = Types.PickFromSig<object, sig>

--[=[
	@function pick
	@within Dictionary

	@param Dictionary T -- dictionary to pick from
	@param ... Types.KeysOf<T> -- keys to include
	@return PickFromSig<T, sig> -- picked dictionary

	@note for proper intellisense for picked literal keys, use an instantiated generic function pack
    @opposite omit

	```lua
	local pick = Magnus.Dictionary.pick

	local dict = {
		["hello"] = true,
		["yoda"] = 67,
		depthed = {
			["hello"] = "c",
		},
	}

	local only = pick<<typeof(dict), ("hello", "yoda") -> ()>>(dict, "hello", "yoda")
	```
]=]
local function pick<T, sig>(Dictionary: T, ...: sig): PickFromSig<T, sig>
	local result = {}

	for _, key in { ... } :: any do
		local value = (Dictionary :: any)[key]

		if value ~= nil then
			result[key] = value
		end
	end

	return result :: any
end

return pick
