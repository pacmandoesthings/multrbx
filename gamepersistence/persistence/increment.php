<?php
error_reporting(E_ERROR | E_PARSE);
   header("Content-Type: application/json");

  include($_SERVER['DOCUMENT_ROOT'] . '/config.php');

$placeId = isset($_GET['placeId']) ? intval($_GET['placeId']) : null;
$type = isset($_GET['type']) ? $_GET['type'] : null;
$key = isset($_GET['key']) ? $_GET['key'] : null;
$target = isset($_GET['target']) ? $_GET['target'] : null;
$scope = isset($_GET['scope']) ? $_GET['scope'] : null;
$pageSize = isset($_GET['pageSize']) ? intval($_GET['pageSize']) : null;
$by = isset($_GET['by']) ? intval($_GET['by']) : null;

if ($placeId === null || $type === null || $key === null || $target === null || $scope === null || $pageSize === null || $by === null) {
    http_response_code(400);
    die("Bad Request");
}

try {


    $stmt = $MainDB->prepare("UPDATE asset_datastore SET value = value + ? WHERE placeId = ? AND `key` = ? AND type = ? AND scope = ? AND target = ?");
    $stmt->execute([$by, $placeId, $key, $type, $scope, $target]);

    $stmt = $MainDB->prepare("SELECT * FROM asset_datastore WHERE placeId = ? AND `key` = ? AND type = ?");
    $stmt->execute([$placeId, $key, $type]);
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    usort($result, function ($a, $b) {
        return $b['value'] - $a['value'];
    });

    $data = [];
    for ($i = 0; $i < $pageSize; $i++) {
        if ($i < count($result)) {
            $result0 = $result[$i];
            $data[] = [
                "Value" => $result0['value'],
                "Target" => $result0['target']
            ];
        }
    }

    $response = [
        "Entries" => $data,
        "ExclusiveStartKey" => "AQEBAgRLZXky"
    ];

    header("Content-Type: application/json");
    echo json_encode($response);
} catch (PDOException $e) {
    http_response_code(500);
    die("Database Error: " . $e->getMessage());
}
