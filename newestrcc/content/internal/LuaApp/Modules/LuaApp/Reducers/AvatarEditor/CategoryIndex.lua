local Modules = game:GetService("CoreGui"):FindFirstChild("RobloxGui").Modules
local ActionType = require(Modules.LuaApp.Actions.ActionType)

return function(state, action)
	if action.type == ActionType.SelectCategory then
		return action.categoryIndex
	elseif action.type == ActionType.ResetCategory then
		return nil
	end

	return state
end