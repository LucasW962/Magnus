local Dictionary = require("@self/Dictionary")
local Array = require("@self/Array")

--[=[
    @class Magnus

    Magnus is based off sift, using the new type solver to provide better results,
    alongside using its own optimizations.

    Like sift, theres Array and Dictionary to access the sub functions

    it is reccomended to localize the Magnus functions you plan to use, then use the local version when you want to

    ```lua

    local Magnus = require(game.ReplicatedStorage.Magnus)

    local dictCount = Magnus.Dictionary.count

    local dict = {
        ["hello"] = 5,
        ["hello_world"] = 7,
        ["yoda"] = true
    }

    local currentCount = dictCount(dict, function(value, key: string, dictionary)
        return key:find("hello") -- 2
    end)
    ```

]=]
return {
	Dictionary = Dictionary,
	Array = Array,
}
