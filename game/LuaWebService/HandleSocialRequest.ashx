<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
header("content-type:text/plain");
$method = ($_GET["method"] ?? die(json_encode(["message" => "Cannot process request at this time."])));
$pid = ($_GET['playerid'] ?? die(json_encode(["message" => "Cannot process request at this time."])));
$uid = ($_GET['userid'] ?? null);
$gid = ($_GET['groupid'] ?? null);
switch ($method){
	case "GetGroupRank":
		switch(true){
			case (in_array($pid, $AdminList)):
				echo '<?xml version="1.0" encoding="UTF-8"?><Value Type="integer">255</Value>';
				break;
			default:
				echo '<?xml version="1.0" encoding="UTF-8"?><Value Type="integer">0</Value>';
				break;
		}
		break;
		
	case "IsBestFriendsWith":
		echo '<Value Type="boolean">false</Value>';
	break;
	case "IsFriendsWith":
		$Friends = $MainDB->prepare("SELECT * FROM friends WHERE user1 = ? AND user2 = ? or user1 = ? AND user2 = ?");
        $Friends->execute(array($pid, $uid, $uid, $pid));
        $Results = $Friends->fetchAll();
		switch(true){case(!$Results):die('<?xml version="1.0" encoding="UTF-8"?><Value Type="boolean">false</Value>');break;}
        
		echo '<?xml version="1.0" encoding="UTF-8"?><Value Type="boolean">true</Value>';
	break;
	case "IsInGroup":
		switch(true){
			case (in_array($pid, $AdminList)):
				echo '<?xml version="1.0" encoding="UTF-8"?><Value Type="boolean">true</Value>';
				break;
			default:
				echo '<?xml version="1.0" encoding="UTF-8"?><Value Type="boolean">false</Value>';
				break;
		}
		break;
	default:
		die(json_encode(["message" => "Cannot process request at this time."]));
		break;
}
?>

