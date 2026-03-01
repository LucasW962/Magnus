local count = require("@self/count")
local copy = require("@self/copy")
local copy_deep = require("@self/copy_deep")
local entries = require("@self/entries")
local keys = require("@self/keys")
local merge = require("@self/merge")
local merge_deep = require("@self/merge_deep")
local some = require("@self/some")
local values = require("@self/values")
local partition = require("@self/partition")
local pick = require("@self/pick")
local omit = require("@self/omit")

return table.freeze({
	count = count,
	copy = copy,
	copy_deep = copy_deep,
	entries = entries,
	keys = keys,
	merge = merge,
	merge_deep = merge_deep,
	some = some,
	values = values,
	partition = partition,
	pick = pick,
	omit = omit,
})
