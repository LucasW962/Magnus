local Types = require("../Types")

type Pop<T, U> = Types.Pop<T, U>

--[=[
	@function pop
	@within Array

	@param Array T -- array to pop values from
	@param count U? -- number of values to remove from the end (defaults to 1)
	@return Pop<T, U> -- array with the last `count` entries removed

	@note theres no support for number singletons, so if the type is {number | string} and you pop string,
    the end result is still {number | string}

	```lua
	local pop = Magnus.Array.pop

	local array = { 1, 2, "hello", "world" }
	local result = pop<<typeof(array)>>(array, 2) -- { 1, 2 } still {number | string}
	```
]=]
local function pop<T>(Array: T, count: number): Pop<T, number>
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
