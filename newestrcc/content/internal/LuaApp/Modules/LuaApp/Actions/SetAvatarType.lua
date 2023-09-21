local ActionType = require(script.Parent.ActionType)

return function(avatarType)
	return
	{
		type = ActionType.SetAvatarType,
		avatarType = avatarType,
	}
end
