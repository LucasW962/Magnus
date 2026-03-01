local Types = require("../Types")

type Predicate<T, R> = Types.PredicateArray<T, R>
type Array<T> = Types.Array<T>

local function some<T>(Array: Array<T>, Predicate: Predicate<T, any>): boolean
	for i, v in Array do
		if Predicate(v, i, Array) then
			return true
		end
	end
	return false
end

return some
