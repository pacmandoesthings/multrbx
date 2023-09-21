<?php 
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
//TO NOTE: studio's browser dosen't seem to unset the cookie properly.
//if we try to get rid of the cookie, it simply changes the value to "deleted".
//we have to check for this value and turn it into null so the entirety of the site dosent go apeshit.
switch(true){
	case (isset($_COOKIE['ROBLOSECURITY'])):
		$RBXTICKET = $_COOKIE['ROBLOSECURITY'];
		switch ($RBXTICKET){case "deleted":$RBXTICKET = null;break;case (strpos($RBXTICKET, " ")):$RBXTICKET = null;break;}
		break;
	case (isset($_COOKIE['.ROBLOSECURITY'])):
		$RBXTICKET = $_COOKIE['.ROBLOSECURITY'];
		switch ($RBXTICKET){case "deleted":$RBXTICKET = null;break;case (strpos($RBXTICKET, " ")):$RBXTICKET = null;break;}
		break;
	default:
		$RBXTICKET = null;
		break;
}

switch(true){
	case ($RBXTICKET !== null):
		$GetInfo = $MainDB->prepare("SELECT termtype, robux, ticket, id, name, token, membership FROM users WHERE token = :token");
		$GetInfo->execute([':token' => $RBXTICKET]);
		$Info = $GetInfo->fetch(PDO::FETCH_ASSOC);
		$id = $Info['id'];
		$name = $Info['name'];
		$ticket = $Info['ticket'];
		$robux = $Info['robux'];
		$termtype = $Info['termtype'];
		$membership = $Info['membership'];
		switch(true){case ($termtype !== null):die(json_encode(["message" => "Terminated"]));break;}
		switch(true){case ($name == null):die(header('Location: '. $baseUrl .'/Login/Logout.ashx?returnUrl=/'));break;}
		die(json_encode(["UserName" => $name, "RobuxBalance" => $robux, "TicketsBalance" => $ticket, "IsAnyBuildersClubMember" => "false", "ThumbnailUrl" => $baseUrl . "/Tools/Asset.ashx?id=" . $id . "&request=avatar", "UserID" => $id], JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK));
		break;
}
?>
