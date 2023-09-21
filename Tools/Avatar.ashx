<?php 
header('Content-type:image/png');
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
$errimg = file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/Images/IDE/not-approved.png");
$penimg = file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/Images/IDE/pending.png");
$id = (int)($_GET['id'] ?? die($errimg));




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
}



?>