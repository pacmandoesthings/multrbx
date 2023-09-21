<?php
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
include($_SERVER['DOCUMENT_ROOT'] . '/UserInfo.php');
$AssetType = (int)($_GET['AssetTypeId'] ?? die(json_encode(["message" => "OK"])));

switch(true){case ($RBXTICKET == null):header("Location: ". $baseUrl ."/");die();break;}
$ShowBoxDone = (int)($_GET['ShowBoxDone'] ?? null);

switch($AssetType){
	case "6":
		$type = "Shirt";
		$button = "Clothing";
		break;
	case "7":
		$type = "T-Shirt";
		$button = "Clothing";
		break;
	case "8":
		$type = "Pants";
		$button = "Clothing";
		break;
	case "1":
		$type = "place";
		$button = "place";
		break;
		
	case "47":
		$type = "thumb";
		$button = "thumb";
		$gameid = (int)$_GET['gameid'];
		break;
	case "401":
		$type = "replace";
		$button = "replace";
		$gameid = (int)$_GET['gameid'];
		break;
	default:
		die(json_encode(["message" => "OK"]));
		break;
}
include($_SERVER['DOCUMENT_ROOT'] . '/Develop/DevelopAPI/UploadPost.php');
?>
<!DOCTYPE html>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/js/IncludeJS.php'); ?>
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/Roblox.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide2.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Build/UploadCSS.css' />
<form action="<?php echo $CurrPage; ?>" enctype="multipart/form-data" method="post">
   <div id="container">
      <div class="form-row">
         <label for="file">Find your file:</label>
         <input type="file" name="fileToUpload" id="fileToUpload">
         <span id="file-error" class="error"></span>
      </div>
      <div class="form-row">
	  <?php switch($AssetType){
	  case "47":
		echo "";
		echo '<input type="hidden" name="gameid" value="'.$gameid.'">';
		break;
	  case "401":
		echo "";
		echo '<input type="hidden" name="gameid" value="'.$gameid.'">';
		break;
	default:
		echo '<label for="name">'. $type .' Name:</label>';
		echo '         <input id="name" type="text" class="text-box text-box-medium" name="name" maxlength="50" tabindex="2">';

		break;
	 }
		?>
       
         <span id="name-error" class="error"></span>
      </div>
      <div class="form-row submit-buttons">
         <button type="submit" name="upload<?php echo $button; ?>" id="upload<?php echo $button; ?>" class="btn-medium btn-primary btn-level-element" tabindex="4">Upload</button>
<?php
switch(true){
	case (count($errors) > 0):
		foreach ($errors as $error){
		echo '<div id="upload-fee-item-result-error" class="status-error btn-level-element">'. $error .'</div>';
		}
	break;
}
?>
         <?php switch($ShowBoxDone){case "1":echo '<div id="upload-fee-item-result-success" class="status-confirm btn-level-element"><div><a id="upload-fee-confirmation-link" target="_top">'. $type .'</a> successfully created!</div></div>';break;} ?>
      </div>
   </div>
</form>