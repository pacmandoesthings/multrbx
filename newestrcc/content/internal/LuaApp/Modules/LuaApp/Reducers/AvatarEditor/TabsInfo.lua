local Modules = game:GetService("CoreGui"):FindFirstChild("RobloxGui").Modules
local ActionType = require(Modules.LuaApp.Actions.ActionType)
local Immutable = require(Modules.Common.Immutable)

return function(state, action)
	state = state or {}

	if action.type == ActionType.SelectCategoryTab then
		local categoryIndex = action.categoryIndex
		local tabInfo = {
			TabIndex = action.tabIndex;
			Position = action.position;
			FirstVisibleTabIndex = action.firstVisibleTabIndex;
		}
		return Immutable.Set(state, categoryIndex, tabInfo)
	elseif action.type == ActionType.ResetCategory then
		return {}
	end

	return state
end