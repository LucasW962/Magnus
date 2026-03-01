--!nocheck
local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local function pick(moduleTable, snakeCaseName, camelCaseName)
	local fn = moduleTable[snakeCaseName] or moduleTable[camelCaseName]
	assert(type(fn) == "function", "Missing function: " .. snakeCaseName .. " / " .. camelCaseName)
	return fn
end

local magnusMergeDeep = pick(Magnus.Dictionary, "merge_deep", "mergeDeep")
local siftMergeDeep = pick(Sift.Dictionary, "merge_deep", "mergeDeep")

local function buildDeepDictionary(size)
	local out = {}
	for i = 1, size do
		out["deep_" .. tostring(i)] = {
			value = i,
			nested = {
				a = i * 2,
				b = i * 3,
			},
		}
	end
	return out
end

return {
	ParameterGenerator = function()
		return {
			deepA = buildDeepDictionary(220),
			deepB = buildDeepDictionary(220),
		}
	end,

	Functions = {
		["Magnus Dictionary.merge_deep"] = function(_Profiler, input)
			return magnusMergeDeep(input.deepA, input.deepB)
		end,

		["Sift Dictionary.merge_deep"] = function(_Profiler, input)
			return siftMergeDeep(input.deepA, input.deepB)
		end,
	},
}
