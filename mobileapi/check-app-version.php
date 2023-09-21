<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
$appVersion = $_GET['appVersion'];

switch(true){
	case (in_array($appVersion, $allowedVersions)):
		echo '{"data":{"UpgradeAction":"NotRequired"}}';
		break;
	default:
		echo '{"data":{"UpgradeAction":"Required"}}';
		break;
}
?>