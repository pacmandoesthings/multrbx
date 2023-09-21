local ActionType = require(script.Parent.ActionType)

return function(assetType, assetId)
	return
	{
		type = ActionType.EquipAsset,
		assetType = assetType,
		assetId = assetId,
	}
end
