--!nocheck
local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local function pick(moduleTable, snakeCaseName, camelCaseName)
	local fn = moduleTable[snakeCaseName] or moduleTable[camelCaseName]
	assert(type(fn) == "function", "Missing function: " .. snakeCaseName .. " / " .. camelCaseName)
	return fn
end

local magnusCount = pick(Magnus.Dictionary, "count", "count")
local siftCount = pick(Sift.Dictionary, "count", "count")

local function hasEvenValue(value)
	return type(value) == "number" and value % 2 == 0
end

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
		}
	end,

	Functions = {
		["Magnus Dictionary.count"] = function(_Profiler, input)
			return magnusCount(input.dictA, hasEvenValue)
		end,

		["Sift Dictionary.count"] = function(_Profiler, input)
			return siftCount(input.dictA, hasEvenValue)
		end,
	},
}
