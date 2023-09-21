<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/FuncTypes.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
header("content-type: text/plain");
$pid = (int)($_GET['PlaceId'] ?? die(json_encode(["message" => "Cannot process request at this time."])));
	switch(true){
		case ($pid):
			$PlaceFetch = $MainDB->prepare("SELECT * FROM asset WHERE id = :pid AND itemtype = 'place'");
			$PlaceFetch->execute([":pid" => $pid]);
			$Results = $PlaceFetch->fetch(PDO::FETCH_ASSOC);
			switch(true){
				case($Results):
					switch (file_exists($_SERVER['DOCUMENT_ROOT'] . "/asset/". $pid)){
						 case true:
							switch(true){
								case ($Results['approved'] == "1"):
									sign("\r\ngame:Load('". $baseUrl ."/asset/?id=". $pid ."')");
									break;
								default:
									switch(true){case($RBXTICKET == null):die(sign("\r\nprint('Asset visibility is restricted.')"));break;case($RBXTICKET !== null):switch(true){case($id == $Results['creatorid']):sign("\r\ngame:Load('". $baseUrl ."/asset/?id=". $pid ."')");break;default:die(sign('\r\nprint("Unable to verify asset owner.")'));break;}break;}
									break;
							}
							break;
						 default:
							sign('\r\nprint("Cannot retrieve game at this time.")');
							break;
					}
					break;
				default:
					sign('\r\nprint("Unable to fetch game.")');
					break;
			}
			break;
		default:
			sign('\r\nprint("Cannot process request at this time. Try again later.")');
			break;
	}
//to note here:
//there's a few issues with just going like sign(); instead of 
//sign('
//');
//so studio needs to load scripts, and to do this, the first line has to be ONLY the signature
//and then comes the actual script.
?>