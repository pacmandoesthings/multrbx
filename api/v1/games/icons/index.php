<?php
//fixformat
header("content-type:text/plain");
$size = addslashes($_GET["size"]);
$format = addslashes($_GET["format"]);
$universeIds = addslashes($_GET["universeIds"]);
?>
<?php
$url ="https://thumbnails.roblox.com/v1/games/icons?universeIds=$universeIds&format=$format&size=$size";
$response = file_get_contents($url);
echo $response;
?>