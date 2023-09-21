<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php'); ?>
<?php
switch(true){case($RBXTICKET == null):die(header('Location: '. $baseUrl .'/Tools/ShowPopup.aspx?Err=4'));break;}
$ItemId = (int)($_GET['id'] ?? die(json_encode(['message' => 'Cannot handle request at this time.'])));
$HandleMethod = ($_GET['HandleMethod'] ?? die(json_encode(['message' => 'Cannot handle request at this time.'])));

$AssetFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND id = :pid AND public = '1'");
$AssetFetch->execute([":pid" => $ItemId]);
$Results = $AssetFetch->fetch(PDO::FETCH_ASSOC);

//a user cannot buy the following:
$NoPurchase = array('place', 'advertisement');
$errors = array();

switch(true){
	case ($Results):
		$ItemType = $Results['itemtype'];
		
		switch (true){
			case (!in_array($ItemType, $NoPurchase)):
				$AssetId = $Results['id'];
				$AssetName = $Results['name'];
				$CreatorID = $Results['creatorid'];
				$AssetFree = $Results['free'];
				
				//we check if item is already purchased
				$AP = $MainDB->prepare("SELECT * FROM bought WHERE boughtby = :id AND boughtid = :bid");
				$AP->execute([':id' => $id, ':bid' => $AssetId]);
				$Row = $AP->fetch(PDO::FETCH_ASSOC);
				switch(true){case ($Row):die(header('Location: '. $baseUrl .'/Tools/ShowPopup.aspx?Err=1'));break;}
				
				$SP = $MainDB->prepare("SELECT robux, ticket FROM users WHERE id = :id");
				$SP->execute([':id' => $CreatorID]);
				$SellerRow = $SP->fetch(PDO::FETCH_ASSOC);
				switch(true){case (!$SellerRow):die(header('Location: '. $baseUrl .'/Tools/ShowPopup.aspx?Err=1'));break;}
				
				switch($HandleMethod){
					case "Robux":
						$AssetRS = $Results['rsprice'];
						
						switch(true){case($AssetRS > $robux):die(header('Location: '. $baseUrl .'/Tools/ShowPopup.aspx?Err=2'));break;}
						$WasteRobux = $robux - $AssetRS;
						$WinRobux = $SellerRow['robux'] + $AssetRS;
						
						switch(true){
							case(count($errors) == 0):
								$UpdateRS = $MainDB->prepare("UPDATE users SET robux=? WHERE token=?")->execute([$WasteRobux, $RBXTICKET]);
								$UpdateSeller = $MainDB->prepare("UPDATE users SET robux=? WHERE id=?")->execute([$WinRobux, $CreatorID]);
								$InsertToDB = $MainDB->prepare("INSERT INTO `bought` (`id`, `boughtby`, `boughtid`, `boughtname`, `itemtype`, `wearing`, `boughtfrom`) VALUES (NULL, ?, ?, ?, ?, NULL, ?)")->execute([$id, $ItemId, $AssetName, $ItemType, $CreatorID]);
								die(header('Location: '. $baseUrl .'/Tools/ShowPopup.aspx?Err=3'));
								break;
						}
						break;
					case "Tickets":
						$AssetTX = $Results['tkprice'];
						
						switch(true){case($AssetTX > $ticket):die(header('Location: '. $baseUrl .'/Tools/ShowPopup.aspx?Err=2'));break;}
						$WasteTicket = $ticket - $AssetTX;
						$WinTicket = $SellerRow['ticket'] + $AssetTX;
						
						switch(true){
							case(count($errors) == 0):
								$UpdateTX = $MainDB->prepare("UPDATE users SET ticket=? WHERE token=?")->execute([$WasteTicket, $RBXTICKET]);
								$UpdateSeller = $MainDB->prepare("UPDATE users SET ticket=? WHERE id=?")->execute([$WinTicket, $CreatorID]);
								$InsertToDB = $MainDB->prepare("INSERT INTO `bought` (`id`, `boughtby`, `boughtid`, `boughtname`, `itemtype`, `wearing`, `boughtfrom`) VALUES (NULL, ?, ?, ?, ?, NULL, ?)")->execute([$id, $ItemId, $AssetName, $ItemType, $CreatorID]);
								die(header('Location: '. $baseUrl .'/Tools/ShowPopup.aspx?Err=3'));
								break;
						}
						break;
					case "Free":
						switch ($AssetFree){
							case "1":
								switch(true){
									case(count($errors) == 0):
										$InsertToDB = $MainDB->prepare("INSERT INTO `bought` (`id`, `boughtby`, `boughtid`, `boughtname`, `itemtype`, `wearing`, `boughtfrom`) VALUES (NULL, ?, ?, ?, ?, NULL, ?)")->execute([$id, $ItemId, $AssetName, $ItemType, $CreatorID]);
										die(header('Location: '. $baseUrl .'/Tools/ShowPopup.aspx?Err=3'));
										break;
								}
								break;
							default:
								die(header('Location: '. $baseUrl .'/Tools/ShowPopup.aspx?Err=2'));
								break;
						}
						break;
					default:
						die(json_encode(['message' => 'Method handle is not valid.']));
						break;
				}
				
				break;
			default:
				die(json_encode(['message' => 'Unable to purchase item type.']));
				break;
		}
		
		break;
	default:
		die(json_encode(['message' => 'Cannot handle request at this time.']));
		break;
}
?>