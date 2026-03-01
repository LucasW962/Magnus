local Types = require("../Types")

type Predicate<T, R = any> = (value: Types.ValuesOf<T>, key: Types.KeysOf<T>, dictionary: T) -> R

local function some<T>(Dictionary: T, Predicate: Predicate<T, any>): boolean
	for k, v in Dictionary :: any do
		if Predicate(v, k, Dictionary) then
			return true
		end
	end

	return false
end

return some
