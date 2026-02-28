local Types = require("../Types")
local Utility = require("../Utility")

type Array<T = any> = Types.Array<T>
type Predicate<T, R> = Types.PredicateArray<T, R>

local function count<T>(Array: Array<T>, Predicate: Predicate<T, any>?): number
	local counter = 0

	Predicate = Utility.functions.array_predicate(Predicate)

	for i, v in Array do
		if Predicate(v, i, Array) then
			counter += 1
		end
	end

	return counter
end

return count
