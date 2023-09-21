<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/FuncTypes.php');
header("content-type:text/plain");
$data = '
-- Setup studio cmd bar & load core scripts

pcall(function() game:GetService("InsertService"):SetFreeModelUrl("'. $baseUrl .'/game/Tools/InsertAsset.ashx?type=fm&q=%s&pg=%d&rs=%d") end)
pcall(function() game:GetService("InsertService"):SetFreeDecalUrl("'. $baseUrl .'/game/Tools/InsertAsset.ashx?type=fd&q=%s&pg=%d&rs=%d") end)

game:GetService("ScriptInformationProvider"):SetAssetUrl("'. $baseUrl .'/Asset/")
game:GetService("InsertService"):SetBaseSetsUrl("'. $baseUrl .'/game/Tools/InsertAsset.ashx?nsets=10&type=base")
game:GetService("InsertService"):SetUserSetsUrl("'. $baseUrl .'/game/Tools/InsertAsset.ashx?nsets=20&type=user&userid=%d")
game:GetService("InsertService"):SetCollectionUrl("'. $baseUrl .'/game/Tools/InsertAsset.ashx?sid=%d")
game:GetService("InsertService"):SetAssetUrl("'. $baseUrl .'/asset/?id=%d")
game:GetService("InsertService"):SetAssetVersionUrl("'. $baseUrl .'/asset/?assetversionid=%d")

pcall(function() game:GetService("SocialService"):SetFriendUrl("'. $baseUrl .'/game/LuaWebService/HandleSocialRequest.ashx?method=IsFriendsWith&playerid=%d&userid=%d") end)
pcall(function() game:GetService("SocialService"):SetBestFriendUrl("'. $baseUrl .'/game/LuaWebService/HandleSocialRequest.ashx?method=IsBestFriendsWith&playerid=%d&userid=%d") end)
pcall(function() game:GetService("SocialService"):SetGroupUrl("'. $baseUrl .'/game/LuaWebService/HandleSocialRequest.ashx?method=IsInGroup&playerid=%d&groupid=%d") end)
pcall(function() game:GetService("SocialService"):SetGroupRankUrl("'. $baseUrl .'/game/LuaWebService/HandleSocialRequest.ashx?method=GetGroupRank&playerid=%d&groupid=%d") end)
pcall(function() game:GetService("SocialService"):SetGroupRoleUrl("'. $baseUrl .'/game/LuaWebService/HandleSocialRequest.ashx?method=GetGroupRole&playerid=%d&groupid=%d") end)
pcall(function() game:GetService("GamePassService"):SetPlayerHasPassUrl("'. $baseUrl .'/game/GamePass/GamePassHandler.ashx?Action=HasPass&UserID=%d&PassID=%d") end)
pcall(function() game:GetService("MarketplaceService"):SetProductInfoUrl("'. $baseUrl .'/marketplace/productinfo?assetId=%d") end)
pcall(function() game:GetService("MarketplaceService"):SetDevProductInfoUrl("'. $baseUrl .'/marketplace/productDetails?productId=%d") end)
pcall(function() game:GetService("MarketplaceService"):SetPlayerOwnsAssetUrl("'. $baseUrl .'/ownership/hasasset?userId=%d&assetId=%d") end)

local result = pcall(function() game:GetService("ScriptContext"):AddStarterScript('. $StarterID .') end)
if not result then
  pcall(function() game:GetService("ScriptContext"):AddCoreScript('. $StarterID .',game:GetService("ScriptContext"),"StarterScript") end)
end';
sign("\r\n" . $data);
?>