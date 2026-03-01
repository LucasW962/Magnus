--!nocheck
local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local function pick(moduleTable, snakeCaseName, camelCaseName)
	local fn = moduleTable[snakeCaseName] or moduleTable[camelCaseName]
	assert(type(fn) == "function", "Missing function: " .. snakeCaseName .. " / " .. camelCaseName)
	return fn
end

local magnusFilter = pick(Magnus.Array, "filter", "filter")
local siftFilter = pick(Sift.Array, "filter", "filter")

local function isEven(value)
	return value % 2 == 0
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
		["Magnus Array.filter"] = function(_Profiler, input)
			return magnusFilter(input.a, isEven)
		end,

		["Sift Array.filter"] = function(_Profiler, input)
			return siftFilter(input.a, isEven)
		end,
	},
}
