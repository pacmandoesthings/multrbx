--[[
	An action that can be dispatched to a Rodux store.

    Name - name of the action
    fn - a function that will be called when dispatching the action

    Returns a table that when called as a function, calls fn
]]

return function(name, fn)
    assert(type(name) == "string", "A name must be provided to create an Action")
    assert(type(fn) == "function", "A function must be provided to create an Action")

    return setmetatable({
        name = name,
    }, {
        __call = function(self, ...)
            local result = fn(...)

            assert(type(result) == "table", "An action must return a table")

            result.type = name

            return result
        end
    })
end