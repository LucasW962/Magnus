--!nocheck
local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local function pick(moduleTable, snakeCaseName, camelCaseName)
	local fn = moduleTable[snakeCaseName] or moduleTable[camelCaseName]
	assert(type(fn) == "function", "Missing function: " .. snakeCaseName .. " / " .. camelCaseName)
	return fn
end

local magnusSome = pick(Magnus.Array, "some", "some")
local siftSome = pick(Sift.Array, "some", "some")

local function isTargetValue(value)
	return value == 777
end

local function buildArray(size)
	local out = table.create(size)
	for i = 1, size do
		out[i] = i
	end
	return out
end

return {
	ParameterGenerator = function()
		return {
			a = buildArray(1200),
		}
	end,

	Functions = {
		["Magnus Array.some"] = function(_Profiler, input)
			return magnusSome(input.a, isTargetValue)
		end,

		["Sift Array.some"] = function(_Profiler, input)
			return siftSome(input.a, isTargetValue)
		end,
	},
}
