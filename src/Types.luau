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

type function fn_merge(sig: type)
	local tables = sig:parameters().head
	assert(tables)

	local result = types.newtable()

	for _, tableType in tables do
		if not tableType:is("table") then
			return types.newtable()
		end

		local indexer = tableType:indexer()
		if indexer ~= nil then
			result:setreadindexer(indexer.index, indexer.readresult)
			result:setwriteindexer(indexer.index, indexer.writeresult)
		end

		for key, prop in tableType:properties() do
			if prop.read ~= prop.write then
				result:setreadproperty(key, prop.read)
				result:setwriteproperty(key, prop.write)
			else
				result:setproperty(key, prop.read)
			end
		end
	end

	return result
end

type function fn_concat(sig: type)
	local arrays = sig:parameters().head
	assert(arrays)

	local elementTypes: { type } = {}

	for _, arrayType in arrays do
		if arrayType:is("table") then
			local elementType = ValuesOf(arrayType)
			if elementType.tag ~= "never" then
				elementTypes[#elementTypes + 1] = elementType
			end
		end
	end

	local result = types.newtable()

	if #elementTypes == 0 then
		result:setindexer(types.number, types.never)
	elseif #elementTypes == 1 then
		result:setindexer(types.number, elementTypes[1])
	else
		result:setindexer(types.number, types.unionof(unpack(elementTypes)))
	end

	return result
end

-- keeping this for future use, hopefully they add number literals...
type function fn_pop(object: type, countType: type)
	if object.tag ~= "table" then
		return types.newtable()
	end

	local valueType = ValuesOf(object)
	local fallback = types.newtable()
	if valueType.tag ~= "never" then
		fallback:setindexer(types.number, valueType)
	end

	if countType.tag ~= "singleton" then
		return fallback
	end

	local singletonCount = countType:value() :: any
	if type(singletonCount) ~= "number" then
		return fallback
	end

	local removeCount = math.max(0, math.floor(singletonCount))
	if removeCount == 0 then
		return object
	end

	local indexer = object:indexer()
	if indexer ~= nil then
		local indexedFallback = types.newtable()
		indexedFallback:setindexer(indexer.index, indexer.readresult)
		return indexedFallback
	end

	local maxNumericKey = 0
	for key in object:properties() do
		if key.tag == "singleton" then
			local maybeKey = key:value() :: any
			if type(maybeKey) == "number" then
				maxNumericKey = math.max(maxNumericKey, maybeKey)
			end
		end
	end

	local keepUpTo = maxNumericKey - removeCount
	if keepUpTo <= 0 then
		return types.newtable()
	end

	local result = types.newtable()

	for key, prop in object:properties() do
		local keep = true

		if key.tag == "singleton" then
			local maybeKey = key:value() :: any
			if type(maybeKey) == "number" then
				keep = maybeKey <= keepUpTo
			end
		end

		if keep then
			local readType = prop.read
			if readType ~= nil then
				if prop.write ~= nil and prop.write ~= readType then
					result:setreadproperty(key, readType)
					result:setwriteproperty(key, prop.write)
				else
					result:setproperty(key, readType)
				end
			end
		end
	end

	return result
end

type function shouldOmitKey(keyType: type, omittedKeys: { type }): boolean
	for _, omittedKeyType in omittedKeys do
		if omittedKeyType == keyType then
			return true
		end

		if omittedKeyType.tag == "singleton" and keyType.tag == "singleton" then
			if omittedKeyType:value() == keyType:value() then
				return true
			end
		end
	end

	return false
end

type function fn_omit(object: type, sig: type)
	if object.tag ~= "table" then
		return types.newtable()
	end

	if sig.tag ~= "function" then
		return object
	end

	local params = sig:parameters().head
	if params == nil then
		return object
	end

	local omittedKeys: { type } = {}
	for _, keyType in params do
		omittedKeys[#omittedKeys + 1] = keyType
	end

	local result = types.newtable()

	local indexer = object:indexer()
	if indexer ~= nil then
		result:setreadindexer(indexer.index, indexer.readresult)
		result:setwriteindexer(indexer.index, indexer.writeresult)
	end

	for key, prop in object:properties() do
		if not shouldOmitKey(key, omittedKeys) then
			if prop.read ~= prop.write then
				result:setreadproperty(key, prop.read)
				result:setwriteproperty(key, prop.write)
			else
				result:setproperty(key, prop.read)
			end
		end
	end

	return result
end

type function fn_pick(object: type, sig: type)
	if object.tag ~= "table" then
		return types.newtable()
	end

	if sig.tag ~= "function" then
		return types.newtable()
	end

	local params = sig:parameters().head
	if params == nil then
		return types.newtable()
	end

	local pickedKeys: { type } = {}
	for _, keyType in params do
		pickedKeys[#pickedKeys + 1] = keyType
	end

	local result = types.newtable()

	for key, prop in object:properties() do
		if shouldOmitKey(key, pickedKeys) then
			if prop.read ~= prop.write then
				result:setreadproperty(key, prop.read)
				result:setwriteproperty(key, prop.write)
			else
				result:setproperty(key, prop.read)
			end
		end
	end

	local indexer = object:indexer()
	if indexer ~= nil then
		for _, pickedKeyType in pickedKeys do
			if pickedKeyType.tag ~= "singleton" then
				result:setreadindexer(indexer.index, indexer.readresult)
				result:setwriteindexer(indexer.index, indexer.writeresult)
				break
			end
		end
	end

	return result
end

export type Merge<t...> = fn_merge<(t...) -> ()>

export type MergeFromSig<sig> = fn_merge<sig>
export type Concat<t...> = fn_concat<(t...) -> ()>
export type ConcatFromSig<sig> = fn_concat<sig>
export type Pop<object, count = number> = fn_pop<object, count>
export type Omit<object, keys...> = fn_omit<object, (keys...) -> ()>
export type OmitFromSig<object, sig> = fn_omit<object, sig>
export type Pick<object, keys...> = fn_pick<object, (keys...) -> ()>
export type PickFromSig<object, sig> = fn_pick<object, sig>

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

export type function Partial(object: type)
	local tag = object.tag

	if tag == "union" or tag == "intersection" then
		local result

		for _, component in object:components() do
			if component.tag == "nil" then
				continue
			end
			if result == nil then
				result = component
				continue
			end

			result = types.unionof(result, component)
		end

		return types.optional(result :: type)
	elseif tag == "table" then
		local result = types.newtable()
		local indexer = object:indexer()

		if indexer ~= nil then
			result:setreadindexer(indexer.index, Partial(indexer.readresult))
			result:setwriteindexer(indexer.index, indexer.writeresult)
		end

		for key, prop in object:properties() do
			local partialRead = Partial(prop.read)
			if prop.read ~= prop.write then
				result:setreadproperty(key, partialRead)
				result:setwriteproperty(key, prop.write)
			else
				result:setproperty(key, partialRead)
			end
		end

		return result
	end

	return types.optional(object)
end

return 1
