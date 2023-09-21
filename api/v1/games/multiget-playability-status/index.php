<?php
header('Content-Type: text/plain');
$universeids = addslashes($_GET["universeIds"]);
$url = "https://games.roblox.com//v1/games/multiget-playability-status?universeIds=$universeids";
$response = file_get_contents($url);
//echo $response;
?>