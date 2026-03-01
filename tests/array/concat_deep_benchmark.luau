--!nocheck
local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local function pick(moduleTable, snakeCaseName, camelCaseName)
	local fn = moduleTable[snakeCaseName] or moduleTable[camelCaseName]
	assert(type(fn) == "function", "Missing function: " .. snakeCaseName .. " / " .. camelCaseName)
	return fn
end

local magnusConcatDeep = pick(Magnus.Array, "concat_deep", "concatDeep")
local siftConcatDeep = pick(Sift.Array, "concat_deep", "concatDeep")

local function buildNestedArray(size)
	local out = table.create(size)
	for i = 1, size do
		out[i] = { i, i * 2, { i * 3, i * 4 } }
	end
	return out
end

return {
	ParameterGenerator = function()
		return {
			nestedA = buildNestedArray(250),
			nestedB = buildNestedArray(250),
		}
	end,

	Functions = {
		["Magnus Array.concat_deep"] = function(_Profiler, input)
			return magnusConcatDeep(input.nestedA, input.nestedB)
		end,

		["Sift Array.concat_deep"] = function(_Profiler, input)
			return siftConcatDeep(input.nestedA, input.nestedB)
		end,
	},
}
