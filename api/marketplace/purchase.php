<?php
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
header("Content-Type: application/json");
header('Content-Length: 86');
header('Keep-Alive: timeout=5, max=100');
header('Connection: Keep-Alive');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $assetId = (int)($_GET['productId'] ?? null);
} elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $assetId = (int)($_POST['productId'] ?? null);
} else {
    die(json_encode(['message' => 'Invalid request method.']));
}

$GetAssetInfo = $MainDB->prepare("SELECT id, name, moreinfo, creatorid, creatorname, createdon, updatedon, rsprice, tkprice FROM asset WHERE id = :pid");
$GetAssetInfo->execute([':pid' => $assetId]);
$AssetInfo = $GetAssetInfo->fetch(PDO::FETCH_ASSOC);

switch (true) {
    case (!$AssetInfo):
        die(json_encode(['message' => 'Unable to load info.']));
        break;
}

$AssetJSON = array(
    "success" => true,
    "status" => "Bought",
    "receipt" => 19194396,
    "message" => (object) array() // Empty object
);

// Check if "ROBLOSECURITY" cookie is present
if (isset($_COOKIE['ROBLOSECURITY'])) {
    // Retrieve user's name and ID from the "users" table based on the token (cookie)
    $userToken = $_COOKIE['ROBLOSECURITY'];
    $GetUserInfo = $MainDB->prepare("SELECT id, name, robux FROM users WHERE token = :token");
    $GetUserInfo->execute([':token' => $userToken]);
    $UserInfo = $GetUserInfo->fetch(PDO::FETCH_ASSOC);

    if ($UserInfo) {
        // Deduct the "rsprice" from the user's Robux
        $rsprice = $AssetInfo['rsprice'];
        $updatedRobux = $UserInfo['robux'] - $rsprice;

        if ($updatedRobux >= 0) {
            // Update the user's Robux in the database
            $UpdateUserRobux = $MainDB->prepare("UPDATE users SET robux = :robux WHERE id = :userid");
            $UpdateUserRobux->execute([':robux' => $updatedRobux, ':userid' => $UserInfo['id']]);

            // Insert a new record into the "bought" table
            $InsertBought = $MainDB->prepare("INSERT INTO bought (boughtby, boughtid, boughtname, itemtype, wearing, boughtfrom) VALUES (:boughtby, :boughtid, :boughtname, :itemtype, :wearing, :boughtfrom)");
            $InsertBought->execute([
                ':boughtby' => $UserInfo['id'],
                ':boughtid' => $assetId,
                ':boughtname' => $AssetInfo['name'],
                ':itemtype' => 'gamepass', // Replace 'type_value' with the actual item type
                ':wearing' => '', // Replace 'wearing_value' with the actual wearing status
                ':boughtfrom' => $AssetInfo['creatorid']
            ]);
        } else {
            die(json_encode(['message' => 'Insufficient Robux to make the purchase.']));
        }
    } else {
        die(json_encode(['message' => 'Invalid user token.']));
    }
}

die(json_encode($AssetJSON, JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK));
?>
