--!nocheck
local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local function pick(moduleTable, snakeCaseName, camelCaseName)
	local fn = moduleTable[snakeCaseName] or moduleTable[camelCaseName]
	assert(type(fn) == "function", "Missing function: " .. snakeCaseName .. " / " .. camelCaseName)
	return fn
end

local magnusCopy = pick(Magnus.Dictionary, "copy", "copy")
local siftCopy = pick(Sift.Dictionary, "copy", "copy")

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
		["Magnus Dictionary.copy"] = function(_Profiler, input)
			return magnusCopy(input.dictA)
		end,

		["Sift Dictionary.copy"] = function(_Profiler, input)
			return siftCopy(input.dictA)
		end,
	},
}
