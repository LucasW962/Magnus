--!optimize 2


local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local MagnusDictionary = Magnus.Dictionary
local SiftDictionary = Sift.Dictionary

local MagnusMergeDeep = MagnusDictionary.merge_deep
local SiftMergeDeep = SiftDictionary.mergeDeep

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

local second_sample = {
	dawda = 5,
	nest = {
		second_nest = {
			val = 6,
			hello = true
		},
		yes = true
	}
}


return {

	ParameterGenerator = function()
		return nil -- not needed
	end;

	Functions = {
		["Magnus.Dict.MergeDeep"] = function()
			for _ = 1, INNER_ITERATIONS do
				MagnusMergeDeep<<(typeof(sample), typeof(second_sample)) -> ()>>(sample, second_sample)
			end
		end;

		["Sift.Dict.MergeDeep"] = function()
			for _ = 1, INNER_ITERATIONS do
				SiftMergeDeep(sample, second_sample)
			end
		end;
	};

}