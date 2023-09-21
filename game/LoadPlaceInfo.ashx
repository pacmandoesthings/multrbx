<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/FuncTypes.php');
header("content-type:text/plain");
$PlaceId = (int)($_GET['PlaceId'] ?? die(json_encode(["message" => "Cannot process request at this time."])));

$GetAssetInfo = $MainDB->prepare("SELECT creatorid FROM asset WHERE approved = '1' AND itemtype = 'place' AND id = :pid");
$GetAssetInfo->execute([':pid' => $PlaceId]);
$AssetInfo = $GetAssetInfo->fetch(PDO::FETCH_ASSOC);

switch(true){case(!$AssetInfo):die(sign('
print("Unable to load info.")'));break;}

$data = '
local baseUrl = '. $baseUrl .'

-- Loaded by StartGameSharedScript --
pcall(function() game:SetCreatorID('. $AssetInfo['creatorid'] .', Enum.CreatorType.User) end)

pcall(function() game:GetService("SocialService"):SetFriendUrl(baseUrl .. "/Game/LuaWebService/HandleSocialRequest.ashx?method=IsFriendsWith&playerid=%d&userid=%d") end)
pcall(function() game:GetService("SocialService"):SetBestFriendUrl(baseUrl .. "/Game/LuaWebService/HandleSocialRequest.ashx?method=IsBestFriendsWith&playerid=%d&userid=%d") end)
pcall(function() game:GetService("SocialService"):SetGroupUrl(baseUrl .. "/Game/LuaWebService/HandleSocialRequest.ashx?method=IsInGroup&playerid=%d&groupid=%d") end)
pcall(function() game:GetService("SocialService"):SetGroupRankUrl(baseUrl .. "/Game/LuaWebService/HandleSocialRequest.ashx?method=GetGroupRank&playerid=%d&groupid=%d") end)
pcall(function() game:GetService("SocialService"):SetGroupRoleUrl(baseUrl .. "/Game/LuaWebService/HandleSocialRequest.ashx?method=GetGroupRole&playerid=%d&groupid=%d") end)
pcall(function() game:GetService("GamePassService"):SetPlayerHasPassUrl(baseUrl .. "/Game/GamePass/GamePassHandler.ashx?Action=HasPass&UserID=%d&PassID=%d") end)
pcall(function() game:GetService("MarketplaceService"):SetProductInfoUrl(baseUrl .. "/marketplace/productinfo?assetId=%d") end)
pcall(function() game:GetService("MarketplaceService"):SetDevProductInfoUrl(baseUrl .. "/marketplace/productDetails?productId=%d") end)
pcall(function() game:GetService("MarketplaceService"):SetPlayerOwnsAssetUrl(baseUrl .. "/ownership/hasasset?userId=%d&assetId=%d") end)
pcall(function() game:SetPlaceVersion(0) end)
pcall(function() game:SetVIPServerOwnerId(0) end)';

sign($data);
?>