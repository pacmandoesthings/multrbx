<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php
$returnUrl = ($_GET['returnUrl'] ?? die(json_encode(['message' => 'Cannot process request at this time.'])));

switch(true){
	case (isset($_COOKIE['ROBLOSECURITY'])):
		setcookie('ROBLOSECURITY', null, -1, '/', $_SERVER['SERVER_NAME']); 
		header("Location: ". $baseUrl . $returnUrl);
		die();
		break;
	default:
		header("Location: ". $baseUrl . $returnUrl);
		die();
		break;
}
?>