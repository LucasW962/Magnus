local Types = require("../Types")

type Array<T = number> = Types.Array<T>
type DeepFreeze<type> = Types.DeepFreeze<type>


--[=[
    @function freeze_deep
    @within Array

    @param array Array<T> -- array to deeply freeze
    @return DeepFreeze<Array<T>> -- deeply frozen array type

    @note runtime freezing is recursive and cycle-safe
]=]
local function freeze_deep<T>(array: Array<T>): DeepFreeze<Array<T>>
    local seen: { [any]: true } = {}

    local function recurse(value: any)
        if type(value) ~= "table" then
            return value
        end

        if seen[value] then
            return value
        end

        seen[value] = true

        for _, child in value do
            recurse(child)
        end

        table.freeze(value)
        return value
    end

    return recurse(array) :: any
end

local arr = {
    1,2,3
}

local frozen = freeze_deep(arr)
frozen[1] = 5


return freeze_deep

