local Types = require("../Types")
local copy_deep = require("./copy_deep")

type Concat<t...> = Types.Concat<t...>

--[=[
	@function concat_deep
	@within Array

	@param ... table -- arrays to concatenate in-order
	@return Concat<t...> -- concatenated array where nested tables are deep-copied


	```lua
	local concat_deep = Magnus.Array.concat_deep

	local table1 = { 6, 7, { 8, 4 } }
	local table2 = { "h", "c", {76, 67} }

	local new = concat_deep(table1, table2) -- {number | string | {number} | {number}}
	```
]=]
local function concat_deep<t...>(...: t...): Concat<t...>
	local argumentCount = select("#", ...)
	local totalLength = 0

	for i = 1, argumentCount do
		local array = select(i, ...) :: any
		if type(array) == "table" then
			totalLength += #array
		end
	end

	local result = table.create(totalLength)
	local outIndex = 0

	for i = 1, argumentCount do
		local array = select(i, ...) :: any
		if type(array) == "table" then
			for j = 1, #array do
				outIndex += 1
				local item = array[j]
				result[outIndex] = if type(item) == "table" then copy_deep(item) else item
			end
		end
	end

	return result :: any
end

return concat_deep
