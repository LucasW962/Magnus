--!optimize 2

local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local MagnusArray = Magnus.Array
local SiftArray = Sift.Array

local MagnusMap = MagnusArray.map
local SiftMap = SiftArray.map

local INNER_ITERATIONS = 1000

local function buildSamples()
	local left = {
		1,
		2,
		3,
		
	}

	local right = {
		8,
		9,
		10,
	}

	return left, right
end

return {
	ParameterGenerator = function()
		return nil -- not needed
	end,

	Functions = {
		["Magnus.Array.Map"] = function()
			for _ = 1, INNER_ITERATIONS do
				local left, right = buildSamples()
				MagnusMap<<typeof(left), number>>(left, function(value)
					return value * 2
				end)
			end
		end,

		["Sift.Array.Map"] = function()
			for _ = 1, INNER_ITERATIONS do
				local left, right = buildSamples()
				SiftMap(left, function(value)
					return value * 2
				end)
			end
		end,
	},
}
