<?php 
header('Content-type:image/png');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
$errimg = file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/Images/IDE/not-approved.png");
$penimg = file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/Images/IDE/pending.png");
$id = (int)($_GET['id'] ?? die($errimg));
$request = ($_GET['request'] ?? die($errimg));

switch($request){
	case "advertisement":
		header('Content-type:text/html');
		$AdType = ($_GET['adtype'] ?? die($errimg));
		$AdFetch = $MainDB->prepare("SELECT * FROM asset WHERE itemtype = 'advertisement' AND adtype = :adtype ORDER BY RAND() LIMIT 1");
		$AdFetch->execute([':adtype' => $AdType]);
		$AdResults = $AdFetch->fetch(PDO::FETCH_ASSOC);
		switch(true){
			case(!$AdResults):
				switch($AdType){
					case "block":
						echo '';
						break;
					case "top":
						echo '';
						break;
					case "rectangle":
						echo '';
						break;
				}
				break;
			default:
				switch (file_exists($_SERVER['DOCUMENT_ROOT'] . "/Tools/RenderedAssets/". $id .".png")){case true:die('<a href="'. $baseUrl . $adUrl .'" target="_top"><img src="'. $baseUrl .'/Tools/RenderedAssets/'. $id .'.png"></a>');break;};
				break;
		}
		break;
	case "avatar":
		$AssetFetch = $MainDB->prepare("SELECT * FROM users WHERE id = :id");
		$AssetFetch->execute([':id' => $id]);
		$Results = $AssetFetch->fetch(PDO::FETCH_ASSOC);
		switch(true){case(!$Results):die($errimg);break;}
		
		switch (file_exists($_SERVER['DOCUMENT_ROOT'] . "/Tools/RenderedUsers/". $id .".png")){
			case true:
				die(file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/Tools/RenderedUsers/". $id .".png"));
				break;
			case false:
				die($penimg);
				break;
		}
		break;
	default:
		$AssetFetch = $MainDB->prepare("SELECT * FROM asset WHERE  id = :id");
		$AssetFetch->execute([':id' => $id]);
		$Results = $AssetFetch->fetch(PDO::FETCH_ASSOC);
		switch(true){case(!$Results):die($errimg);break;}
	
		switch (file_exists($_SERVER['DOCUMENT_ROOT'] . "/Tools/RenderedAssets/". $id .".png")){
			case true:
				die(file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/Tools/RenderedAssets/". $id .".png"));
				break;
			case false:
				die($penimg);
				break;
		}
		break;
}
?>