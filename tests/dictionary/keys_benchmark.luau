--!nocheck
local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local function pick(moduleTable, snakeCaseName, camelCaseName)
	local fn = moduleTable[snakeCaseName] or moduleTable[camelCaseName]
	assert(type(fn) == "function", "Missing function: " .. snakeCaseName .. " / " .. camelCaseName)
	return fn
end

local magnusKeys = pick(Magnus.Dictionary, "keys", "keys")
local siftKeys = pick(Sift.Dictionary, "keys", "keys")

local function keyContainsFive(key)
	return string.find(key, "5", 1, true) ~= nil
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
		["Magnus Dictionary.keys"] = function(_Profiler, input)
			return magnusKeys(input.dictA, keyContainsFive)
		end,

		["Sift Dictionary.keys"] = function(_Profiler, input)
			return siftKeys(input.dictA, keyContainsFive)
		end,
	},
}
