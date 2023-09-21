local Modules = game:GetService("CoreGui"):FindFirstChild("RobloxGui").Modules
local ActionType = require(Modules.LuaApp.Actions.ActionType)

return function(state, action)
	if action.type == ActionType.SetAvatarType then
		return action.avatarType
	elseif action.type == ActionType.ToggleAvatarType then
		return state == "R6" and "R15" or "R6"
	end

	return state
end

