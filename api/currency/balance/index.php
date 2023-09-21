<?php
// Start of the file: Include the Configuration.php file
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');

header("Content-Type: application/json");

// Check if the ROBLOSECURITY token exists in the request
if (isset($_COOKIE['ROBLOSECURITY'])) {
    // Get the ROBLOSECURITY token
    $thecookie = $_COOKIE['ROBLOSECURITY'];

    // Assuming you have a PDO connection named $MainDB
    $GetPlayerInfo = $MainDB->prepare("SELECT id, name, membership, admin, robux, ticket FROM users WHERE token = :token");
    $GetPlayerInfo->execute([':token' => $thecookie]);
    $PlayerInfo = $GetPlayerInfo->fetch(PDO::FETCH_ASSOC);

    // Now you have the player information in the $PlayerInfo array
    // You can use it as needed
	
	$data = [
    "robux" => $PlayerInfo['robux'],
    "tickets" => $PlayerInfo['ticket']
];
} else {
	
	$data = [
    "robux" => 400,
    "tickets" => 400
];
}

// Continue with the rest of your code


$json = json_encode($data);

echo $json;
?>
