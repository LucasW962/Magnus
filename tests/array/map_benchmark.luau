--!nocheck
local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local function pick(moduleTable, snakeCaseName, camelCaseName)
	local fn = moduleTable[snakeCaseName] or moduleTable[camelCaseName]
	assert(type(fn) == "function", "Missing function: " .. snakeCaseName .. " / " .. camelCaseName)
	return fn
end

local magnusMap = pick(Magnus.Array, "map", "map")
local siftMap = pick(Sift.Array, "map", "map")

local function triple(value)
	return value * 3
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
		["Magnus Array.map"] = function(_Profiler, input)
			return magnusMap(input.a, triple)
		end,

		["Sift Array.map"] = function(_Profiler, input)
			return siftMap(input.a, triple)
		end,
	},
}
