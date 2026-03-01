local Types = require("../Types")

type EntriesOf<T> = Types.EntriesOf<T>

--[=[
    @function entries
    @within Dictionary

    @param Dictionary T -- the Dictionary to get entries from
    @return EntriesOf<T> -- the entries of the Dictionary in an array

    @note for proper usage, use an instantiated generic to pass the type of the Dictionary in for T

    ```lua
    local entries = Magnus.Dictionary.entries

    local dict = {
        ["bob"] = true,
        ["hello"] = {
            ["world"] = 5,
        },
        ["yoda"] = true
    }

    local new = entries<<typeof(dict)>>(dict)
    print(new) --[[ {
    [1] =  ▼  {
        ["key"] = "hello",
        ["value"] =  ▼  {
            ["world"] = 5
        }
    },
    [2] =  {
        ["key"] = "yoda",
        ["value"] = true
    },
    [3] =  ▼  {
        ["key"] = "bob",
        ["value"] = true
    }
    ]]

    ```
]=]
local function entries<T>(Dictionary: T): EntriesOf<T>
	local result = {}

	for k, v in Dictionary :: any do
		table.insert(result, {
			key = k,
			value = v,
		})
	end

	return result :: any
end

return entries
