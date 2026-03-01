--!nocheck
local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local function pick(moduleTable, snakeCaseName, camelCaseName)
	local fn = moduleTable[snakeCaseName] or moduleTable[camelCaseName]
	assert(type(fn) == "function", "Missing function: " .. snakeCaseName .. " / " .. camelCaseName)
	return fn
end

local magnusPop = pick(Magnus.Array, "pop", "pop")
local siftPop = pick(Sift.Array, "pop", "pop")

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
		["Magnus Array.pop"] = function(_Profiler, input)
			return magnusPop(input.a, 25)
		end,

		["Sift Array.pop"] = function(_Profiler, input)
			return siftPop(input.a, 25)
		end,
	},
}
