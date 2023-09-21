<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
$height = "110";
$width = "110";
$requestJS = 2;
$requestImage = "asset";
$ShowCustom = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND itemtype != 'place' AND itemtype != 'script' AND itemtype != 'animation' AND itemtype != 'advertisement' AND itemtype != 'CoreScript' ORDER BY RAND()");
$ShowCustom->execute();
$ShowRows = $ShowCustom->fetchAll();
?>
<!DOCTYPE html>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/js/IncludeJS.php'); ?>
<body style="background-color: white;">
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/Roblox.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/Item.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Catalog/PlacesAndSets.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Accounts/AccountMVC.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Catalog.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/UnifiedModal.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/GenericModal.css' />
<div class="tab-container">
	<div class="tab active tab-active" data-id="more_tab">Recommended</div>
	<div class="tab" data-id="comment_tab">Comments</div>
</div>
<div id="more_tab" class="tab-content active">
   <div class="AssetRecommenderContainer">
      <table id="ctl00_cphRoblox_AssetRec_dlAssets" cellspacing="0" align="Center" border="0" style="height:175px;width:800px;border-collapse:collapse;">
         <tbody>
            <tr>
<?php
switch(true){
	case ($ShowRows):
		switch(true){
			case ($ShowRows > 5):
				$i = 0;
				foreach($ShowRows as $ItemInfo){
					$i++;
					switch(true){case($i == 6):echo "</tr><tr>";break;}
					switch(true){
						case($i < 11):
					echo '
					   <td>
						  <div class="PortraitDiv" style="width: 140px;overflow: hidden;margin:auto;" visible="True" data-se="recommended-items-0">
							 <div class="AssetThumbnail">
								<a id="ctl00_cphRoblox_AssetRec_dlAssets_ctl00_AssetThumbnailHyperLink" class=" notranslate" title="'. $ItemInfo['name'] .'" onclick="gotoItem('. $ItemInfo['id'] .','. $requestJS .')" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="'. $baseUrl .'/Tools/Asset.ashx?id='. $ItemInfo['id'] .'&request='. $requestImage .'" height="'. $height .'" width="'. $width .'" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="'. $ItemInfo['name'] .'" class=" notranslate"></a>
							 </div>
							 <div class="AssetDetails">
								<div class="AssetName noTranslate">
								   <a id="ctl00_cphRoblox_AssetRec_dlAssets_ctl00_AssetNameHyperLinkPortrait" onclick="gotoItem('. $ItemInfo['id'] .','. $requestJS .')">'. $ItemInfo['name'] .'</a>
								</div>
								<div class="AssetCreator">
								   <span class="stat-label">Creator:</span> <span class="Detail stat"><a id="ctl00_cphRoblox_AssetRec_dlAssets_ctl00_CreatorHyperLinkPortrait" class="notranslate">'. $ItemInfo['creatorname'] .'</a></span>
								</div>
							 </div>
						  </div>
					   </td>
					';
							break;
					}
				}
				break;
			default:
				foreach($ShowRows as $ItemInfo){
					echo '
					   <td>
						  <div class="PortraitDiv" style="width: 140px;overflow: hidden;margin:auto;" visible="True" data-se="recommended-items-0">
							 <div class="AssetThumbnail">
								<a id="ctl00_cphRoblox_AssetRec_dlAssets_ctl00_AssetThumbnailHyperLink" class=" notranslate" title="'. $ItemInfo['name'] .'" onclick="gotoItem('. $ItemInfo['id'] .','. $requestJS .')" style="display:inline-block;height:'. $height .'px;width:'. $width .'px;cursor:pointer;"><img src="'. $baseUrl .'/Tools/Asset.ashx?id='. $ItemInfo['id'] .'&request='. $requestImage .'" height="'. $height .'" width="'. $width .'" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="'. $ItemInfo['name'] .'" class=" notranslate"></a>
							 </div>
							 <div class="AssetDetails">
								<div class="AssetName noTranslate">
								   <a id="ctl00_cphRoblox_AssetRec_dlAssets_ctl00_AssetNameHyperLinkPortrait" onclick="gotoItem('. $ItemInfo['id'] .','. $requestJS .')">'. $ItemInfo['name'] .'</a>
								</div>
								<div class="AssetCreator">
								   <span class="stat-label">Creator:</span> <span class="Detail stat"><a id="ctl00_cphRoblox_AssetRec_dlAssets_ctl00_CreatorHyperLinkPortrait" class="notranslate">'. $ItemInfo['creatorname'] .'</a></span>
								</div>
							 </div>
						  </div>
					   </td>
					';
				}
				break;
		}
		break;
}
?>
            </tr>
         </tbody>
      </table>
   </div>
</div>
<script type='text/javascript'>
	function gotoItem(id,type){
		if (type === 2){
			window.parent.location = "<?php echo $baseUrl; ?>/Catalog/ViewItem.aspx?id=" + id;
		}
		if (type === 1){
			window.parent.location = "<?php echo $baseUrl; ?>/Games/ViewGame.ashx?id=" + id;
		}
	}
</script>
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
</body>