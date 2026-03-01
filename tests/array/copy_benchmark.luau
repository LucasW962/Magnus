--!nocheck
local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local function pick(moduleTable, snakeCaseName, camelCaseName)
	local fn = moduleTable[snakeCaseName] or moduleTable[camelCaseName]
	assert(type(fn) == "function", "Missing function: " .. snakeCaseName .. " / " .. camelCaseName)
	return fn
end

local magnusCopy = pick(Magnus.Array, "copy", "copy")
local siftCopy = pick(Sift.Array, "copy", "copy")

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
		["Magnus Array.copy"] = function(_Profiler, input)
			return magnusCopy(input.a)
		end,

		["Sift Array.copy"] = function(_Profiler, input)
			return siftCopy(input.a)
		end,
	},
}
