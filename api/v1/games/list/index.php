<?php
error_reporting(0);
header('Content-Type: text/plain');
$gametargetid = addslashes($_GET["gameSetTargetId"]);
$maxrows = addslashes($_GET["maxRows"]);
$startrows = addslashes($_GET["startRows"]);
$token = addslashes($_GET["sortToken"]);
$url = "https://games.roblox.com/v1/games/list?gameSetTargetId=$gametargetid&maxRows=$maxrows&startRows=$startrows&sortToken=$token";
$response = file_get_contents($url);
echo $response;
?>
<?php

?>