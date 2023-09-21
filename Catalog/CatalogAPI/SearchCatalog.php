<?php 
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
switch(true){
	case(isset($_POST['submitSearchButton'])):
		$searchitems = ($_POST['keywordTextbox']);
		switch(true){case (empty($searchitems)):header('Location: '. $baseUrl .'/Catalog');die();break;}
		switch(true){case (preg_match('/^[a-z0-9_]+$/i', $searchitems) == 0):header('Location: '. $baseUrl .'/Catalog');die();break;}
		
		header('Location: '. $baseUrl .'/Catalog/?itemname='. $searchitems .'');
		die();
		break;
	case(isset($_POST['submitCreatorButton'])):
		$searchcreator = ($_POST['creatorTextbox']);
		switch(true){case (empty($searchcreator)):header('Location: '. $baseUrl .'/Catalog');die();break;}
		switch(true){case (preg_match('/^[a-z0-9_]+$/i', $searchcreator) == 0):header('Location: '. $baseUrl .'/Catalog');die();break;}
		
		header('Location: '. $baseUrl .'/Catalog/?creator='. $searchcreator .'');
		die();
		break;
}
?>