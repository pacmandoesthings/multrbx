<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/FuncTypes.php');
header("content-type:text/plain");
$token = ($_GET['TokenPlay'] ?? null);
$placeId = (int)($_GET['placeId'] ?? die(json_encode(["message" => "Cannot process request at this time."])));
$joinType = ($_GET['joinType'] ?? die(json_encode(["message" => "Cannot process your request at this time. Try again later."])));

switch(true){
	case ($token !== null):
		$GetPlayerInfo = $MainDB->prepare("SELECT id, name FROM users WHERE token = :token");
		$GetPlayerInfo->execute([':token' => $token]);
		$PlayerInfo = $GetPlayerInfo->fetch(PDO::FETCH_ASSOC);
		switch(true){case(!$PlayerInfo):die(json_encode(['message' => 'Cannot process your request at this time.']));break;}
		$userId = $PlayerInfo['id'];
		$userName = $PlayerInfo['name'];
		break;
	case ($RBXTICKET !== null):
		$GetPlayerInfo = $MainDB->prepare("SELECT id, name FROM users WHERE token = :token");
		$GetPlayerInfo->execute([':token' => $RBXTICKET]);
		$PlayerInfo = $GetPlayerInfo->fetch(PDO::FETCH_ASSOC);
		switch(true){case(!$PlayerInfo):die(json_encode(['message' => 'Cannot process your request at this time.']));break;}
		$userId = $PlayerInfo['id'];
		$userName = $PlayerInfo['name'];
		break;
	default:
		$userId = 0;
		$userName = "Guest" . rand(1,3000);
		break;
}

$GetGameInfo = $MainDB->prepare("SELECT id, address, port FROM asset WHERE approved = '1' AND id = :pid AND itemtype = 'place'");
$GetGameInfo->execute([':pid' => $placeId]);
$GameInfo = $GetGameInfo->fetch(PDO::FETCH_ASSOC);
switch(true){case(!$GameInfo):die(json_encode(['message' => 'Cannot process your request at this time.']));break;}
$gameId = $GameInfo['id'];
$gameIp = $GameInfo['address'];
$gamePort = $GameInfo['port'];

switch($joinType){
	case "lua":
		//this means we want lua
		$data = '
--cokes super cool joinscript have credit
--DONT SHARE THIS PAGE, Giving someone the link to this page allows them to be able to use your ROBLOSECURITY and log in as you!
nc = game:GetService("NetworkClient")
nc:PlayerConnect('. $userId .', "'. $gameIp .'", '. $gamePort .')

plr = game.Players.LocalPlayer
plr.Name = "'. $userName .'"
plr.CharacterAppearance = "'. $baseUrl .'/Tools/FetchCharacterAppeareance.aspx?id='. $userId .'"
		
game:GetService("Visit"):SetUploadUrl("")
game.Players:SetChatStyle("ClassicAndBubble")

nc.ConnectionAccepted:connect(function(peer, repl)
game:SetMessageBrickCount()

local mkr = repl:SendMarker()
mkr.Received:connect(function()
game:SetMessage("Requesting Character...")
repl:RequestCharacter()

game:SetMessage("Waiting for character...")
--because a while loop didnt work
chngd = plr.Changed:connect(function(prop)
if prop == "Character" then chngd:disconnect() end
end)
game:ClearMessage()
end)

repl.Disconnection:connect(function()
game:SetMessage("This game has shut down")
end)
end)
nc.ConnectionFailed:connect(function() game:SetMessage("Failed to connect to the game ID: 15") end)
nc.ConnectionRejected:connect(function() game:SetMessage("Failed to connect to the game (Connection Rejected)") end)';
		sign($data);
		break;
	case "json":
		//this means we want json, also we dont use json encode because other wise Signature kills itself
		$data = '
{"ClientPort":0,"MachineAddress":"'. $gameIp .'","ServerPort":'. $gamePort .',"PingUrl":"","PingInterval":20,"UserName":"'. $userName .'","SeleniumTestMode":true,"UserId":'. $userId .',"SuperSafeChat":false,"CharacterAppearance":"'. $baseUrl .'/Tools/FetchCharacterAppeareance.aspx?id='. $userId .'","ClientTicket":"","GameId":'. $gameId .',"PlaceId":'. $gameId .',"MeasurementUrl":"","WaitingForCharacterGuid":"26eb3e21-aa80-475b-a777-b43c3ea5f7d2","BaseUrl":"'. $baseUrl .'","ChatStyle":"ClassicAndBubble","VendorId":0,"ScreenShotInfo":"","VideoInfo":"","CreatorId":6,"CreatorTypeEnum":"User","MembershipType":"None","AccountAge":3000000,"CookieStoreFirstTimePlayKey":"rbx_evt_ftp","CookieStoreFiveMinutePlayKey":"rbx_evt_fmp","CookieStoreEnabled":true,"IsRobloxPlace":true,"GenerateTeleportJoin":false,"IsUnknownOrUnder13":false,"SessionId":"39412c34-2f9b-436f-b19d-b8db90c2e186|00000000-0000-0000-0000-000000000000|0|190.23.103.228|8|2021-03-03T17:04:47+01:00|0|null|null","DataCenterId":0,"UniverseId":'. $gameId .',"BrowserTrackerId":0,"UsePortraitMode":false,"FollowUserId":0,"characterAppearanceId":'. $userId .'}';
		sign($data);
		break;
	default:
		die(json_encode(["message" => "Unsupported request type."]));
		break;
}
?>