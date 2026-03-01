--!nocheck
local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local function pick(moduleTable, snakeCaseName, camelCaseName)
	local fn = moduleTable[snakeCaseName] or moduleTable[camelCaseName]
	assert(type(fn) == "function", "Missing function: " .. snakeCaseName .. " / " .. camelCaseName)
	return fn
end

local magnusValues = pick(Magnus.Dictionary, "values", "values")
local siftValues = pick(Sift.Dictionary, "values", "values")

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
		["Magnus Dictionary.values"] = function(_Profiler, input)
			return magnusValues(input.dictA)
		end,

		["Sift Dictionary.values"] = function(_Profiler, input)
			return siftValues(input.dictA)
		end,
	},
}
