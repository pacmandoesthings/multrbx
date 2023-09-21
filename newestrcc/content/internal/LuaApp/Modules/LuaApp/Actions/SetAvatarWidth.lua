local ActionType = require(script.Parent.ActionType)

return function(width, depth)
	return
	{
		type = ActionType.SetAvatarWidth,
		width = width,
		depth = depth,
	}
end
