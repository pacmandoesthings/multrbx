<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');

$suggest = ($_GET['suggest'] ?? null);

switch(true){
	case ($suggest !== null):
		$UndoEncrypt = (base64_decode($suggest) ?? die(header('Location: '. $baseUrl)));
		
		switch(true){case(!filter_var($UndoEncrypt, FILTER_DEFAULT)):die(json_encode(["message" => "Unable to confirm identity.", "token" => htmlspecialchars($suggest), "error" => "INVALID_USER"]));break;}
		
		$GetAuthInfo = $MainDB->prepare("SELECT id FROM users WHERE token = :token");
		$GetAuthInfo->execute([':token' => $UndoEncrypt]);
		$AuthInfo = $GetAuthInfo->fetch(PDO::FETCH_ASSOC);
		$IdAuth = ($AuthInfo['id'] ?? null);
		
		switch(true){
			case ($IdAuth !== null):
				setcookie("ROBLOSECURITY", $UndoEncrypt, time()+9900, "/", $_SERVER['SERVER_NAME']);
				die($suggest);
				break;
			default:
				die(json_encode(["message" => "Unable to confirm identity.", "token" => htmlspecialchars($suggest), "error" => "INVALID_USER"]));
				break;
		}
		break;
}
?>