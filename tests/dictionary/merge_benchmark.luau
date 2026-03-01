--!nocheck
local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local function pick(moduleTable, snakeCaseName, camelCaseName)
	local fn = moduleTable[snakeCaseName] or moduleTable[camelCaseName]
	assert(type(fn) == "function", "Missing function: " .. snakeCaseName .. " / " .. camelCaseName)
	return fn
end

local magnusMerge = pick(Magnus.Dictionary, "merge", "merge")
local siftMerge = pick(Sift.Dictionary, "merge", "merge")

local function buildDictionary(size, startAt)
	local out = {}
	for i = 1, size do
		out["key_" .. tostring(startAt + i)] = startAt + i
	end
	return out
end

return {
	ParameterGenerator = function()
		return {
			dictA = buildDictionary(900, 0),
			dictB = buildDictionary(900, 1000),
			dictC = buildDictionary(900, 2000),
		}
	end,

	Functions = {
		["Magnus Dictionary.merge"] = function(_Profiler, input)
			return magnusMerge(input.dictA, input.dictB, input.dictC)
		end,

		["Sift Dictionary.merge"] = function(_Profiler, input)
			return siftMerge(input.dictA, input.dictB, input.dictC)
		end,
	},
}
