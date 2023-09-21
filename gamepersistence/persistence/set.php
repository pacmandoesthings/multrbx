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


try {
    $stmt = $MainDB->prepare("INSERT INTO `asset_datastore` (`id`, `placeId`, `key`, `type`, `scope`, `target`, `value`, `valueLength`) VALUES (NULL, ?, ?, ?, ?, ?, ?, NULL)");
    $stmt->execute([$pid, $key, $type, $scope, $target, $value]);

   $successResponse = [
    "data" => []
];
echo json_encode($successResponse);
} catch (PDOException $e) {
    $errorResponse = [
        "errors" => [
            [
                "code" => $e->getCode(),
                "message" => $e->getMessage()
            ]
        ]
    ];
    die(json_encode($errorResponse));
}
