--!native

local Types = require("../Types")

type Concat<t...> = Types.Concat<t...>

--[=[
	@function concat
	@within Array

	@param ... Array<T> -- arrays to concatenate in-order
	@return Concat<t...> -- concatenated array

	```lua
	local concat = Magnus.Array.concat

	local a = { 1, 2 }
	local b = { "x", "y" }

	local out = concat(a, b) -- {number | string}
	```
]=]
local function concat<t...>(...: t...): Concat<t...>
	local argumentCount = select("#", ...)
	local totalLength = 0

	for i = 1, argumentCount do
		local array = select(i, ...) :: any
		if type(array) == "table" then
			totalLength += #array
		end
	end

	local result = table.create(totalLength)
	local outIndex = 1

	for i = 1, argumentCount do
		local array = select(i, ...) :: any
		if type(array) == "table" then
			local length = #array
			if length > 0 then
				table.move(array, 1, length, outIndex, result)
				outIndex += length
			end
		end
	end

	return result :: any
end

return concat
