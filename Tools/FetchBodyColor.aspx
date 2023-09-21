<?php
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
$userId = (int)($_GET['id'] ?? die(json_encode(['message' => 'Cannot fetch request at this time.'])));
$ColorSrh = $MainDB->prepare("SELECT bodycolors FROM users WHERE id = :id");
$ColorSrh->execute([":id" => $userId]);
$ReCSR = $ColorSrh->fetch(PDO::FETCH_ASSOC);

switch(true){case(!$ReCSR):die();break;}
$BodyColors = $ReCSR['bodycolors'];
switch(true){case($BodyColors == null):die();break;}
$BodyCrs = explode(';', $BodyColors);
echo '<?xml version="1.0" encoding="utf-8" ?>
<roblox xmlns:xmime="http://www.w3.org/2005/05/xmlmime" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="'. $baseUrl .'/roblox.xsd" version="4">
	<External>null</External>
	<External>nil</External>
	<Item class="BodyColors">
		<Properties>
			<int name="HeadColor">'. $BodyCrs[1] .'</int>
			<int name="LeftArmColor">'. $BodyCrs[3] .'</int>
			<int name="LeftLegColor">'. $BodyCrs[5] .'</int>
			<string name="Name">Body Colors</string>
			<int name="RightArmColor">'. $BodyCrs[4] .'</int>
			<int name="RightLegColor">'. $BodyCrs[6] .'</int>
			<int name="TorsoColor">'. $BodyCrs[2] .'</int>
			<bool name="archivable">true</bool>
		</Properties>
	</Item>
</roblox>';
?>