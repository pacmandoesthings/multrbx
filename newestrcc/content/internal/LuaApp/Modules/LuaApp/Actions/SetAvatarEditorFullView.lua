local ActionType = require(script.Parent.ActionType)

return function(fullView)
	return
	{
		type = ActionType.SetAvatarEditorFullView,
		fullView = fullView,
	}
end
