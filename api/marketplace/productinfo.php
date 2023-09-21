<?php
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
header('Content-Type: application/json');

$assetId = (int) ($_GET['assetId'] ?? die(json_encode(["message" => "Unable to process request."])));

$GetAssetInfo = $MainDB->prepare("SELECT id, name, moreinfo, creatorid, creatorname, createdon, updatedon, rsprice, tkprice, itemtype  FROM asset WHERE id = :pid");
$GetAssetInfo->execute([':pid' => $assetId]);
$AssetInfo = $GetAssetInfo->fetch(PDO::FETCH_ASSOC);

if (!$AssetInfo) {
    $GetBadgeInfo = $MainDB->prepare("SELECT id, name FROM badges WHERE id = :pid");
    $GetBadgeInfo->execute([':pid' => $assetId]);
    $AssetInfo2 = $GetBadgeInfo->fetch(PDO::FETCH_ASSOC);

    if (!$AssetInfo2) {
        die(json_encode(['message' => 'Unable to load info.']));
    }

    $AssetJSON = [
        "AssetId" => $AssetInfo2['id'],
        "ProductId" => $AssetInfo2['id'],
        "Name" => $AssetInfo2['name'],
    ];

    die(json_encode($AssetJSON, JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK));
}

$AssetJSON = [
    "AssetId" => $AssetInfo['id'],
    "ProductId" => $AssetInfo['id'],
    "Name" => $AssetInfo['name'],
    "Description" => $AssetInfo['moreinfo'],
    "AssetTypeId" => 0,
	"ProductType" => $AssetInfo['itemtype'],
    "Creator" => [
        "Id" => $AssetInfo['creatorid'],
        "Name" => $AssetInfo['creatorname'],
    ],
    "IconImageAssetId" => $AssetInfo['id'],
    "Created" => $AssetInfo['createdon'],
    "Updated" => $AssetInfo['updatedon'],
    "PriceInRobux" => $AssetInfo['rsprice'],
    "PriceInTickets" => $AssetInfo['tkprice'],
    "Sales" => 0,
    "IsNew" => true,
    "IsForSale" => true,
    "IsPublicDomain" => false,
    "IsLimited" => false,
    "IsLimitedUnique" => false,
    "Remaining" => 0,
    "MinimumMembershipLevel" => 0,
    "ContentRatingTypeId" => 0,
];

die(json_encode($AssetJSON, JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK));
?>
