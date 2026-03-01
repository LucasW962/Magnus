local Types = require("../Types")

type Array<T = any> = Types.Array<T>

--[=[
	@function copy_deep
	@within Array

	@param Array<T> -- array
	@return Array<T> -- deep cloned value
]=]
local function copy_deep<T>(Array: Array<T>): Array<T>
	local seen: { [any]: any } = {}

	local function clone(value: any): any
		if type(value) ~= "table" then
			return value
		end

		if seen[value] ~= nil then
			return seen[value]
		end

		local out = {}
		seen[value] = out

		for key, innerValue in value do
			out[clone(key)] = clone(innerValue)
		end

		return out
	end

	return clone(Array) :: T
end

return copy_deep
