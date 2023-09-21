<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/FuncTypes.php');
header("content-type: text/plain");
$AssetID = (int)($_GET['id'] ?? die(json_encode(["message" => "Unable to process request."])));

$AssetFetch = $MainDB->prepare("SELECT * FROM asset WHERE id = :pid");
$AssetFetch->execute([":pid" => $AssetID]);
$Results = $AssetFetch->fetch(PDO::FETCH_ASSOC);

$AssetType = ($Results['itemtype'] ?? null);

switch($AssetType){
	case "CoreScript":
		switch(file_exists($_SERVER["DOCUMENT_ROOT"] . "/asset/" . $AssetID)){
			case true:
				$file = file_get_contents($_SERVER["DOCUMENT_ROOT"] . "/asset/" . $AssetID);
				sign("\r\n" . $file);
				break;
			default:
				die(json_encode(['message' => 'Requested asset was not found.']));
		}
		break;
	default:
		switch(file_exists($_SERVER["DOCUMENT_ROOT"] . "/asset/" . $AssetID)){
			case true:
				$file = file_get_contents($_SERVER["DOCUMENT_ROOT"] . "/asset/" . $AssetID);
				echo $file;
				break;
			default:
				switch($AssetRedirect){
					case true:
						die(header('Location: https://assetdelivery.roblox.com/v1/asset/?id='. $AssetID));
						break;
					default:
						die(json_encode(['message' => 'Requested asset was not found.']));
						break;
				}
		}
		break;
}
?>