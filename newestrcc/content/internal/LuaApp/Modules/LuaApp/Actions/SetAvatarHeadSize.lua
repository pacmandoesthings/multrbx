local ActionType = require(script.Parent.ActionType)

return function(head)
	return
	{
		type = ActionType.SetAvatarHeadSize,
		head = head,
	}
end
