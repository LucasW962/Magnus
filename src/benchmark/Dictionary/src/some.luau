--!optimize 2


local Sift = require(game.ReplicatedStorage.sift)
local Magnus = require(game.ReplicatedStorage.Magnus)

local MagnusDictionary = Magnus.Dictionary
local SiftDictionary = Sift.Dictionary

local MagnusSome = MagnusDictionary.some
local SiftSome = SiftDictionary.some

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
		-- This function is called before running your function (outside the timer)
		-- and the return(s) are passed into your function arguments (after the Profiler). This sample
		-- will pass the function a random number, but you can make it pass
		-- arrays, Vector3s, or anything else you want to test your function on.
		return math.random(1000)/10
	end;

	Functions = {
		["Magnus.Dict.Some"] = function(Profiler, RandomNumber) -- You can change "Sample A" to a descriptive name for your function
			local some = MagnusSome<<typeof(sample)>>(sample, function(v, k, dict)
				
				return typeof(v) == "number"
			end)
			
		end;

		["Sift.Dict.Some"] = function(Profiler, RandomNumber)
			local some = SiftSome(sample, function(v, k, dict)
				return typeof(v) == "number"
			end)
			
		end;

		-- You can add as many functions as you like! Adding more will take longer to test, of course.
	};

}