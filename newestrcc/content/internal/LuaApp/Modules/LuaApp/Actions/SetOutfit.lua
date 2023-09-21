local ActionType = require(script.Parent.ActionType)

return function(assets, bodyColors)
	return
	{
		type = ActionType.SetOutfit,
		assets = assets,
		bodyColors = bodyColors,
	}
end
