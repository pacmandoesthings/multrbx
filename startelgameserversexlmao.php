<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');

$placeId = $_GET['id'];
$vipowner = (int) ($_GET['VipOwner'] ?? null);
$url = "http://mulrbx.com/soap/amogs/Roblox/gamestart.php?id=" . $placeId;
if ($vipowner !== null && $vipowner !== 0) {
	$url = "http://mulrbx.com/soap/amogs/Roblox/gamestart.php?vipowner=".$vipowner."&id=" . $placeId;
}

    file_get_contents($url);
	
	
exit();
