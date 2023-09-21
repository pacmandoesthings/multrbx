<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/UserInfo.php');
include($_SERVER['DOCUMENT_ROOT'] . '/FuncTypes.php');
header("content-type:text/plain");
$token = ($_GET['TokenPlay'] ?? null);
$placeId = (int)($_GET['placeId'] ?? die(json_encode(["message" => "Cannot process request at this time."])));
$joinType = ($_GET['joinType'] ?? die(json_encode(["message" => "Cannot process your request at this time. Try again later."])));
$jobId = ($_GET['jobid'] ?? die(json_encode(["message" => "Cannot process your request at this time. Try again later."])));
$expiration_time = time() + (1 * 60 * 60);

switch(true){
	case ($token !== null):
		$GetPlayerInfo = $MainDB->prepare("SELECT id, name, membership, admin FROM users WHERE token = :token");
		$GetPlayerInfo->execute([':token' => $token]);
		$PlayerInfo = $GetPlayerInfo->fetch(PDO::FETCH_ASSOC);
		switch(true){case(!$PlayerInfo):die(json_encode(['message' => 'Cannot process your request at this time.']));break;}
		$userId = $PlayerInfo['id'];
		$userName = $PlayerInfo['name'];
		$userMembership = $PlayerInfo['membership'];
		$userAdmin = $PlayerInfo['admin'];
		setcookie("ROBLOSECURITY", $token, $expiration_time, "/", "mulrbx.com");
        setcookie(".ROBLOSECURITY", $token, $expiration_time, "/", "mulrbx.com");
		break;
	case ($RBXTICKET !== null):
		$GetPlayerInfo = $MainDB->prepare("SELECT id, name, membership, admin FROM users WHERE token = :token");
		$GetPlayerInfo->execute([':token' => $RBXTICKET]);
		$PlayerInfo = $GetPlayerInfo->fetch(PDO::FETCH_ASSOC);
		switch(true){case(!$PlayerInfo):die(json_encode(['message' => 'Cannot process your request at this time.']));break;}
		$userId = $PlayerInfo['id'];
		$userName = $PlayerInfo['name'];
		$userMembership = $PlayerInfo['membership'];
		$userAdmin = $PlayerInfo['admin'];
		break;
	default:
		die(json_encode(['message' => 'Cannot process your request at this time.']));
		break;
}

$GetGameInfo = $MainDB->prepare("SELECT id, address, port, creatorid, approved FROM asset WHERE id = :pid AND itemtype = 'place'");
$GetGameInfo->execute([':pid' => $placeId]);
$GameInfo = $GetGameInfo->fetch(PDO::FETCH_ASSOC);
switch(true){case(!$GameInfo):die(json_encode(['message' => 'Cannot process your request at this time.']));break;}

$GetServerInfo = $MainDB->prepare("SELECT * FROM open_servers WHERE jobid = :pid ");
$GetServerInfo->execute([':pid' => $jobId]);
$ServerInfo = $GetServerInfo->fetch(PDO::FETCH_ASSOC);
switch(true){case(!$ServerInfo):die(json_encode(['message' => 'Cannot process your requestOe at this time.']));break;}

function userExists($id)
{
	include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
	$get = $MainDB->prepare("SELECT * FROM users WHERE id = :i");
	$get->bindParam(":i", $id, PDO::PARAM_INT);
	$get->execute();
	if($get->rowCount() > 0) 
	{
		return true;
	}
	return false;
}

if ($ServerInfo['vipID'] !== null) {
    if ($userId !== $ServerInfo['vipID']) {
        $check = $MainDB->prepare("
            SELECT *
            FROM friends
            WHERE (user1 = :vipID OR user1 = :userId)
            AND (user2 = :vipID OR user2 = :userId)
        ");

        $check->execute(array(
            'vipID' => $ServerInfo['vipID'],
            'userId' => $userId
        ));

        // Check if there are any rows returned by the query
        if ($check->rowCount() === 0) {
            die(json_encode(['message' => 'Cannot process your request at this time.']));
        }
    }
}


$gameId = $GameInfo['id'];
$gameIp = $GameInfo['address'];
$gamePort = $ServerInfo['port'];
$gameCreator = $GameInfo['creatorid'];
$approved = $GameInfo['approved'];
function SignData(string $data, bool $rbxsig=true)
        {
            $sig = "";
            $key = wordwrap(file_get_contents($_SERVER["DOCUMENT_ROOT"] . "/game/howthefuckcananyonefindthis.pem"), 64, "\n",true);
            openssl_sign($data, $sig, $key, OPENSSL_ALGO_SHA1);

            if ($rbxsig) {
                return "--rbxsig%" . base64_encode($sig) . "%" . $data;
            }
            return base64_encode($sig);
        }



function ClientTicket($userId, $userName, $charapp, $jobId,$version) {
$privatekey = file_get_contents($_SERVER["DOCUMENT_ROOT"] . "/game/howthefuckcananyonefindthis.pem");
if($version != 1){$privatekey = file_get_contents($_SERVER["DOCUMENT_ROOT"] . "/game/howthefuckcananyonefindthis.pem");};
    $ticket = $userId . "\n" . $jobId . "\n" . date('n/j/Y\ g:i:s\ A');
    openssl_sign($ticket, $sig, $privatekey, OPENSSL_ALGO_SHA1);
    $sig = base64_encode($sig);
    $ticket2 = $userId . "\n" . $userName . "\n" . $charapp . "\n". $jobId . "\n" . date('n/j/Y\ g:i:s\ A');
    openssl_sign($ticket2, $sig2, $privatekey, OPENSSL_ALGO_SHA1);
    $sig2 = base64_encode($sig2);
    $finaltickversion1 = date('n/j/Y\ g:i:s\ A') . ";" . $sig2 . ";" . $sig;
    $final = date('n/j/Y\ g:i:s\ A') . ";" . $sig2 . ";" . $sig;
    if($version == 1){return($finaltickversion1);} else {return($final . ";$version");
};};

// Example usage



if ($approved == 0) {
 if ($gameCreator == $PlayerInfo['id']) {
        $success = 1;
    } elseif ($PlayerInfo['admin'] == 1)  {
		$success = 1;
    } else {
	die(json_encode(['message' => 'Cannot process your request at this time.']));
	}	
}

if ($userMembership == 1) {
  $joinMem = "BuildersClub";
} elseif ($userMembership == 2) {
  $joinMem = "TurboBuildersClub";
} elseif ($userMembership == 3) {
  $joinMem = "OutrageousBuildersClub";
} else {
  $joinMem = "None";
}






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
		$charapp = 'http://api.mulrbx.com/v1.1/avatar-fetch/?userId='. $userId;
		$version = 1;
$AMONGUSBALLS = ClientTicket($userId, $userName, $charapp, $jobId, $version);

		$data = '
{"ClientPort":0,"MachineAddress":"'. $gameIp .'","ServerPort":'. $gamePort .',"PingUrl":"","PingInterval":50,"UserName":"'. $userName .'","SeleniumTestMode":false,"UserId":'. $userId .',"SuperSafeChat":true,"CharacterAppearance":"'.$charapp.'","ClientTicket":"'.$AMONGUSBALLS.'","GameId":"00000000-0000-0000-0000-000000000000","PlaceId":'. $gameId .',"BaseUrl":"http://mulrbx.com/","ChatStyle":"ClassicAndBubble","VendorId":0,"ScreenShotInfo":"","VideoInfo":"","CreatorId":'. $gameCreator .',"CreatorTypeEnum":"User","MembershipType":"'. $joinMem .'","AccountAge":3000000,"GameChatType":"NoOne","CookieStoreFirstTimePlayKey":"rbx_evt_ftp","CookieStoreFiveMinutePlayKey":"rbx_evt_fDmp","CookieStoreEnabled":true,"IsRobloxPlace":false,"GenerateTeleportJoin":true,"IsUnknownOrUnder13":false,"SessionId":"","GameChatType":"AllUsers","DataCenterId":0,"UniverseId":2,"BrowserTrackerId":0,"UsePortraitMode":false,"FollowUserId":0,"characterAppearanceId":'. $userId .'}';
		sign($data);
		break;
	default:
		die(json_encode(["message" => "Unsupported request type."]));
		break;
}
?>