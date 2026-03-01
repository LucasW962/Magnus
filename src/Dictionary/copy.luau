--[=[
	@function copy
	@within Dictionary

	@param Dictionary table -- dictionary to shallow copy
	@return table -- shallow clone of the dictionary

	@note this performs a shallow clone using table.clone; nested tables are shared
]=]
return table.clone
