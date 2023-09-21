<?php
header("content-type:text/plain");
$limit = addslashes($_GET["limit"]);
$url = "https://develop.roblox.com/v1/gametemplates?limit=$limit";
$theR = file_get_contents($url);
echo $theR
?>