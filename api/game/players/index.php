<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
header("Content-Type: application/json");

// Extract the user ID from the URL
$requestUri = $_SERVER['REQUEST_URI'];
$parts = explode('/', $requestUri);
$userId = end($parts);

echo json_encode(["ChatFilter" => "blacklist"]);
?>
