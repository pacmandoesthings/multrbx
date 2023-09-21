<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php'); ?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/Catalog/CatalogAPI/SearchCatalog.php'); ?>
<?php
$category = ($_GET['category'] ?? null);
$creator = ($_GET['creator'] ?? null);
$itemname = ($_GET['itemname'] ?? null);

switch(true){
  case ($category !== null):
    switch(true){case (empty($category)):header('Location: '. $baseUrl .'/Catalog');die();break;}
    switch(true){case (preg_match('/^[a-z0-9_]+$/i', $category) == 0):header('Location: '. $baseUrl .'/Catalog');die();break;}
    
    switch($category){
      case "All":
        $CatalogFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND itemtype != 'script' AND itemtype != 'animation' AND itemtype != 'place' AND itemtype != 'advertisement' AND itemtype != 'CoreScript'");
        break;
      case "Featured":
        $CatalogFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND genre = 'Featured' AND itemtype != 'script' AND itemtype != 'animation' AND itemtype != 'place' AND itemtype != 'advertisement' AND itemtype != 'CoreScript'");
        break;
      case "Hats":
        $CatalogFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND genre = 'All' AND itemtype = 'Hat'");
        break;
      case "TShirt":
        $CatalogFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND itemtype = 'T-Shirt'");
        break;
      case "Shirt":
        $CatalogFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND itemtype = 'Shirt'");
        break;
      case "Pants":
        $CatalogFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND itemtype = 'Pants'");
        break;
      case "Gear":
        $CatalogFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND itemtype = 'Gear'");
        break;
      case "Decals":
        $CatalogFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND itemtype = 'Decal'");
        break;
      case "Models":
        $CatalogFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND itemtype = 'Model'");
        break;
      case "Audio":
        $CatalogFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND itemtype = 'Audio'");
        break;
      case "Faces":
        $CatalogFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND itemtype = 'Face'");
        break;
      default:
        header('Location: '. $baseUrl .'/Catalog');die();
        break;
    }    
    break;
  case ($creator !== null):
    switch(true){case (empty($creator)):header('Location: '. $baseUrl .'/Catalog');die();break;}
    switch(true){case (preg_match('/^[a-z0-9_]+$/i', $creator) == 0):header('Location: '. $baseUrl .'/Catalog');die();break;}
    $CatalogFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND creatorname = '". $creator ."' AND itemtype != 'place' AND itemtype != 'advertisement'");
    break;
  case ($itemname):
    switch(true){case (empty($itemname)):header('Location: '. $baseUrl .'/Catalog');die();break;}
    switch(true){case (preg_match('/^[a-z0-9_]+$/i', $itemname) == 0):header('Location: '. $baseUrl .'/Catalog');die();break;}
    $CatalogFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND name LIKE '%". $itemname ."%' AND itemtype != 'place' AND itemtype != 'advertisement'");
    break;
  default:
    $CatalogFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND itemtype != 'script' AND itemtype != 'animation' AND itemtype != 'place' AND itemtype != 'advertisement' AND itemtype != 'CoreScript'");
    break;
}
$CatalogFetch->execute();
$FetchItems = $CatalogFetch->fetchAll();
?>
<!DOCTYPE html>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/js/IncludeJS.php'); ?>
<?php 
if ($theme !== 1) {
echo "<link rel='stylesheet' href='$baseUrl/CSS/Base/CSS/Roblox.css' />";
}
?>
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Catalog/PlacesAndSets.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Accounts/AccountMVC.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Catalog.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/UnifiedModal.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/GenericModal.css' />
<script type="text/javascript" src="<?php echo $baseUrl; ?>/js/Modules/Widgets/HierarchicalDropdown.js"></script>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
   <head>
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <title>
         MULTRBX - Catalog
      </title>
   <body>
      <div></div>
      <div></div>
      <div id="Container" style="background-color: white;">
         <?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/ContextHeader.php');  ?>
         <div style="padding-top:40px;"></div>
         <div style="clear: both">
      <div id="BodyWrapper">
         <div id="RepositionBody">
          <div id="Body" class="" style="width:970px">
      <div id="AdvertisingLeaderboard">
         <div style="left:17px;position:relative;">
          <iframe allowtransparency="true" frameborder="0" height="90" scrolling="no" src="<?php echo $baseUrl; ?>/Tools/Asset.ashx?request=advertisement&adtype=top&id=0" width="745"></iframe>            
         </div>
      </div>
           <style type="text/css">
            #Body 
            {
            padding: 10px;
            }
            .CatalogItemInfoLabel, .HoverInfo
            {
            font-size: 10.5px!important;
            }
            .CatalogItemName
            {
            overflow: initial!important;
            }
           </style>
           <div id="catalog" data-empty-search-enabled="true" style="font-size: 12px;">
            <div class="header" style="height:60px;">
               <div style="float:left;">
                <h1><a href="<?php echo $baseUrl; ?>/Catalog/" id="CatalogLink">Catalog</a></h1>
               </div>
               <form method="POST" action="<?php echo $CurrPage; ?>">
              <div class="CatalogSearchBar">
              <input id="keywordTextbox" name="keywordTextbox" placeholder="Search gears, hats, clothing, and so much more!" style="height: 25px;" type="text" class="translate text-box text-box-small">

              <button id="submitSearchButton" name="submitSearchButton" href="#" class="btn-control btn-control-large top-level">Search</button>
              </div>
               </form>
            </div>
            <div class="left-nav-menu divider-right">
               <div>
                <h2>Filters</h2>
               </div>
               <div style="margin-left:5px">
                <div class="filter-title">Category</div>
                <ul>
                 <li><a href="<?php echo $baseUrl; ?>/Catalog/?category=All" class="assetTypeFilter" data-keepfilters="true" data-category="1">All Categories</a></li>
                 <li><a href="<?php echo $baseUrl; ?>/Catalog/?category=Featured" class="assetTypeFilter" data-keepfilters="true" data-category="0">Featured</a></li>
                 <li><a href="<?php echo $baseUrl; ?>/Catalog/?category=Hats" class="assetTypeFilter" data-keepfilters="true" data-category="2">Hats</a></li>
                 <li><a href="<?php echo $baseUrl; ?>/Catalog/?category=TShirt" class="assetTypeFilter" data-keepfilters="true" data-category="3">T-Shirts</a></li>
                 <li><a href="<?php echo $baseUrl; ?>/Catalog/?category=Shirt" class="assetTypeFilter" data-keepfilters="true" data-category="3">Shirts</a></li>
                 <li><a href="<?php echo $baseUrl; ?>/Catalog/?category=Pants" class="assetTypeFilter" data-keepfilters="true" data-category="3">Pants</a></li>
                 <li><a href="<?php echo $baseUrl; ?>/Catalog/?category=Gear" class="assetTypeFilter" data-keepfilters="true" data-category="5">Gear</a></li>
                 <li><a href="<?php echo $baseUrl; ?>/Catalog/?category=Faces" class="assetTypeFilter" data-keepfilters="true" data-category="7">Faces</a></li>
                 <li><a href="<?php echo $baseUrl; ?>/Catalog/?category=Decals" class="assetTypeFilter" data-keepfilters="true" data-category="8">Decals</a></li>
                 <li><a href="<?php echo $baseUrl; ?>/Catalog/?category=Models" class="assetTypeFilter" data-keepfilters="true" data-category="6">Models</a></li>
                 <li><a href="<?php echo $baseUrl; ?>/Catalog/?category=Audio" class="assetTypeFilter" data-keepfilters="true" data-category="9">Audio</a></li>
                </ul>
                <div class="filter-title">Creators</div>
                <ul>
                 <li><a href="<?php echo $baseUrl; ?>/Catalog/?creator=All" class="creatorFilter" data-creatorid="0">All Creators</a></li>
                 <li><a href="<?php echo $baseUrl; ?>/Catalog/?creator=ROBLOX" class="creatorFilter" data-creatorid="1">ROBLOX</a></li>
                 <form method="POST" action="<?php echo $CurrPage; ?>"><li><input id="creatorTextbox" name="creatorTextbox" type="text" placeholder="Name" class="Watermark translate text-box text-box-small"> <button name="submitCreatorButton" id="submitCreatorButton" class="btn-control btn-control-small">Go</button></li></form>
                </ul>
               </div>
               <div id="legend" class="divider-top">
                <div class="header expanded" id="legendheader">
                 <h3>Legend</h3>
                </div>
                <div id="legendcontent" style="overflow: hidden; ">
                 <img src="<?php echo $baseUrl; ?>/Images/UI/bconly.png" style="margin-left: -13px">
                 <div class="legendText"><b>Builders Club Only</b><br>
                  Only purchasable by Builders Club members.
                 </div>
                 <img src="<?php echo $baseUrl; ?>/Images/UI/limited.png" style="margin-left: -13px">
                 <div class="legendText"><b>Limited Items</b><br>
                  Owners of these discontinued items can re-sell them to other users at any price.
                 </div>
                 <img src="<?php echo $baseUrl; ?>/Images/UI/limitedunique.png" style="margin-left: -13px">
                 <div class="legendText"><b>Limited Unique Items</b><br>
                  A limited supply originally sold by ROBLOX. Each unit is labeled with a serial number. Once sold out, owners can re-sell them to other users.
                 </div>
                </div>
               </div>
            </div>
            <div class="right-content divider-left" id="catalogContainer">
               <a href="#breadcrumbs=category" class="bolded" style="text-decoration: none; color: black;" data-filter="category"><?php switch(true){case($category !== null):echo $category;break;default:echo "Results"; break;} ?></a>
               <div id="secondRow">
                <div style="float:left;padding-top:5px">
                 <span>Showing <span class="notranslate">1</span> - <span class="notranslate">20</span> of <span class="notranslate">20</span> results</span>
                </div>
                <div style="clear:both"></div>
               </div>
               <?php
               switch(true){
                 case($FetchItems):
                  foreach($FetchItems as $ItemInfo){
                  $RSTX = array();
                  switch($ItemInfo['free']){
                      case "1":
                        $prices = '<span class="NotAPrice notranslate">Free</span>';
                        break;
                      default:
                        switch(true){case ($ItemInfo['rsprice'] !== null):array_push($RSTX, "robux");break;}
                        switch(true){case ($ItemInfo['tkprice'] !== null):array_push($RSTX, "tix");break;}
                        switch (true){
                          case(count($RSTX) == 2):
                            $prices = '<div class="robux-price"><span class="robux notranslate">'. $ItemInfo['rsprice'] .'</span></div><div class="tickets-price"><span class="tickets notranslate">'. $ItemInfo['tkprice'] .'</span></div>';
                            break;
                          case(count($RSTX) == 1):
                              switch(true){
                                case(in_array("robux", $RSTX)):
                                  $prices = '<div class="robux-price"><span class="robux notranslate">'. $ItemInfo['rsprice'] .'</span></div>';
                                  break;
                                case(in_array("tix", $RSTX)):
                                  $prices = '<div class="tickets-price"><span class="tickets notranslate">'. $ItemInfo['tkprice'] .'</span></div>';
                                  break;
                              }
                            break;
                        }
                        break;
                    }
                    echo '
                      <div class="CatalogItemOuter SmallOuter">
                         <div class="SmallCatalogItemView SmallView">
                          <div class="CatalogItemInner SmallInner">
                           <div class="roblox-item-image image-small" data-item-id="144" data-image-size="small" data-is-static="">
                            <div style="position: relative; overflow: hidden;"><a href="'. $baseUrl .'/Catalog/ViewItem.aspx?id='. $ItemInfo['id'] .'"><img title="'. $ItemInfo['name'] .'" alt="'. $ItemInfo['name'] .'" border="0" height="110" width="110" class="original-image modal-thumb" src="'. $baseUrl .'/Tools/Asset.ashx?id='. $ItemInfo["id"] .'&request=asset""></a></div>
                           </div>
                           <div id="textDisplay">
                            <div class="CatalogItemName notranslate">
                               <a class="name notranslate" href="'. $baseUrl .'/Catalog/ViewItem.aspx?id='. $ItemInfo['id'] .'" title="'. $ItemInfo['name'] .'">'. $ItemInfo['name'] .'</a>
                            </div>
                            '. $prices .'
                           </div>
                           <div class="CatalogHoverContent">
                            <div>
                               <span class="CatalogItemInfoLabel">Creator:</span>
                               <span class="HoverInfo notranslate"><a href="/User.aspx?id='. $ItemInfo['creatorid'] .'">'. $ItemInfo['creatorname'] .'</a></span>
                            </div>
                            <div><span class="CatalogItemInfoLabel">Updated:</span> <span class="HoverInfo">'. $ItemInfo['updatedon'] .'</span></div>
                            <div><span class="CatalogItemInfoLabel">Favorited:</span> <span class="HoverInfo">'. $ItemInfo['favorited'] .' times</span></div>
                           </div>
                          </div>
                         </div>
                      </div>
                    ';
                  }
                  break;
                default:
                  echo '<span>No items.</span>';
                  break;
               }
               ?>
            </div>
            <div style="clear:both;padding-top:20px"></div>
           </div>
           <div style="clear:both"></div>
          </div>
         </div>
      </div>
         </div>
      </div>
    <?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/Footer.php'); ?>
   </body>
   					  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
  <style>
    .big {
      font-size: 60px;
    }

    .card-main {
      margin: 100px;
    }

    .card-blurb {
      display: flex;
      margin-left: 100px;
      margin-top: 400px;
    }

    .card-feed {
      margin-left: 450px;
      margin-top: -687px;
    }

    .feed-message-avatar {
      width: 80px;
    }
  </style>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
</html>