<?php
require $_SERVER['DOCUMENT_ROOT'] . '/config.php';
header("Content-Type: application/json");
error_reporting(E_ERROR | E_PARSE);

$pid = ($_GET['placeId'] ?? null);
$scope = ($_GET['scope'] ?? null);
$key = ($_GET['key'] ?? null);
$target = ($_GET['target'] ?? null);
$type = ($_GET['type'] ?? null);
$value = $_POST['value'];
$valueLength = ($_GET['valueLength'] ?? null);

$errorResponse = [
    "errors" => [
        [
            "code" => 0,
            "message" => "MethodNotAllowed"
        ]
    ]
];

if ($pid !== null) {
    $stmt = $MainDB->prepare("
        SELECT COUNT(*) as `count`
        FROM `asset_datastore`
        WHERE `placeId` = ? AND `key` = ? AND `type` = ? AND `scope` = ? AND `target` = ?
    ");
    $stmt->execute([$pid, $key, $type, $scope, $target]);
    $row = $stmt->fetch();

    if ($row['count'] > 0) {
        $stmt = $MainDB->prepare("
            UPDATE `asset_datastore`
            SET `value` = ?
            WHERE `placeId` = ? AND `key` = ? AND `type` = ? AND `scope` = ? AND `target` = ?
        ");
        $stmt->execute([$value, $pid, $key, $type, $scope, $target]);
    } else {
        $stmt = $MainDB->prepare("
            INSERT INTO `asset_datastore` (`placeId`, `key`, `type`, `scope`, `target`, `value`)
            VALUES (?, ?, ?, ?, ?, ?)
        ");
        $stmt->execute([$pid, $key, $type, $scope, $target, $value]);
    }
} else {
    // Handle the case where $pid is null
    // Display an error message or take appropriate action
}

$values = [
    array(
        "Value" => $_POST["value"],
        "Scope" => $scope,
        "Key" => $key,
        "Target" => $target
    )
];

die(json_encode(["data" => $values], JSON_NUMERIC_CHECK));
?>
