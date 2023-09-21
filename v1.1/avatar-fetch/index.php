<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
header("Content-Type: application/json");
$UserId = (int)($_GET['userId'] ?? die(json_encode(["message" => "Cannot process request at this time."])));
$WardrobeSrh = $MainDB->prepare("SELECT * FROM bought WHERE boughtby = :id AND itemtype != 'model' AND wearing = '1' AND itemtype != 'advertisement' AND itemtype != 'decal' AND itemtype != 'audio' ORDER BY id");
$WardrobeSrh->execute([":id" => $UserId]);
$ReWDS = $WardrobeSrh->fetchAll();

$i = 0;

// Create an empty array to hold the boughtid values
$accessoryVersionIds = array();

// Loop through the $ReWDS result and populate the accessoryVersionIds array
foreach ($ReWDS as $item) {
    $accessoryVersionIds[] = (int) $item['boughtid']; // Convert the value to an integer
}

// Loop through $ReWDS again to retrieve additional data from the package table
foreach ($ReWDS as $item) {
    $packageId = $item['boughtid'];
    $packageQuery = $MainDB->prepare("SELECT * FROM package WHERE packageid = :packageId");
    $packageQuery->execute([':packageId' => $packageId]);
    $package = $packageQuery->fetch(PDO::FETCH_ASSOC);

    // Check if the package exists and has a 'boughtid'
    if ($package && isset($package['boughtid'])) {
        $accessoryVersionIds[] = (int) $package['boughtid']; // Convert the value to an integer
    }
}

// Remove duplicate values from the array
$accessoryVersionIds = array_unique($accessoryVersionIds);

$data = array(
    "resolvedAvatarType" => "R6",
    "equippedGearVersionIds" => [],
    "backpackGearVersionIds" => [],
    "accessoryVersionIds" => $accessoryVersionIds,
    "animations" => (object) ["Run" => 969731563],
    "bodyColorsUrl" => "http://www.mulrbx.com/asset/BodyColors.ashx?userId=".$UserId,
    "scales" => array(
        "Height" => 1.0000,
        "Width" => 1.0000,
        "Head" => 1.0000,
        "Depth" => 1.00,
        "Proportion" => 0.0000,
        "BodyType" => 0.0000
    )
);

$json = json_encode($data, JSON_UNESCAPED_SLASHES);
echo $json;
?>
