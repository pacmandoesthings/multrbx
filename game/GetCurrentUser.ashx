<?php 
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');

switch(true){
	case ($RBXTICKET == null):
		die('null');
		break;
	default:
		die($id);
		break;
} 
?>