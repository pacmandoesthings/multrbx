<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php'); 
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/ProdLogin.php');

$stmt = $MainDB->prepare("UPDATE `asset` SET `played` = ? WHERE `id` = ?");
$stmt->execute([$_GET['players'],$_GET['id']]);

  ?>