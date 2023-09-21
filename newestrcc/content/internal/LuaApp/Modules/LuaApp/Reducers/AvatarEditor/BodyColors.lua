local Modules = game:GetService("CoreGui"):FindFirstChild("RobloxGui").Modules
local ActionType = require(Modules.LuaApp.Actions.ActionType)
local Immutable = require(Modules.Common.Immutable)

return function(state, action)
	state = state or {
		HeadColor = 194,
		LeftArmColor = 194,
		LeftLegColor = 194,
		RightArmColor = 194,
		RightLegColor = 194,
		TorsoColor = 194,
	}

	if action.type == ActionType.SetBodyColors or action.type == ActionType.SetOutfit then
		for key, value in pairs(action.bodyColors) do
			state = Immutable.Set(state, key, value)
		end
	end

	return state
end

