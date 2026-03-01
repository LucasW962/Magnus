local Dictionary = require("@self/Dictionary")
local Array = require("@self/Array")

local Types = require("@self/Types")

export type Dictionary<K = string, V = number> = Types.Dictionary<K, V>
export type Array<T = number> = Types.Array<T>
export type Set<T = number> = Types.Set<T>

export type PredicateDictionary<V = any, K = any, R = any> = Types.PredicateDictionary<V, K, R>
export type KeyPredicateDictionary<K = any, V = any, R = any> = Types.KeyPredicateDictionary<K, V, R>
export type PredicateArray<T, R = any> = Types.PredicateArray<T, R>

export type KeysOf<object> = Types.KeysOf<object>
export type ValuesOf<object> = Types.ValuesOf<object>
export type EntriesOf<object> = Types.EntriesOf<object>

export type Merge<t...> = Types.Merge<t...>
export type MergeFromSig<sig> = Types.MergeFromSig<sig>
export type Concat<t...> = Types.Concat<t...>
export type ConcatFromSig<sig> = Types.ConcatFromSig<sig>
export type Pop<object, count = number> = Types.Pop<object, count>

export type PredicateFromDictionary<object, R = any> = Types.PredicateFromDictionary<object, R>
export type KeyPredicateFromDictionary<object, R = any> = Types.KeyPredicateFromDictionary<object, R>
export type PredicateFromArray<object, R = any> = Types.PredicateFromArray<object, R>

export type DeepFreeze<object> = Types.DeepFreeze<object>

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
