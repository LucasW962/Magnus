--!nocheck
local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local function pick(moduleTable, snakeCaseName, camelCaseName)
	local fn = moduleTable[snakeCaseName] or moduleTable[camelCaseName]
	assert(type(fn) == "function", "Missing function: " .. snakeCaseName .. " / " .. camelCaseName)
	return fn
end

local magnusCopyDeep = pick(Magnus.Array, "copy_deep", "copyDeep")
local siftCopyDeep = pick(Sift.Array, "copy_deep", "copyDeep")

local function buildNestedArray(size)
	local out = table.create(size)
	for i = 1, size do
		out[i] = { i, i * 2, { i * 3, i * 4 } }
	end
	return out
end

return {
	ParameterGenerator = function()
		return {
			nestedA = buildNestedArray(250),
		}
	end,

	Functions = {
		["Magnus Array.copy_deep"] = function(_Profiler, input)
			return magnusCopyDeep(input.nestedA)
		end,

		["Sift Array.copy_deep"] = function(_Profiler, input)
			return siftCopyDeep(input.nestedA)
		end,
	},
}
