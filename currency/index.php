<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
header("Content-Type: application/json");

// Extract the user ID from the URL
$requestUri = $_SERVER['REQUEST_URI'];
$parts = explode('/', $requestUri);
$userId = end($parts);

$GameFetch = $MainDB->prepare("SELECT robux FROM users WHERE id = :userId");
$GameFetch->execute(['userId' => $userId]);
$Results = $GameFetch->fetch(PDO::FETCH_ASSOC);

if ($Results !== false) {
    echo json_encode(["robux" => $Results['robux']]);
} else {
   echo json_encode(["robux" => 400]);
}
?>
