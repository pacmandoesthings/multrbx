local Modules = script.Parent.Parent
local Immutable = require(Modules.Common.Immutable)

return function(state, action)
	state = state or {OpenApp = ""}

	if action.type == "OpenApp" then
		return Immutable.Set(state, "OpenApp", action.appName)
	end

	return state
end

