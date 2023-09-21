<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
header("Content-Type: application/json");
$UserId = (int)($_GET['userid'] ?? die(json_encode(["message" => "Cannot process request at this time."])));
$WardrobeSrh = $MainDB->prepare("SELECT * FROM bought WHERE boughtby = :id AND itemtype != 'model' AND wearing = '1' AND itemtype != 'advertisement' AND itemtype != 'decal' AND itemtype != 'audio' ORDER BY id");
$WardrobeSrh->execute([":id" => $UserId]);
$ReWDS = $WardrobeSrh->fetchAll();

$i = 0;


$data = array(
    "resolvedAvatarType" => "R15",
    "equippedGearVersionIds" => [],
    "backpackGearVersionIds" => [],
    "accessoryVersionIds" => [],
    "animations" => (object) [],
    "bodyColorsUrl" => "http://www.mulrbx.com/asset/BodyColors.ashx?userId=6",
    "scales" => array(
        "Height" => 1.0000,
        "Width" => 1.0000,
        "Head" => 1.0000,
        "Depth" => 1.00,
        "Proportion" => 0.0000,
        "BodyType" => 0.0000
    ),
    "emotes" => []
);

$json = json_encode($data, JSON_UNESCAPED_SLASHES);
echo $json;





?>
