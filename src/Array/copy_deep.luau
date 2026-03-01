local Types = require("../Types")

type Array<T = any> = Types.Array<T>

--[=[
	@function copy_deep
	@within Array

	@param Array<T> -- array
	@return Array<T> -- deep cloned value
]=]
local function copy_deep<T>(Array: Array<T>): Array<T>
	local out = table.clone(Array)

	for key, value in Array do
		if type(value) == "table" then
			out[key] = copy_deep(value :: any)
		end
	end

	return out
end

return copy_deep
