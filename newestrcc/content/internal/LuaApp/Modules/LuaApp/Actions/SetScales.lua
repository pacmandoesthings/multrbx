local ActionType = require(script.Parent.ActionType)

return function(scales)
	return
	{
		type = ActionType.SetScales,
		scales = scales,
	}
end
