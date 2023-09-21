<?php
header('Content-Type: text/plain');
$gamesorts = addslashes($_GET["gameSortsContext"]);
$url = "https://games.roblox.com/v1/games/sorts?gameSortsContext=$gamesorts";
$response = file_get_contents($url);
echo $response;
?>