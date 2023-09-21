<?php
require("/new/xampp/htdocs/corescripts/settings.php");
header("content-type:text/plain");
$clientyear = "2022";
$year = $clientyear;
$id = $userid;
$port = "53640";
$ip = "26.76.93.232";
$status = file_get_contents("http://www.sitetest4.robloxlabs.com/game/placelauncherstatus.ashx"); 
$url = "http://www.sitetest4.robloxlabs.com/scripts/joinscripts/$clientyear?&id=$id&port=$port&year=$clientyear&username=$username&membership=$membership&ip=$ip&port=$port";
?>
{
  "jobId": "Test",
  "status": 2,
  "joinScriptUrl": "string",
  "authenticationUrl": "string",
  "authenticationTicket": "string",
  "message": "string",
  "joinScript": {
    "ClientPort": 0,
    "MachineAddress": "<?php echo $ip ?>",
    "ServerPort": <?php echo $port ?>,
    "ServerConnections": [
      {
        "Address": "<?php echo $ip ?>",
        "Port": <?php echo $port ?>
      }
    ],
    "UdmuxEndpoints": [
      {
        "Address": "<?php echo $ip ?>",
        "Port": <?php echo $port ?>
      }
    ],
    "DirectServerReturn": false,
    "TokenGenAlgorithm": 0,
    "PepperId": 0,
    "TokenValue": "string",
    "PingUrl": "string",
    "PingInterval": 120,
    "UserName": "<?php echo $username ?>",
    "DisplayName": "<?php echo $displayname ?>",
    "HasVerifiedBadge": true,
    "SeleniumTestMode": true,
    "UserId": <?php echo $userid ?>,
    "RobloxLocale": "en_us",
    "GameLocale": "en_us#RobloxTranslateAbTest2",
    "SuperSafeChat": false,
    "FlexibleChatEnabled": true,
    "CharacterAppearance": "string",
    "ClientTicket": "string",
    "GameId": "string",
    "PlaceId": 0,
    "BaseUrl": "http://assetgame.sitetest4.robloxlabs.com/",
    "ChatStyle": "ClassicAndBubble",
    "CreatorId": 1,
    "CreatorTypeEnum": "User",
    "MembershipType": "Premium",
    "AccountAge": 0,
    "CookieStoreFirstTimePlayKey": "string",
    "CookieStoreFiveMinutePlayKey": "string",
    "CookieStoreEnabled": true,
    "IsUnknownOrUnder13": false,
    "GameChatType": "AllUsers",
    "SessionId": "string",
    "AnalyticsSessionId": "string",
    "DataCenterId": 0,
    "UniverseId": 0,
    "FollowUserId": 0,
    "characterAppearanceId": 0,
    "CountryCode": "string",
    "AlternateName": "string",
    "RandomSeed1": "string",
    "ClientPublicKeyData": "string",
    "RccVersion": "string",
    "ChannelName": "string"
  }
}


