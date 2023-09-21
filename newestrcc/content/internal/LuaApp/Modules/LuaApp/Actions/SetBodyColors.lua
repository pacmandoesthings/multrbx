local ActionType = require(script.Parent.ActionType)

return function(bodyColors)
	return
	{
		type = ActionType.SetBodyColors,
		bodyColors = bodyColors,
	}
end
