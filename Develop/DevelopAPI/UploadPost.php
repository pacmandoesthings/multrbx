<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/FuncTypes.php'); ?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php'); ?>
<?php 
error_reporting(E_ERROR | E_PARSE);

switch(true){
  case ($RBXTICKET == null):
    header("Location: ". $baseUrl ."/");
    die();
    break;
}


$FetchAsset = $MainDB->prepare("SELECT MAX(id) AS id FROM asset");
$FetchAsset->execute();
$AllResults = $FetchAsset->fetch(PDO::FETCH_ASSOC);

$nextId = $AllResults['id'] + 1;
$nextestId = $nextId + 1;
$assetId = strip_tags($_POST['gameid']);

$FetchAsset2 = $MainDB->prepare("SELECT MAX(port) AS port FROM asset");
$FetchAsset2->execute();
$AllResults2 = $FetchAsset2->fetch(PDO::FETCH_ASSOC);

$nextPort = $AllResults2['port'] + 1;
$CreationDate = date("Y-m-d");
$errors = array();
$ValidTypes = array('1','6', '7', '8','401');


switch(true){
 case (isset($_POST['uploadClothing'], $_FILES['fileToUpload'])):
     $assetName = strip_tags($_POST['name']);
  
     switch(true){case (preg_match('/[a-z0-9_]+$/i', $assetName) == 0):array_push($errors, "Name contains illegal characters.");break;}
     switch(true){case(strlen($assetName) > 25):array_push($errors, "Name can't be more than 25 characters.");break;}
     switch(true){case (empty($assetName)):array_push($errors, "Name is empty.");break;}
     switch(true){case(!in_array($AssetType, $ValidTypes)):array_push($errors, "Unable to process request.");break;}
     $address = " ";
     $port = 0;
     $target_file = $_SERVER['DOCUMENT_ROOT'] . "/asset/" . $nextId;
     $FileType = strtolower(pathinfo(basename($_FILES['fileToUpload']['name']),PATHINFO_EXTENSION));
     switch(true){case($_FILES["fileToUpload"]["size"] > 500000):array_push($errors, "File is too large.");break;}
     switch(true){case ($FileType != "png" && $FileType != "jpg" && $FileType != "jpeg"):array_push($errors, "Wrong format.");break;}
    break;

 
  
  
  
  
 case (isset($_POST['uploadthumb'], $_FILES['fileToUpload'])):
     $assetId = strip_tags($_POST['gameid']);
     switch(true){case(!in_array($AssetType, $ValidTypes)):array_push($errors, "Unable to process request.");break;}
     $target_file = $_SERVER['DOCUMENT_ROOT'] . "/Tools/RenderedAssets/" . $assetId . ".png";
     $FileType = strtolower(pathinfo(basename($_FILES['fileToUpload']['name']),PATHINFO_EXTENSION));
     switch(true){case($_FILES["fileToUpload"]["size"] > 500000):array_push($errors, "File is too large.");break;}
     switch(true){case ($FileType != "png" && $FileType != "jpg" && $FileType != "jpeg"):array_push($errors, "Wrong format.");break;}
	 switch(true){
         case (isset($_POST['uploadthumb'])):
              echo 'success';
              move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file);
              header("Location: ". $baseUrl ."/Tools/Upload.aspx?ShowBoxDone=1&gameid=".$assetId."&AssetTypeId=". $AssetType);  
              break;
  
	 }
  
  
 case (isset($_POST['uploadplace'], $_FILES['fileToUpload'])):
     $assetName = strip_tags($_POST['name']);
     switch(true){case (preg_match('/[a-z0-9_]+$/i', $assetName) == 0):array_push($errors, "Name contains illegal characters.");break;}
     switch(true){case(strlen($assetName) > 25):array_push($errors, "Name can't be more than 25 characters.");break;}
     switch(true){case (empty($assetName)):array_push($errors, "Name is empty.");break;}
     switch(true){case(!in_array($AssetType, $ValidTypes)):array_push($errors, "Unable to process request.");break;}
     $target_file = $_SERVER['DOCUMENT_ROOT'] . "/thenewestrcchostcuzfunny/content/" . $nextId . ".rbxl";
     $FileType = strtolower(pathinfo(basename($_FILES['fileToUpload']['name']),PATHINFO_EXTENSION));
     $address = "37.143.61.72";
     $port = $nextPort;
     switch(true){case($_FILES["fileToUpload"]["size"] > 50000000000):array_push($errors, "File is too large.");break;}
     switch(true){case ($FileType != "rbxl" ):array_push($errors, "Wrong format.");break;}
	 
	  
     switch(true){
     case (count($errors) == 0):
         $InsertToDB = $MainDB->prepare("INSERT INTO `asset` (`id`,`name`,`creatorname`,`creatorid`,`updatedon`,`createdon`,`moreinfo`,`favorited`,`played`,`liked`,`disliked`,`genre`,`itemtype`,`rsprice`,`tkprice`,`address`,`port`) VALUES (NULL, ?, ?, ?, ?, ?, 'A creation of mine on MULTRBX.com', '0', '0', '0', '0', 'All', ?, '10', '5',? ,?)");
         $InsertToDB->execute([$assetName, $name, $id, $CreationDate, $CreationDate, $type, $address, $port]);
         move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file);
         header("Location: ". $baseUrl ."/Tools/Upload.aspx?ShowBoxDone=1&AssetTypeId=". $AssetType);
         die();
         break;
	 }	 
case (isset($_POST['uploadreplace'], $_FILES['fileToUpload'])):
    $reuploadId = strip_tags($_POST['gameid']);
    $target_file = $_SERVER['DOCUMENT_ROOT'] . "/thenewestrcchostcuzfunny/content/" . $reuploadId . ".rbxl";
    $FileType = strtolower(pathinfo($_FILES['fileToUpload']['name'], PATHINFO_EXTENSION));

    // Check if 'name' is provided and not empty
    if ($_FILES['fileToUpload']['name'] !== '') {
        if ($_FILES["fileToUpload"]["size"] > 50000000000) {
            array_push($errors, "File is too large.");
        } elseif ($FileType !== "rbxl") {
            array_push($errors, "Wrong format.");
        } else {
            $CheckIfExists = $MainDB->prepare("SELECT * FROM asset WHERE id = ? AND creatorid = ?");
            $CheckIfExists->execute([$reuploadId, $id]);

            $existingPlace = $CheckIfExists->fetch(PDO::FETCH_ASSOC);
            if ($existingPlace) {
                // Replace the rbxl file
                move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file);
                header("Location: ". $baseUrl ."/Tools/Upload.aspx?ShowBoxDone=1&AssetTypeId=". $AssetType);
                exit; // Added exit to stop executing further code
            } else {
                // The place doesn't exist in the asset table or the creator ID doesn't match, handle the error
                array_push($errors, "Place with ID $reuploadId does not exist or you are not the creator.");
            }
        }
    } else {
        array_push($errors, "No file selected.");
    }
    break;


  
	
  

	
  
 
  switch(true){
    case (count($errors) == 0):
      $InsertToDB = $MainDB->prepare("INSERT INTO `asset` (`id`,`name`,`creatorname`,`creatorid`,`updatedon`,`createdon`,`moreinfo`,`favorited`,`played`,`liked`,`disliked`,`genre`,`itemtype`,`rsprice`,`tkprice`,`address`,`port`) VALUES (NULL, ?, ?, ?, ?, ?, 'A creation of mine on MULTRBX.com', '0', '0', '0', '0', 'All', ?, '10', '5',? ,?)");
      $InsertToDB->execute([$assetName, $name, $id, $CreationDate, $CreationDate, $type, $address, $port]);
      move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file);
      header("Location: ". $baseUrl ."/Tools/Upload.aspx?ShowBoxDone=1&AssetTypeId=". $AssetType);
      die();
      break;
  
    case (isset($_POST['uploadthumb'])):
      echo 'success';
      move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file);
      header("Location: ". $baseUrl ."/Tools/Upload.aspx?ShowBoxDone=1&AssetTypeId=". $AssetType);  
      break;
  }
  break;
}
?>