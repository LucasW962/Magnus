--!nocheck
local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local function pick(moduleTable, snakeCaseName, camelCaseName)
	local fn = moduleTable[snakeCaseName] or moduleTable[camelCaseName]
	assert(type(fn) == "function", "Missing function: " .. snakeCaseName .. " / " .. camelCaseName)
	return fn
end

local magnusSome = pick(Magnus.Dictionary, "some", "some")
local siftSome = pick(Sift.Dictionary, "some", "some")

local function valueOverThreshold(value)
	return type(value) == "number" and value > 1800
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
			dictC = buildDictionary(900, 2000),
		}
	end,

	Functions = {
		["Magnus Dictionary.some"] = function(_Profiler, input)
			return magnusSome(input.dictC, valueOverThreshold)
		end,

		["Sift Dictionary.some"] = function(_Profiler, input)
			return siftSome(input.dictC, valueOverThreshold)
		end,
	},
}
