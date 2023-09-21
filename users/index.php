<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
header("Content-Type: application/json");

$endpoint = $_GET['endpoint'] ?? null;

if ($endpoint === 'balance') {
    $userId = intval($_GET['id']);

    $GameFetch = $MainDB->prepare("SELECT robux FROM users WHERE id = :userId");
    $GameFetch->execute(['userId' => $userId]);
    $Results = $GameFetch->fetch(PDO::FETCH_ASSOC);

    if ($Results) {
        echo json_encode(["robux" => $Results['robux']]);
    } else {
        echo json_encode(["success" => false]);
    }
} elseif ($endpoint === 'user') {
    $userId = intval($_GET['id']);

    $GameFetch = $MainDB->prepare("SELECT id, name FROM users WHERE id = :userId");
    $GameFetch->execute(['userId' => $userId]);
    $Results = $GameFetch->fetch(PDO::FETCH_ASSOC);

    if ($Results) {
        echo json_encode(["success" => true, "Id" => $Results['id'], "Username" => $Results['name']]);
    } else {
        echo json_encode(["success" => false]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Invalid endpoint"]);
}
