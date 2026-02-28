export type Dictionary<K = string, V = number> = { [K]: V }
export type Array<T = number> = { T }
export type PredicateDictionary<V = any, K = any, R = any> = (value: V, key: K, Dictionary<K, V>) -> R
export type PredicateArray<T, R = any> = (value: T, index: number, Array<T>) -> R

return 1
