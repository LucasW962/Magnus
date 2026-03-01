--!optimize 2

local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local MagnusArray = Magnus.Array
local SiftArray = Sift.Array

local MagnusPop = MagnusArray.pop
local SiftPop = SiftArray.pop

local INNER_ITERATIONS = 1000

local function buildSample()
	return {
		1,
		2,
		3,
		{
			6,
			7,
			{
				15,
			},
		},
	}
end

return {

	ParameterGenerator = function()
		return nil -- not needed
	end,

	Functions = {

		["Magnus.Array.Pop"] = function()
			for _ = 1, INNER_ITERATIONS do
				local sample = buildSample()
				MagnusPop(sample)
			end
		end,

		["Sift.Array.Pop"] = function()
			for _ = 1, INNER_ITERATIONS do
				local sample = buildSample()
				SiftPop(sample)
			end
		end,
	},
}
