--!nocheck
local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local function pick(moduleTable, snakeCaseName, camelCaseName)
	local fn = moduleTable[snakeCaseName] or moduleTable[camelCaseName]
	assert(type(fn) == "function", "Missing function: " .. snakeCaseName .. " / " .. camelCaseName)
	return fn
end

local magnusConcat = pick(Magnus.Array, "concat", "concat")
local siftConcat = pick(Sift.Array, "concat", "concat")

local function buildArray(size)
	local out = table.create(size)
	for i = 1, size do
		out[i] = i
	end
	return out
end

return {
	ParameterGenerator = function()
		local size = 1200
		return {
			a = buildArray(size),
			b = buildArray(size),
			c = buildArray(size),
		}
	end,

	Functions = {
		["Magnus Array.concat"] = function(_Profiler, input)
			return magnusConcat(input.a, input.b, input.c)
		end,

		["Sift Array.concat"] = function(_Profiler, input)
			return siftConcat(input.a, input.b, input.c)
		end,
	},
}
