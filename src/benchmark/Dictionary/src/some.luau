--!optimize 2

local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local MagnusDictionary = Magnus.Dictionary
local SiftDictionary = Sift.Dictionary

local MagnusSome = MagnusDictionary.some
local SiftSome = SiftDictionary.some

local INNER_ITERATIONS = 1000

local sample = {
	a = 1,
	b = 2,
	c = 3,
	name = "Magnus",
	flag = true,
	nested = {
		x = 10,
		y = 20,
	},
	list = { 1, 2, 3, 4, 5 },
}

return {

	ParameterGenerator = function()
		return nil -- not needed
	end,

	Functions = {
		["Magnus.Dict.Some"] = function()
			for _ = 1, INNER_ITERATIONS do
				MagnusSome<<typeof(sample)>>(sample, function(v, k, dict)
					return typeof(v) == "number"
				end)
			end
		end,

		["Sift.Dict.Some"] = function()
			for _ = 1, INNER_ITERATIONS do
				SiftSome(sample, function(v, k, dict)
					return typeof(v) == "number"
				end)
			end
		end,
	},
}
