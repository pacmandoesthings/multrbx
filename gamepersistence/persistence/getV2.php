<?php
error_reporting(E_ERROR | E_PARSE);
  include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
   header("Content-Type: application/json");
    $errorResponse = [
        "errors" => [
            [
                "code" => 0,
                "message" => "MethodNotAllowed"
            ]
        ]
    ];


$placeId = ($_GET['placeId'] ?? die(json_encode($errorResponse)));
$scope = ($_GET['scope'] ?? die(json_encode($errorResponse)));
$type = ($_GET['type'] ?? die(json_encode($errorResponse)));

$GetGameInfo = $MainDB->prepare("SELECT * FROM asset_datastore WHERE placeId = :placeId AND scope = :scope AND `type` = :type ");
$GetGameInfo->execute([
    ':placeId' => $placeId,
    ':scope' => $scope,
    ':type' => $type,
]);
$GameInfo = $GetGameInfo->fetch(PDO::FETCH_ASSOC);


$data = array(
    array(
        "Value" => $GameInfo['value'],
        "Scope" => $scope,
        "Key" => $GameInfo['key'],
        "Target" => $GameInfo['target']
    )
);

$jsonData = json_encode(array("data" => $data));

die($jsonData);