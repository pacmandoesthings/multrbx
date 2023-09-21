<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');

$script = "charapp";
$id = (int)$_GET['userId'];
$assets = "";
	
$info = userInfo($id);
if($info !== false) 
{
	$id = $info->id;
	$wearing = "";
	
	$get = $MainDB->prepare("SELECT * FROM bought WHERE uid = :u AND wearing = 1 ORDER BY `id` DESC");
	$get->bindParam(":u", $id, PDO::PARAM_INT);
	$get->execute();
	if($get->rowCount() > 0) {
		$items = $get->fetchAll(PDO::FETCH_ASSOC);
		
		foreach($items as $item) {
			$equipped = "";
				$assets .= $url.'/asset/?id='.$item['aid'].$equipped.';';

		}
	}
}
else
{
	$id = 0;
}

echo "http://mulrbx.com/asset/BodyColors.ashx?userId=".$id."&tick=".time().";".$assets; //&tick to current timestamp cachebuster