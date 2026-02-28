export type Dictionary<K = string, V = number> = { [K]: V }
export type Array<T = number> = { T }
export type Predicate<V = any, K = any, R = any> = (value: V, key: K, Dictionary<K, V>) -> R

return 1
