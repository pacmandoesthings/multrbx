local MarketplaceService = game:GetService("MarketplaceService")

local Modules = script.Parent.Parent

local WebApi = require(Modules.WebApi)
local ActionType = require(Modules.ActionType)


local ASSET_THUMBNAIL_URL = "https://www.roblox.com/Thumbs/Asset.ashx?width=%u&height=%u&assetId=%u"
local ICON_SIZE = 64


local AssetActions = {}

function AssetActions.GetAssetInformation(assetId, callback)
	return function(store)
		spawn(function()
			if store:GetState().AssetInfo[assetId] then
				return
			end

			local info = MarketplaceService:GetProductInfo(assetId)

			if info.AssetTypeId == Enum.AssetType.Place.Value then
				local _, assetId = WebApi.GetGameIcon(info.AssetId)
				info.Icon = assetId
			else
				info.Icon = string.format(ASSET_THUMBNAIL_URL, ICON_SIZE, ICON_SIZE, info.AssetId)
			end

			store:Dispatch({
				type = ActionType.FetchedAssetCardInfo,
				assetInfo = info,
			})
			if callback then callback(store) end
		end)
	end
end



return AssetActions