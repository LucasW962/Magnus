--!nocheck
local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local function pick(moduleTable, snakeCaseName, camelCaseName)
	local fn = moduleTable[snakeCaseName] or moduleTable[camelCaseName]
	assert(type(fn) == "function", "Missing function: " .. snakeCaseName .. " / " .. camelCaseName)
	return fn
end

local magnusCopyDeep = pick(Magnus.Dictionary, "copy_deep", "copyDeep")
local siftCopyDeep = pick(Sift.Dictionary, "copy_deep", "copyDeep")

local function buildDeepDictionary(size)
	local out = {}
	for i = 1, size do
		out["deep_" .. tostring(i)] = {
			value = i,
			nested = {
				a = i * 2,
				b = i * 3,
			},
		}
	end
	return out
end

return {
	ParameterGenerator = function()
		return {
			deepA = buildDeepDictionary(220),
		}
	end,

	Functions = {
		["Magnus Dictionary.copy_deep"] = function(_Profiler, input)
			return magnusCopyDeep(input.deepA)
		end,

		["Sift Dictionary.copy_deep"] = function(_Profiler, input)
			return siftCopyDeep(input.deepA)
		end,
	},
}
