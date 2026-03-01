--!optimize 2

local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local MagnusArray = Magnus.Array
local SiftArray = Sift.Array

local MagnusConcat = MagnusArray.concat
local SiftConcat = SiftArray.concat

local INNER_ITERATIONS = 1000

local function buildSamples()
	local left = {
		1,
		2,
		3,
		{
			6,
			7,
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
				MagnusConcat(left, right)
			end
		end,

		["Sift.Array.Concat"] = function()
			for _ = 1, INNER_ITERATIONS do
				local left, right = buildSamples()
				SiftConcat(left, right)
			end
		end,
	},
}
