local ActionType = require(script.Parent.ActionType)

return function(height)
	return
	{
		type = ActionType.SetAvatarHeight,
		height = height,
	}
end
