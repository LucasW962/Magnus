--!optimize 2

local Magnus = require(game.ReplicatedStorage.Magnus)
local Sift = require(game.ReplicatedStorage.sift)

local MagnusDictionary = Magnus.Dictionary
local SiftDictionary = Sift.Dictionary

local ITER_COUNT = 1_000_000
local TOTAL_RUNS = 5

local CURRENT_TEST = "Dictionary.count"

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

local function nowMs()
	return os.clock() * 1000
end

local function bench(fn: () -> ())
	-- warmup
	for _ = 1, 10_000 do
		fn()
	end

	local t0 = nowMs()
	for _ = 1, ITER_COUNT do
		fn()
	end
	local t1 = nowMs()

	return t1 - t0
end

local function average(tbl)
	local sum = 0
	for _, v in tbl do
		sum += v
	end
	return sum / #tbl
end

print(`{CURRENT_TEST} benchmark`)
print("Iterations per trial:", ITER_COUNT)
print("RUNS:", TOTAL_RUNS)

local magnusTimes = {}
local siftTimes = {}

for run = 1, TOTAL_RUNS do
	print(`RUN {run}`)

	local magnusMs = bench(function()
		MagnusDictionary.count(sample)
	end)

	local siftMs = bench(function()
		SiftDictionary.count(sample)
	end)

	table.insert(magnusTimes, magnusMs)
	table.insert(siftTimes, siftMs)

	print(string.format("  Magnus: %.3f ms", magnusMs))
	print(string.format("  Sift:   %.3f ms", siftMs))
	print("--------------------------------")
end

local magnusAvg = average(magnusTimes)
local siftAvg = average(siftTimes)

local delta = siftAvg - magnusAvg
local faster = if delta > 0 then "Magnus" else "Sift"
local pct = math.abs(delta) / math.max(magnusAvg, siftAvg) * 100

print("FINAL RESULTS")
print(string.format("Magnus Avg: %.3f ms", magnusAvg))
print(string.format("Sift Avg:   %.3f ms", siftAvg))
print(string.format("Faster (avg): %s", faster))
print(string.format("Average Difference: %.3f ms (%.2f%%)", math.abs(delta), pct))
