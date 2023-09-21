<?php 
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
switch(true){case ($RBXTICKET == null):header("Location: ". $baseUrl ."/");die();break;}
$ViewSide = (int)($_GET['View'] ?? die(header("Location: ". $baseUrl ."/Develop/?View=1")));
$ShowItems = "";
switch($ViewSide){
  case "1":
    $MyDevelop = $MainDB->prepare("SELECT * FROM asset WHERE creatorid = :id AND itemtype = 'place' ORDER BY id");
    $MyDevelop->execute([":id" => $id]);
    $EndSearch = $MyDevelop->fetchAll();
    switch(true){case(!$EndSearch):$ShowItems = "<span>No results found.</span>";break;}
    
    foreach($EndSearch as $AssetInfo){
      $ShowItems = $ShowItems . '<table class="item-table"><tbody><tr><td class="image-col"><a href="'. $baseUrl .'/Games/ViewGame.ashx?id='. $AssetInfo['id'] .'" class="item-image"><img class="" src="'. $baseUrl .'/Tools/Asset.ashx?id='. $AssetInfo['id'] .'&request=place"></a>            </td><td class="name-col"><a class="title" href="'. $baseUrl .'/Games/ViewGame.ashx?id='. $AssetInfo['id'] .'">'. $AssetInfo['name'] .'</a><table class="details-table"><tbody><tr><td class="item-date"><span>Created</span>'. $AssetInfo['createdon'] .'</td></tr></tbody></table></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><a href="'. $baseUrl .'/Develop/Edit.aspx?id='. $AssetInfo['id'] .'" class="btn-control btn-control-large">Edit</a></td></tr></tbody></table><div class="separator"></div>';
    }
    $Contents = '<h2>Create Games</h2><span class="aside-text">Dont know how? <a href="" target="_blank">well you are an idiot</a></span><iframe id="upload-iframe" class=" my-upload-iframe" src="'. $baseUrl .'/Tools/Upload.aspx?AssetTypeId=1" frameborder="0" scrolling="no"></iframe><table class="section-header"><tbody><tr><td class="content-title"><div><h2 class="header-text">Places</h2><span class="aside-text">0 out of 10 active slots used</span></div></td></tr></tbody></table><div class="items-container">'. $ShowItems .'</div>';
    break;
  case "6":
    $MyDevelop = $MainDB->prepare("SELECT * FROM asset WHERE creatorid = :id AND itemtype = 'Shirt' ORDER BY id");
    $MyDevelop->execute([":id" => $id]);
    $EndSearch = $MyDevelop->fetchAll();
    switch(true){case(!$EndSearch):$ShowItems = "<span>No results found.</span>";break;}
    
    foreach($EndSearch as $AssetInfo){
      $ShowItems = $ShowItems . '<table class="item-table"><tbody><tr><td class="image-col"><a href="'. $baseUrl .'/Catalog/ViewItem.aspx?id='. $AssetInfo['id'] .'" class="item-image"><img class="" src="'. $baseUrl .'/Tools/Asset.ashx?id='. $AssetInfo['id'] .'&request=asset"></a>            </td><td class="name-col"><a class="title" href="'. $baseUrl .'/Catalog/ViewItem.aspx?id='. $AssetInfo['id'] .'">'. $AssetInfo['name'] .'</a><table class="details-table"><tbody><tr><td class="item-date"><span>Created</span>'. $AssetInfo['createdon'] .'</td></tr></tbody></table></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><a href="'. $baseUrl .'/Develop/Edit.aspx?id='. $AssetInfo['id'] .'" class="btn-control btn-control-large">Edit</a></td></tr></tbody></table><div class="separator"></div>';
    }
    $Contents = '<h2>Create Shirts</h2><span class="aside-text">Dont know how? <a href="https://developer.roblox.com/articles/How-to-Make-Shirts-and-Pants-for-Roblox-Characters" target="_blank">Click here</a></span><iframe id="upload-iframe" class=" my-upload-iframe" src="'. $baseUrl .'/Tools/Upload.aspx?AssetTypeId=6" frameborder="0" scrolling="no"></iframe><table class="section-header"><tbody><tr><td class="content-title"><div><h2 class="header-text">Shirts</h2></div></td></tr></tbody></table><div class="items-container">'. $ShowItems .'</div>';
    break;
  case "7":
    $MyDevelop = $MainDB->prepare("SELECT * FROM asset WHERE creatorid = :id AND itemtype = 'T-Shirt' ORDER BY id");
    $MyDevelop->execute([":id" => $id]);
    $EndSearch = $MyDevelop->fetchAll();
    switch(true){case(!$EndSearch):$ShowItems = "<span>No results found.</span>";break;}
    
    foreach($EndSearch as $AssetInfo){
      $ShowItems = $ShowItems . '<table class="item-table"><tbody><tr><td class="image-col"><a href="'. $baseUrl .'/Catalog/ViewItem.aspx?id='. $AssetInfo['id'] .'" class="item-image"><img class="" src="'. $baseUrl .'/Tools/Asset.ashx?id='. $AssetInfo['id'] .'&request=asset"></a>            </td><td class="name-col"><a class="title" href="'. $baseUrl .'/Catalog/ViewItem.aspx?id='. $AssetInfo['id'] .'">'. $AssetInfo['name'] .'</a><table class="details-table"><tbody><tr><td class="item-date"><span>Created</span>'. $AssetInfo['createdon'] .'</td></tr></tbody></table></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><a href="'. $baseUrl .'/Develop/Edit.aspx?id='. $AssetInfo['id'] .'" class="btn-control btn-control-large">Edit</a></td></tr></tbody></table><div class="separator"></div>';
    }
    $Contents = '<h2>Create T-Shirts</h2><span class="aside-text">Dont know how? <a href="https://developer.roblox.com/articles/How-to-Make-Shirts-and-Pants-for-Roblox-Characters" target="_blank">Click here</a></span><iframe id="upload-iframe" class=" my-upload-iframe" src="'. $baseUrl .'/Tools/Upload.aspx?AssetTypeId=7" frameborder="0" scrolling="no"></iframe><table class="section-header"><tbody><tr><td class="content-title"><div><h2 class="header-text">T-Shirts</h2></div></td></tr></tbody></table><div class="items-container">'. $ShowItems .'</div>';
    break;
  case "8":
    $MyDevelop = $MainDB->prepare("SELECT * FROM asset WHERE creatorid = :id AND itemtype = 'Pants' ORDER BY id");
    $MyDevelop->execute([":id" => $id]);
    $EndSearch = $MyDevelop->fetchAll();
    switch(true){case(!$EndSearch):$ShowItems = "<span>No results found.</span>";break;}
    
    foreach($EndSearch as $AssetInfo){
      $ShowItems = $ShowItems . '<table class="item-table"><tbody><tr><td class="image-col"><a href="'. $baseUrl .'/Catalog/ViewItem.aspx?id='. $AssetInfo['id'] .'" class="item-image"><img class="" src="'. $baseUrl .'/Tools/Asset.ashx?id='. $AssetInfo['id'] .'&request=asset"></a>            </td><td class="name-col"><a class="title" href="'. $baseUrl .'/Catalog/ViewItem.aspx?id='. $AssetInfo['id'] .'">'. $AssetInfo['name'] .'</a><table class="details-table"><tbody><tr><td class="item-date"><span>Created</span>'. $AssetInfo['createdon'] .'</td></tr></tbody></table></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><p></p></td><td class="edit-col"><a href="'. $baseUrl .'/Develop/Edit.aspx?id='. $AssetInfo['id'] .'" class="btn-control btn-control-large">Edit</a></td></tr></tbody></table><div class="separator"></div>';
    }
    $Contents = '<h2>Create Pants</h2><span class="aside-text">Dont know how? <a href="https://developer.roblox.com/articles/How-to-Make-Shirts-and-Pants-for-Roblox-Characters" target="_blank">Click here</a></span><iframe id="upload-iframe" class=" my-upload-iframe" src="'. $baseUrl .'/Tools/Upload.aspx?AssetTypeId=8" frameborder="0" scrolling="no"></iframe><table class="section-header"><tbody><tr><td class="content-title"><div><h2 class="header-text">Pants</h2></div></td></tr></tbody></table><div class="items-container">'. $ShowItems .'</div>';
    break;
  default:
    die(header("Location: ". $baseUrl ."/Develop/?View=1"));
    break;
}
?>
<!DOCTYPE html>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/js/IncludeJS.php'); ?>
<?php 
if ($theme !== 1) {
echo "<link rel='stylesheet' href='$baseUrl/CSS/Base/CSS/Roblox.css' />";
}
?>
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide2.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Build/BuildPage.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/UnifiedModal.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/GenericModal.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Develop/BuildPage.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Develop/Develop.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Develop/StudioWidget.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Develop/DropDownMenus.css' />
<script type="text/javascript" src="<?php echo $baseUrl; ?>/js/Build/bcjsPHP.php"></script>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
   <head>
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <title>
         MULTRBX - Develop
      </title>
   <body>
      <div></div>
      <div></div>
      <div id="Container">
         <?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/ContextHeader.php');  ?>
         <div style="padding-top:40px;"></div>
         <div style="clear: both">
      <div id="BodyWrapper">
         <div id="RepositionBody">
          <div id="Body" class="simple-body">
             <div id="DevelopTabs" class="tab-container">
              <div id="MyCreationsTabLink" class="tab-active">
               My Creations
              </div>
              <div id="LibraryTabLink" onclick="window.location='<?php echo $baseUrl; ?>/Catalog/?category=Models';">
               Creator Marketplace
              </div>
             </div>
             <div>
              <div id="MyCreationsTab" class="tab-active">
               <div class="BuildPageContent" data-groupid="">
                <input id="assetTypeId" name="assetTypeId" type="hidden" value="0">
                <table id="build-page" data-asset-type-id="0" data-edit-opens-studio="True">
                   <tbody>
                    <tr>
                     <td class="menu-area divider-right">
                      <a href="<?php echo $baseUrl; ?>/Develop/?View=1" class="tab-item <?php switch($ViewSide){case "1":echo "tab-item-selected";break;}?>">Games</a>
                      <a href="<?php echo $baseUrl; ?>/Develop/?View=2" class="tab-item <?php switch($ViewSide){case "2":echo "tab-item-selected";break;}?>">Models</a>
                      <a href="<?php echo $baseUrl; ?>/Develop/?View=3" class="tab-item <?php switch($ViewSide){case "3":echo "tab-item-selected";break;}?>">Decals</a>
                      <a href="<?php echo $baseUrl; ?>/Develop/?View=4" class="tab-item <?php switch($ViewSide){case "4":echo "tab-item-selected";break;}?>">Audio</a>
                      <a href="<?php echo $baseUrl; ?>/Develop/?View=5" class="tab-item <?php switch($ViewSide){case "5":echo "tab-item-selected";break;}?>">User Ads</a>
                      <a href="<?php echo $baseUrl; ?>/Develop/?View=6" class="tab-item <?php switch($ViewSide){case "6":echo "tab-item-selected";break;}?>">Shirts</a>
                      <a href="<?php echo $baseUrl; ?>/Develop/?View=7" class="tab-item <?php switch($ViewSide){case "7":echo "tab-item-selected";break;}?>">T-Shirts</a>
                      <a href="<?php echo $baseUrl; ?>/Develop/?View=8" class="tab-item <?php switch($ViewSide){case "8":echo "tab-item-selected";break;}?>">Pants</a>
                     </td>
                     <td class="content-area ">
                      <?php echo $Contents; ?>
                     </td>
                    </tr>
                   </tbody>
                </table>
               </div>
                <div class='Ads_WideSkyscraper'>
                  <div style='width: 160px;'>
                    <iframe allowtransparency='true' frameborder='0' width='160' height='600' scrolling='no' src='<?php echo $baseUrl; ?>/Tools/Asset.ashx?request=advertisement&adtype=rectangle&id=0' width='300' data-js-adtype='iframead'></iframe>
                  </div>
                </div>
              </div>
             </div>
             <div id="AdPreviewModal" class="simplemodal-data" style="display: none;">
              <div id="ConfirmationDialog" style="overflow: hidden">
               <div id="AdPreviewContainer" style="overflow: hidden">
               </div>
              </div>
             </div>
             <div id="clothing-upload-fun-captcha-container">
              <div id="clothing-upload-fun-captcha-backdrop"></div>
              <div id="clothing-upload-fun-captcha-modal"></div>
             </div>
             <div style="clear:both"></div>
          </div>
        </div>
      </div>            
      <?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/Footer.php'); ?>
         </div>
      </div>
   </body>
</html>