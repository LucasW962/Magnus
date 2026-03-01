local Types = require("../Types")

type Array<T = number> = Types.Array<T>
type DeepFreeze<type> = Types.DeepFreeze<type>


--[=[
    @function freeze_deep
    @within Array

    @param array Array<T> -- array to deeply freeze
    @return DeepFreeze<Array<T>> -- deeply frozen array type

    @note optimized for arrays (numeric indices)
]=]
local function freeze_deep<T>(array: Array<T>): DeepFreeze<Array<T>>
    local function recurse(value: any): any
        local out = table.clone(value)
        local length = #value

        for i = 1, length do
            local child = value[i]
            if type(child) == "table" then
                if table.isfrozen(child) then
                    out[i] = child
                else
                    out[i] = recurse(child)
                end
            end
        end

        table.freeze(out)
        return out
    end

    return recurse(array) :: any
end

return freeze_deep

