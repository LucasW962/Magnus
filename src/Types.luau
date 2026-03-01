export type Dictionary<K = string, V = number> = { [K]: V }
export type Array<T = number> = { T }
export type Set<T = number> = Dictionary<T, true>
export type PredicateDictionary<V = any, K = any, R = any> = (value: V, key: K, Dictionary<K, V>) -> R
export type KeyPredicateDictionary<K = any, V = any, R = any> = (key: K, Dictionary<K, V>) -> R
export type PredicateArray<T, R = any> = (value: T, index: number, Array<T>) -> R

export type function KeysOf(object: type)
	if object.tag ~= "table" then
		return types.never
	end

	local keyTypes: { type } = {}
	local indexer = object:indexer()

	if indexer ~= nil then
		keyTypes[#keyTypes + 1] = indexer.index
	end

	for key in object:properties() do
		keyTypes[#keyTypes + 1] = key
	end

	if #keyTypes == 0 then
		return types.never
	elseif #keyTypes == 1 then
		return keyTypes[1]
	else
		return types.unionof(unpack(keyTypes))
	end
end

export type function ValuesOf(object: type)
	if object.tag ~= "table" then
		return types.never
	end

	local valueTypes: { type } = {}
	local indexer = object:indexer()

	if indexer ~= nil then
		valueTypes[#valueTypes + 1] = indexer.readresult
	end

	for _, prop in object:properties() do
		valueTypes[#valueTypes + 1] = prop.read
	end

	if #valueTypes == 0 then
		return types.never
	elseif #valueTypes == 1 then
		return valueTypes[1]
	else
		return types.unionof(unpack(valueTypes))
	end
end

export type function EntriesOf(object: type)
	if object.tag ~= "table" then
		return types.never
	end

	local keyType = KeysOf(object)
	if keyType.tag == "never" then
		return types.never
	end

	local valueType = ValuesOf(object)

	local entry = types.newtable()
	entry:setproperty(types.singleton("key"), keyType)
	entry:setproperty(types.singleton("value"), valueType)

	local result = types.newtable()
	result:setindexer(types.number, entry)

	return result
end

type function fn_predicateFromDictionary(object: type, resultType: type)
	if object.tag ~= "table" then
		return types.newfunction({
			head = { types.any, types.any, object },
			tail = nil,
		}, {
			head = { resultType },
			tail = nil,
		}, nil)
	end

	local valueType = ValuesOf(object)
	local keyType = KeysOf(object)

	return types.newfunction({
		head = { valueType, keyType, object },
		tail = nil,
	}, {
		head = { resultType },
		tail = nil,
	}, nil)
end

type function fn_keyPredicateFromDictionary(object: type, resultType: type)
	if object.tag ~= "table" then
		return types.newfunction({
			head = { types.any, object },
			tail = nil,
		}, {
			head = { resultType },
			tail = nil,
		}, nil)
	end

	local keyType = KeysOf(object)

	return types.newfunction({
		head = { keyType, object },
		tail = nil,
	}, {
		head = { resultType },
		tail = nil,
	}, nil)
end

type function fn_predicateFromArray(object: type, resultType: type)
	if object.tag ~= "table" then
		return types.newfunction({
			head = { types.any, types.number, object },
			tail = nil,
		}, {
			head = { resultType },
			tail = nil,
		}, nil)
	end

	local valueType = ValuesOf(object)

	return types.newfunction({
		head = { valueType, types.number, object },
		tail = nil,
	}, {
		head = { resultType },
		tail = nil,
	}, nil)
end

export type PredicateFromDictionary<object, R = any> = fn_predicateFromDictionary<object, R>
export type KeyPredicateFromDictionary<object, R = any> = fn_keyPredicateFromDictionary<object, R>
export type PredicateFromArray<object, R = any> = fn_predicateFromArray<object, R>

export type function DeepFreeze(object: type)
	local tag = object.tag

	if tag == "table" then
		local indexer = object:indexer()
		local result = types.newtable()

		if indexer ~= nil then
			local readonlyIndex = DeepFreeze(indexer.index)
			local readonlyValue = DeepFreeze(indexer.readresult)
			result = types.newtable({}, {
				index = readonlyIndex,
				readresult = readonlyValue,
				writeresult = types.never,
			}, nil)
		end

		for key, prop in object:properties() do
			local readonlyProp = DeepFreeze(prop.read)
			result:setreadproperty(key, readonlyProp)
			result:setwriteproperty(key, types.never)
		end

		return result
	elseif tag == "union" then
		local components: { type } = {}
		for _, component in object:components() do
			components[#components + 1] = DeepFreeze(component)
		end

		if #components == 1 then
			return components[1]
		else
			return types.unionof(unpack(components))
		end
	end

	return object
end

return 1
