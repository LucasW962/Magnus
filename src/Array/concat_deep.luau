local Types = require("../Types")

type Concat<t...> = Types.Concat<t...>

local function deep_clone_value(value: any): any
	if type(value) ~= "table" then
		return value
	end

	local cloned = table.clone(value)

	for key, child in cloned do
		if type(child) == "table" then
			cloned[key] = deep_clone_value(child)
		end
	end

	return cloned
end

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
	local outIndex = 1

	for i = 1, argumentCount do
		local array = select(i, ...) :: any
		if type(array) == "table" then
			local length = #array

			if length == 0 then
				continue
			end

			for j = 1, length do
				local item = array[j]
				result[outIndex] = if type(item) == "table" then deep_clone_value(item) else item
				outIndex += 1
			end
		end
	end

	return result :: any
end

return concat_deep
