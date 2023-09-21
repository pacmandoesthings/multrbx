local ActionType = require(script.Parent.ActionType)

return function(assetType, assetId)
	return
	{
		type = ActionType.UnequipAsset,
		assetType = assetType,
		assetId = assetId,
	}
end
