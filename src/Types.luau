export type Dictionary<K = string, V = number> = { [K]: V }
export type Array<T = number> = { T }
export type Func<T... = ...any, R... = ...any> = (T...) -> R...

return 1
