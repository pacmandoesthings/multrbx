<?php
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
header("Content-Type: application/json");
$assetId = (int)($_GET['productId'] ?? null);

$GetAssetInfo = $MainDB->prepare("SELECT id, name, moreinfo, creatorid, creatorname, createdon, updatedon, rsprice, tkprice FROM asset WHERE id = :pid");
$GetAssetInfo->execute([':pid' => $assetId]);
$AssetInfo = $GetAssetInfo->fetch(PDO::FETCH_ASSOC);




switch(true){case(!$AssetInfo):die(json_encode(['message' => 'Unable to load info.']));break;}

    $AssetJSON = [
        "success" => true,
		"status" => "Bought"

	];

die(json_encode($AssetJSON, JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK));
?>