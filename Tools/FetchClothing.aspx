<?php
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
$GetType = ($_GET['type'] ?? die());
$AssetID = ($_GET['id'] ?? die());

switch($GetType){
	case "TS":
		$AssetFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND id = :id AND itemtype = 'T-Shirt'");
		$AssetFetch->execute([':id' => $AssetID]);
		$Results = $AssetFetch->fetch(PDO::FETCH_ASSOC);
		
		switch(true){
			case($Results):
				echo '<roblox xmlns:xmime="http://www.w3.org/2005/05/xmlmime" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.roblox.com/roblox.xsd" version="4">
	<External>null</External>
	<External>nil</External>
	<Item class="Shirt" referent="RBX188C484E5E2046CCAF2EC0D5BFBC7222">
		<Properties>
			<string name="Name">Clothing</string>
			<Content name="ShirtTemplate"><url>'. $baseUrl .'/asset/?id='. $AssetID .'</url></Content>
		</Properties>
	</Item>
</roblox>';
				break;
		}
		break;
	case "S":
		$AssetFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND id = :id AND itemtype = 'Shirt'");
		$AssetFetch->execute([':id' => $AssetID]);
		$Results = $AssetFetch->fetch(PDO::FETCH_ASSOC);
		
		switch(true){
			case($Results):
				echo '<roblox xmlns:xmime="http://www.w3.org/2005/05/xmlmime" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.roblox.com/roblox.xsd" version="4">
	<External>null</External>
	<External>nil</External>
	<Item class="Shirt" referent="RBX188C484E5E2046CCAF2EC0D5BFBC7222">
		<Properties>
			<string name="Name">Clothing</string>
			<Content name="ShirtTemplate"><url>'. $baseUrl .'/asset/?id='. $AssetID .'</url></Content>
		</Properties>
	</Item>
</roblox>';
				break;
		}
		break;
	case "P":
		$AssetFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND id = :id AND itemtype = 'Pants'");
		$AssetFetch->execute([':id' => $AssetID]);
		$Results = $AssetFetch->fetch(PDO::FETCH_ASSOC);
		
		switch(true){
			case($Results):
				echo '<roblox xmlns:xmime="http://www.w3.org/2005/05/xmlmime" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.roblox.com/roblox.xsd" version="4">
	<External>null</External>
	<External>nil</External>
	<Item class="Pants" referent="RBX188C484E5E2046CCAF2EC0D5BFBC7222">
		<Properties>
			<string name="Name">Clothing</string>
			<Content name="PantsTemplate"><url>'. $baseUrl .'/asset/?id='. $AssetID .'</url></Content>
		</Properties>
	</Item>
</roblox>';
				break;
		}
		break;
}
?>