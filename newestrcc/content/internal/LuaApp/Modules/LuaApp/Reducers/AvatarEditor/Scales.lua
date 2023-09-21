local Modules = game:GetService("CoreGui"):FindFirstChild("RobloxGui").Modules
local ActionType = require(Modules.LuaApp.Actions.ActionType)
local Immutable = require(Modules.Common.Immutable)

return function(state, action)
	state = state or {
		Height = 1.00;
		Width = 1.00;
		Depth = 1.00;
		Head = 1.00;
	}

	if action.type == ActionType.SetScales then
		for key, value in pairs(action.scales) do
			state = Immutable.Set(state, key, value)
		end
	elseif action.type == ActionType.SetAvatarHeight then
		return Immutable.Set(state, "Height", action.height)
	elseif action.type == ActionType.SetAvatarWidth then
		state = Immutable.Set(state, "Width", action.width)
		return Immutable.Set(state, "Depth", action.depth)
	elseif action.type == ActionType.SetAvatarHeadSize then
		return Immutable.Set(state, "Head", action.head)
	end

	return state
end

