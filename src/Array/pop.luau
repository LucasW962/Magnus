local Types = require("../Types")

type Pop<T, U> = Types.Pop<T, U>
type Array<T> = Types.Array<T>

--[=[
	@function pop
	@within Array

	@param Array<T> -- array to pop values from
	@param count U? -- number of values to remove from the end (defaults to 1)
	@return Array<T> -- the array with the values popped


	```lua
	local pop = Magnus.Array.pop

	local array = { 1, 2, "hello", "world" }
	local result = pop(array, 2) -- { 1, 2 } 
	```
]=]
local function pop<T>(Array: Array<T>, count: number): Array<T>
	local removeCount = count :: any
	if type(removeCount) ~= "number" then
		removeCount = 1
	end

	removeCount = math.max(0, math.floor(removeCount))

	local length = #(Array :: any)
	local newLength = math.max(0, length - removeCount)
	local result = table.create(newLength)

	for i = 1, newLength do
		result[i] = (Array :: any)[i]
	end

	return result :: any
end

return pop
