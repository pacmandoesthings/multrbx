<?php 
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
die(header('Location: '. $baseUrl .'/Login/Logout.ashx?returnUrl=/MobileView/'));
?>