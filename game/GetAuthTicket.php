<?php
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
switch(true){
	case ($RBXTICKET):
		echo $name . ":" . $id . ":" . base64_encode($RBXTICKET);
		break;
	default:
		echo "Guest:". rand(0,9999);
		break;
}
?>