<?php 
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/FuncTypes.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php'); 
switch(true){
	case ($RBXTICKET == null):
		header("Location: ". $baseUrl ."/");
		die();
		break;
}

$ItemId = (int)($_GET['id'] ?? die(header("Location: ". $baseUrl ."/")));
$allowedGenre = array('All', 'Fighthing', 'City', 'Western', 'RPG', 'Modern', 'Horror', 'Building');
$errors = array();
$RSTX = array();

$FetchItem = $MainDB->prepare("SELECT * FROM asset WHERE id = :pid AND creatorid = :id AND itemtype != 'advertisement'");
$FetchItem->execute([":pid" => $ItemId, ":id" => $id]);
$ItemInfo = $FetchItem->fetch(PDO::FETCH_ASSOC);
switch(true){case(!$ItemInfo):die(header("Location: ". $baseUrl ."/"));break;}
$ItemType = $ItemInfo['itemtype'];

switch(true){
	case (isset($_POST['postUpdate'])):
		//user wants to update asset
		switch($ItemType){
			case "place":
				$newName = strip_tags($_POST['name']);
				$newInfo = strip_tags($_POST['moreinfo']);
				switch(true){case (preg_match('/[a-z0-9_]+$/i', $newName) == 0):array_push($errors, "Name contains illegal characters.");break;}
				switch(true){case (!filter_var($newInfo, FILTER_DEFAULT)):array_push($errors, "Info contains illegal characters.");break;}
				switch(true){case(strlen($newName) > 25):array_push($errors, "Name can't be more than 25 characters.");break;}
				switch(true){case(strlen($newInfo) > 250):array_push($errors, "Info can't be more than 250 characters.");break;}
				switch(true){case ($newName == null):array_push($errors, "Name cannot be empty.");break;}
				switch(true){case ($newInfo == null):array_push($errors, "Info cant be empty.");break;}
				
				switch(true){
					case (count($errors) == 0):
						$UpdateGame = $MainDB->prepare("UPDATE asset SET name=?, moreinfo=? WHERE id=?")->execute([$newName, $newInfo, $ItemId]);
						die(header('Location: '. $baseUrl .'/Games/ViewGame.ashx?id=' . $ItemId));
						break;
				}
				break;
			default:
				$newName = strip_tags($_POST['name']);
				$newInfo = strip_tags($_POST['moreinfo']);
				switch(true){case (preg_match('/[a-z0-9_]+$/i', $newName) == 0):array_push($errors, "Name contains illegal characters.");break;}
				switch(true){case (!filter_var($newInfo, FILTER_DEFAULT)):array_push($errors, "Info contains illegal characters.");break;}
				switch(true){case(strlen($newName) > 25):array_push($errors, "Name can't be more than 25 characters.");break;}
				switch(true){case(strlen($newInfo) > 250):array_push($errors, "Info can't be more than 250 characters.");break;}
				switch(true){case ($newName == null):array_push($errors, "Name cannot be empty.");break;}
				switch(true){case ($newInfo == null):array_push($errors, "Info cant be empty.");break;}
				
				switch(true){
					case (count($errors) == 0):
						$UpdateGame = $MainDB->prepare("UPDATE asset SET name=?, moreinfo=? WHERE id=?")->execute([$newName, $newInfo, $ItemId]);
						die(header('Location: '. $baseUrl .'/Catalog/ViewItem.aspx?id=' . $ItemId));
						break;
				}
				break;
		}
		break;
	case (isset($_POST['postUpdateExtra'])):
		//user wants to update asset even more
		switch($ItemType){
			case "place":
				$newGenre = strip_tags($_POST['gametype']);
				switch(true){case (!in_array($newGenre, $allowedGenre)):array_push($errors, "Unable to verify signature.");break;}
				switch(true){
					case (count($errors) == 0):
						$UpdateGame = $MainDB->prepare("UPDATE asset SET genre=? WHERE id=?")->execute([$newGenre, $ItemId]);
						die(header('Location: '. $baseUrl .'/Games/ViewGame.ashx?id=' . $ItemId));
						break;
				}
				break;
			default:
				$newRS = filter_var($_POST['pricerobux'], FILTER_SANITIZE_NUMBER_FLOAT);
				$newTix = filter_var($_POST['pricetickets'], FILTER_SANITIZE_NUMBER_FLOAT);
				switch(true){case ($newRS !== ""):array_push($RSTX, "robux");break;}
				switch(true){case ($newTix !== ""):array_push($RSTX, "tix");break;}
				
				switch(true){
					case (count($errors) == 0):
						switch(true){
							case(count($RSTX) == 2):
								$UpdateRS = $MainDB->prepare("UPDATE asset SET rsprice=? WHERE id=?")->execute([$newRS, $ItemId]);
								$UpdateTX = $MainDB->prepare("UPDATE asset SET tkprice=? WHERE id=?")->execute([$newTix, $ItemId]);
								die(header('Location: '. $baseUrl .'/Catalog/ViewItem.aspx?id=' . $ItemId));
								break;
							case(count($RSTX) == 1):
								switch(true){
									case (in_array("robux", $RSTX)):
										$UpdateRS = $MainDB->prepare("UPDATE asset SET rsprice=? WHERE id=?")->execute([$newRS, $ItemId]);
										$UpdateTX = $MainDB->prepare("UPDATE asset SET tkprice=NULL WHERE id=?")->execute([$ItemId]);
										die(header('Location: '. $baseUrl .'/Catalog/ViewItem.aspx?id=' . $ItemId));
										break;
									case (in_array("tix", $RSTX)):
										$UpdateTX = $MainDB->prepare("UPDATE asset SET tkprice=? WHERE id=?")->execute([$newTix, $ItemId]);
										$UpdateRS = $MainDB->prepare("UPDATE asset SET rsprice=NULL WHERE id=?")->execute([$ItemId]);
										die(header('Location: '. $baseUrl .'/Catalog/ViewItem.aspx?id=' . $ItemId));
										break;
								}
								break;
							case(count($RSTX) == null):
								$UpdateRS = $MainDB->prepare("UPDATE asset SET rsprice = NULL WHERE id=?")->execute([$ItemId]);
								$UpdateTX = $MainDB->prepare("UPDATE asset SET tkprice = NULL WHERE id=?")->execute([$ItemId]);
								$UpdateFree = $MainDB->prepare("UPDATE asset SET free=1 WHERE id=?")->execute([$ItemId]);
								die(header('Location: '. $baseUrl .'/Catalog/ViewItem.aspx?id=' . $ItemId));
								break;
						}
						break;
				}
				break;
		}
		break;
	default:
		break;
}
?>