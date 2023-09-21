<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/FuncTypes.php');
header("content-type:text/plain");
// Place join status results
// Waiting = 0,
// Loading = 1,
// Joining = 2,
// Disabled = 3,
// Error = 4,
// GameEnded = 5,
// GameFull = 6
// UserLeft = 10
// Restricted = 11
$placeId = (int)($_GET['placeId'] ?? die(json_encode(["message" => "Cannot process request at this time."])));
$request = ($_GET['request'] ?? die(json_encode(["message" => "Cannot process your request at this time. Try again later."])));
$UserId = rand(0, 3000);

$GetGameInfo = $MainDB->prepare("SELECT id, address, port FROM asset WHERE approved = '1' AND id = :pid AND itemtype = 'place'");
$GetGameInfo->execute([':pid' => $placeId]);
$GameInfo = $GetGameInfo->fetch(PDO::FETCH_ASSOC);
switch(true){case(!$GameInfo):die(json_encode(["jobId" => null, "status" => 10, "joinScriptUrl" => null, "authenticationUrl" => null, "authenticationTicket" => "Guest:" . $UserId], JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK));break;}

switch($request){
	case "RequestGame":
		die(json_encode(["jobId" => "2ea2b52a-1784-4eed-a6f3-7375b13f1a11", "status" => 2, "joinScriptUrl" => $baseUrl . "/Game/join.ashx?placeId=". $placeId ."&joinType=json", "authenticationUrl" => $baseUrl . "/Login/Negotiate.ashx", "authenticationTicket" => "Guest:" . $UserId], JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK));
		break;
	default:
		die(json_encode(["jobId" => null, "status" => 10, "joinScriptUrl" => null, "authenticationUrl" => null, "authenticationTicket" => "Guest:" . $UserId], JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK));
		break;
}
?>