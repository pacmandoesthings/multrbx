local Modules = game:GetService("CoreGui"):FindFirstChild("RobloxGui").Modules
local ActionType = require(Modules.LuaApp.Actions.ActionType)

return function(state, action)
	state = state or false

	if action.type == ActionType.ToggleAvatarEditorFullView then
		return not state
	end

	if action.type == ActionType.SetAvatarEditorFullView then
		return action.fullView
	end

	return state
end
