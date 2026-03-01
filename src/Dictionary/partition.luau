local Types = require("../Types")

type KeysOf<T> = Types.KeysOf<T>
type ValuesOf<T> = Types.ValuesOf<T>
type Predicate<T, R = any> = (value: ValuesOf<T>, key: KeysOf<T>, dictionary: T) -> R
type Partial<T> = Types.Partial<T>

local function truthy(): true
	return true
end

--[=[
	@function partition
	@within Dictionary

	@param Dictionary T -- dictionary to split
	@param predicate<T, R>? (value: Types.ValuesOf<T>, key: Types.KeysOf<T>, dictionary: T) -> R -- predicate used for split
	@return Partial<T>, Partial<T> -- pass bucket, fail bucket

    @note for proper intellisense, use an instantiated generic for T

    ```lua
    local pick = Magnus.Dictionary.partition

	local dict = {
		["hello"] = true,
		["yoda"] = 67,
		depthed = {
			["hello"] = "c",
		},
	}

    local pass, fail = partition<<typeof(dict)>>(dict, function(value, key, dict)
        return typeof(value) == "number"
    end)


    ```
]=]
local function partition<T>(Dictionary: T, predicate: Predicate<T, any>?): (Partial<T>, Partial<T>)
	local passed = {}
	local failed = {}
	local final_predicate: Predicate<T, any> = predicate or truthy

	for key, value in Dictionary :: any do
		if final_predicate(value, key, Dictionary) then
			passed[key] = value
		else
			failed[key] = value
		end
	end

	return passed :: any, failed :: any
end

return partition
