local ActionType = require(script.Parent.ActionType)

return function(assets)
	return
	{
		type = ActionType.SetAssets,
		assets = assets,
	}
end
