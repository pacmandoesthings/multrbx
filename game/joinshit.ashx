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
		$UserId = $PlayerInfo['id'];
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
		$UserId = $PlayerInfo['id'];
		$userName = $PlayerInfo['name'];
		$userMembership = $PlayerInfo['membership'];
		$userAdmin = $PlayerInfo['admin'];
		break;
	default:
		die(json_encode(['message' => 'Cannot process your request at this time.']));
		break;
}


$gameId = 2;
$gameIp = "37.143.61.72";
$gamePort = 53640;
$gameCreator = 6;

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

function ClientTicket(array $arguments)
        {
            //is this a bad method of doing this?
            if (sizeof($arguments) == 5) {
                $UserId = $arguments[0];
                $accountage = $arguments[1];
                $username = $arguments[2];
                $characterappearance = $arguments[3];
                $jobid = $arguments[4];

                $ticket = "";

                if ($UserId && 
                userExists($UserId) && 
                $accountage && 
                $username &&  
                $characterappearance && 
                $jobid) {
                    $timestamp = "1138516781";
                    $sig1 = SignData($UserId . "\n" . $username . "\n" . $characterappearance . "\n" . $jobid . "\n" . $timestamp, false);
                    $sig2 = SignData($UserId . "\n" . $jobid . "\n" . $timestamp, false);
                    $ticket = $timestamp.";".$sig1.";".$sig2;
                }
            }
            return $ticket;
        }
		$CharacterAppearance = $baseUrl .'/Tools/FetchCharacterAppeareance.aspx?id='. $UserId;
		$accountage = 94031095;
		$arguments = array(
    $UserId,
    $accountage,
    $userName,
    $CharacterAppearance,
    $jobId
);
$AMONGUSBALLS = ClientTicket($arguments);

if ($userMembership == 1) {
    $joinMem = "BuildersClub";
} elseif ($userMembership == 2) {
    $joinMem = "TurboBuildersClub";
} elseif ($userMembership == 3) {
    $joinMem = "OutrageousBuildersClub";
} else {
    $joinMem = "None";
}

switch ($joinType) {
    case "lua":
        // Existing code for lua request type
        break;
    case "json":
        $data = '--rbxsig2%dTqdbW67JQwDfe9qnwmjBuy2FcsvWET43/BjdLAkuJX2OWTMYyiomVxFXksRn5JgJNCMelGU4cINs6xovCWp/stTHeukrV26opMetBr9U6GkW3ec4h1PVgXlwWGNMDQFCjXUGW3n00G+REEzDlTScdqnz8BBM5ZNSe33oF2V/1tDUDuSmBUufPnkTYjlmjK6XrCoa/lM6nkL4En2/bzwdKGXRns88MJNXOSzYQXCzOf7d/iAyvl3B0CQd+JUsJSdztZAXWCh7KUhL3GDYfN4XRPa0x3taEZMyBoPtmZ6ve3jUqXPih7GRYp0XAv7z3hOGzkF8UZonNKI0yv3Iok/Sg==%
{"ClientPort":0,"MachineAddress":"37.143.61.72","ServerPort":53640,"ServerConnections":[{"Address":"37.143.61.72","Port":53640}],"DirectServerReturn":true,"PingUrl":"","PingInterval":120,"UserName":"'.$userName.'","DisplayName":"'.$userName.'","SeleniumTestMode":false,"UserId":'.$UserId.',"RobloxLocale":"en_us","GameLocale":"en_us#RobloxTranslateAbTest2","SuperSafeChat":false,"CharacterAppearance":"https://api.mulrbx.com/v1.1/avatar-fetch/?userid='.$UserId.'","ClientTicket":"2022-03-26T05:13:05.7649319Z;dj09X5iTmYtOPwh0hbEC8yvSO1t99oB3Yh5qD/sinDFszq3hPPaL6hH16TvtCen6cABIycyDv3tghW7k8W+xuqW0/xWvs0XJeiIWstmChYnORzM1yCAVnAh3puyxgaiIbg41WJSMALRSh1hoRiVFOXw4BKjSKk7DrTTcL9nOG1V5YwVnmAJKY7/m0yZ81xE99QL8UVdKz2ycK8l8JFvfkMvgpqLNBv0APRNykGDauEhAx283vARJFF0D9UuSV69q6htLJ1CN2kXL0Saxtt/kRdoP3p3Nhj2VgycZnGEo2NaG25vwc/KzOYEFUV0QdQPC8Vs2iFuq8oK+fXRc3v6dnQ==;BO8oP7rzmnIky5ethym6yRECd6H14ojfHP3nHxSzfTs=;XsuKZL4TBjh8STukr1AgkmDSo5LGgQKQbvymZYi/80TYPM5/MXNr5HKoF3MOT3Nfm0MrubracyAtg5O3slIKBg==;6","GameId":"29fd9df4-4c59-4d8c-8cee-8f187b09709b","PlaceId":2,"BaseUrl":"http://mulrbx.com/","ChatStyle":"Classic","CreatorId":6,"CreatorTypeEnum":"User","MembershipType":"Premium","AccountAge":1859,"CookieStoreFirstTimePlayKey":"rbx_evt_ftp","CookieStoreFiveMinutePlayKey":"rbx_evt_fmp","CookieStoreEnabled":true,"IsUnknownOrUnder13":false,"GameChatType":"AllUsers","SessionId":"{\"SessionId\":\"c89589f1-d1de-46e3-80e0-2703d1159409\",\"GameId\":\"29fd9df4-4c59-4d8c-8cee-8f187b09709b\",\"PlaceId\":2,\"ClientIpAddress\":\"207.241.232.186\",\"PlatformTypeId\":5,\"SessionStarted\":\"2022-03-26T05:13:05.762819Z\",\"BrowserTrackerId\":129849985826,\"PartyId\":null,\"Age\":80.2683342765271,\"Latitude\":37.78,\"Longitude\":-122.465,\"CountryId\":1,\"PolicyCountryId\":null,\"LanguageId\":41,\"BlockedPlayerIds\":[],\"JoinType\":\"MatchMade\",\"PlaySessionFlags\":0,\"MatchmakingDecisionId\":\"a0311216-ec21-4b5d-b3c0-8538a9a4dc7d\",\"UserScoreObfuscated\":4895515560,\"UserScorePublicKey\":235,\"GameJoinMetadata\":{\"JoinSource\":0,\"RequestType\":0},\"RandomSeed2\":\"7HOfysTid4XsV/3mBPPPhKHIykE4GXSBBBzd93rplbDQ3bNSgPFcR9auB780LjNYg+4mbNQPOqTmJ2o3hUefmw==\",\"IsUserVoiceChatEnabled\":false,\"SourcePlaceId\":null}","AnalyticsSessionId":"c89589f1-d1de-46e3-80e0-2703d1159409","DataCenterId":302,"UniverseId":2,"FollowUserId":0,"characterAppearanceId":244775698,"CountryCode":"US","RandomSeed1":"7HOfysTid4XsV/3mBPPPhKHIykE4GXSBBBzd93rplbDQ3bNSgPFcR9auB780LjNYg+4mbNQPOqTmJ2o3hUefmw==","ClientPublicKeyData":"{\"creationTime\":\"19:56 11/23/2021\",\"applications\":{\"RakNetEarlyPublicKey\":{\"versions\":[{\"id\":2,\"value\":\"HwatfCnkndvyKCMPSa0VAl2M2c0GQv9+0z0kENhcj2w=\",\"allowed\":true}],\"send\":2,\"revert\":2}}}"}';
        echo($data);
        break;
    default:
        die(json_encode(["message" => "Unsupported request type."]));
        break;
}
?>
