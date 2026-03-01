--!optimize 2

local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local MagnusArray = Magnus.Array
local SiftArray = Sift.Array

local MagnusConcatDeep = MagnusArray.concat_deep
local SiftConcatDeep = SiftArray.concatDeep

local INNER_ITERATIONS = 1000

local function buildSamples()
	local left = {
		1,
		2,
		3,
		{
			6,
			7,
			{
				5,
			},
		},
	}

	local right = {
		8,
		9,
		10,
		{
			11,
			12,
		},
	}

	return left, right
end

return {
	ParameterGenerator = function()
		return nil -- not needed
	end,

	Functions = {
		["Magnus.Array.Concat"] = function()
			for _ = 1, INNER_ITERATIONS do
				local left, right = buildSamples()
				MagnusConcatDeep(left, right)
			end
		end,

		["Sift.Array.Concat"] = function()
			for _ = 1, INNER_ITERATIONS do
				local left, right = buildSamples()
				SiftConcatDeep(left, right)
			end
		end,
	},
}
