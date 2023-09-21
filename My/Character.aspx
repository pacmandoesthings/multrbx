<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php'); ?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/My/SettingsAPI/AccountUpdate.php'); ?>
<?php
switch(true){
	case ($RBXTICKET == null):
		header("Location: ". $baseUrl ."/");
		die();
		break;
}
$filter = ($_GET['filter'] ?? null);
switch($filter){
	case "Hats":
		$WardrobeSrh = $MainDB->prepare("SELECT * FROM bought WHERE boughtby = :id AND wearing IS NULL AND itemtype = 'Hat' ORDER BY id DESC LIMIT 12");
		break;
	case "Faces":
		$WardrobeSrh = $MainDB->prepare("SELECT * FROM bought WHERE boughtby = :id AND wearing IS NULL AND itemtype = 'Face' ORDER BY id DESC LIMIT 12");
		break;
	case "Shirt":
		$WardrobeSrh = $MainDB->prepare("SELECT * FROM bought WHERE boughtby = :id AND wearing IS NULL AND itemtype = 'Shirt' ORDER BY id DESC LIMIT 12");
		break;
	case "TeeShirt":
		$WardrobeSrh = $MainDB->prepare("SELECT * FROM bought WHERE boughtby = :id AND wearing IS NULL AND itemtype = 'T-Shirt' ORDER BY id DESC LIMIT 12");
		break;
	case "Pants":
		$WardrobeSrh = $MainDB->prepare("SELECT * FROM bought WHERE boughtby = :id AND wearing IS NULL AND itemtype = 'Pants' ORDER BY id DESC LIMIT 12");
		break;
	case "Gear":
		$WardrobeSrh = $MainDB->prepare("SELECT * FROM bought WHERE boughtby = :id AND wearing IS NULL AND itemtype = 'Gear' ORDER BY id DESC LIMIT 12");
		break;
	case "Package":
		$WardrobeSrh = $MainDB->prepare("SELECT * FROM bought WHERE boughtby = :id AND wearing IS NULL AND itemtype = 'Package' ORDER BY id DESC LIMIT 12");
		break;	
	default:
		$WardrobeSrh = $MainDB->prepare("SELECT * FROM bought WHERE boughtby = :id AND wearing IS NULL AND itemtype = 'Hat' AND itemtype != 'model' AND itemtype != 'advertisement' AND itemtype != 'decal' AND itemtype != 'audio' ORDER BY id DESC LIMIT 12");
		break;
}
$WardrobeSrh->execute([":id" => $id]);
$ReWDS = $WardrobeSrh->fetchAll();

$WearingSrh = $MainDB->prepare("SELECT * FROM bought WHERE boughtby = :id AND wearing = '1' ORDER BY id DESC LIMIT 12");
$WearingSrh->execute([":id" => $id]);
$ReWRS = $WearingSrh->fetchAll();
?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/js/IncludeJS.php'); ?>
<!DOCTYPE html>
<?php 
if ($theme !== 1) {
echo "<link rel='stylesheet' href='$baseUrl/CSS/Base/CSS/Roblox.css' />";
}
?>
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Accounts/AccountMVC.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/UnifiedModal.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/GenericModal.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Home/Home.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Home/RobloxFeed.css' />
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
   <head>
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <title>
         MULTRBX - Wardrobe
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
					 <div id="HomeContainer" class="home-container">
						<div>
						   <h1>Avatar Customizer</h1>
						</div>
						<div class="left-column">
						   <div class="left-column-boxes user-avatar-container">
							  <div id="UserAvatar" class="thumbnail-holder" style="width:210px; height:210px;">
								 <div class="roblox-avatar-image image-medium" data-image-size="custom" data-image-size-x="210" data-image-size-y="210" data-no-click="true" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="MisteriousKapote">
									<div style="position: relative;"><img border="0" height="210" width="210" src="<?php echo $baseUrl; ?>/Tools/Asset.ashx?id=<?php echo $id; ?>&request=avatar"></div>
								 </div>
							  </div>
							  <div id="UserInfo" class="text">
								 <br clear="all">
								 <br class="rbx2hide">
								 <div></div>
							  </div>
						   </div>
						  
						   <div class="left-column-boxes">
							  <div align="center">
								 <a href="Colours.aspx" class="btn-small btn-neutral">Change Body Colors</a>
								 <div class="edit-friends-button">
								 </div>
								 <div class="clear"></div>
								 <div id="ctl00_ctl00_cphRoblox_cphMyRobloxContent_SetPlayerAvatarType">
    <div class="AvatarPickerRadioButtons">
        <h2>Avatar Type</h2>
        <div style="cursor: auto; display: inline-block; margin-left: 3px; position: relative; top: -2px; opacity: 1;" class="TipsyImg tooltip-right" original-title="Choose between the classic avatar movement or R15 - which has elbows and knees!">
            <img height="13" width="12" style="cursor: auto;" src="https://images.rbxcdn.com/65cb6e4009a00247ca02800047aafb87.png" alt="Choose between the classic avatar movement or R15 - which has elbows and knees!">
        </div>
        <div class="SetPlayerAvatarTypeRadioButtons">
            <span class="playerAvatarType">
                <input id="ctl00_ctl00_cphRoblox_cphMyRobloxContent_PlayerAvatarTypeR6" type="radio" name="ctl00$ctl00$cphRoblox$cphMyRobloxContent$SetPlayerAvatarType" value="PlayerAvatarTypeR6" onclick="javascript:setTimeout('__doPostBack(\'ctl00$ctl00$cphRoblox$cphMyRobloxContent$PlayerAvatarTypeR6\',\'\')', 0)">
                <label for="ctl00_ctl00_cphRoblox_cphMyRobloxContent_PlayerAvatarTypeR6">R6</label>
            </span>
            <span class="playerAvatarType">
                <input id="ctl00_ctl00_cphRoblox_cphMyRobloxContent_PlayerAvatarTypeR15" type="radio" name="ctl00$ctl00$cphRoblox$cphMyRobloxContent$SetPlayerAvatarType" value="PlayerAvatarTypeR15" onclick="javascript:setTimeout('__doPostBack(\'ctl00$ctl00$cphRoblox$cphMyRobloxContent$PlayerAvatarTypeR15\',\'\')', 0)">
                <label for="ctl00_ctl00_cphRoblox_cphMyRobloxContent_PlayerAvatarTypeR15">R15</label>
            </span>
        </div>
    </div>
</div>

								 
							  </div>
							  <div id="bestFriendsContainer" class="best-friends-container">
								 <div class="best-friends"></div>
							  </div>
							  <div style="clear:both;"></div>
						   </div>
						</div>
						<div class="middle-column">
						   <div class="tab-container">
							  <div class="tab active tab-active" data-id="items_tab">Wardrobe</div>
							  <div class="tab" data-id="outfit_tab">Outfits</div>
						   </div>
						   <div id="items_tab" class="tab-content active">
							<div class="AttireCategory" style="text-align: center">
							   <p>
							   <a id="ctl00_ctl00_cphRoblox_cphMyRobloxContent_AttireCategoryRepeater_ctl00_AttireCategorySelector" class="AttireCategorySelector" href="<?php echo $baseUrl;?>/My/Character.aspx?filter=Hats">Hats</a> - 
							   <a id="ctl00_ctl00_cphRoblox_cphMyRobloxContent_AttireCategoryRepeater_ctl01_AttireCategorySelector" class="AttireCategorySelector" href="<?php echo $baseUrl;?>/My/Character.aspx?filter=Faces">Faces</a> - 
							   <a id="ctl00_ctl00_cphRoblox_cphMyRobloxContent_AttireCategoryRepeater_ctl03_AttireCategorySelector" class="AttireCategorySelector" href="<?php echo $baseUrl;?>/My/Character.aspx?filter=TeeShirt">T-Shirt</a> - 
							   <a id="ctl00_ctl00_cphRoblox_cphMyRobloxContent_AttireCategoryRepeater_ctl03_AttireCategorySelector" class="AttireCategorySelector" href="<?php echo $baseUrl;?>/My/Character.aspx?filter=Shirt">Shirt</a> - 
							   <a id="ctl00_ctl00_cphRoblox_cphMyRobloxContent_AttireCategoryRepeater_ctl03_AttireCategorySelector" class="AttireCategorySelector" href="<?php echo $baseUrl;?>/My/Character.aspx?filter=Pants">Pants</a> - 
							   <a id="ctl00_ctl00_cphRoblox_cphMyRobloxContent_AttireCategoryRepeater_ctl06_AttireCategorySelector" class="AttireCategorySelector" href="<?php echo $baseUrl;?>/My/Character.aspx?filter=Gear">Gear</a> -
							   <a id="ctl00_ctl00_cphRoblox_cphMyRobloxContent_AttireCategoryRepeater_ctl06_AttireCategorySelector" class="AttireCategorySelector" href="<?php echo $baseUrl;?>/My/Character.aspx?filter=Package">Packages</a>
							   </p>
							   <br>
							</div>
							  <div class="AssetRecommenderContainer">
    <table id="ctl00_cphRoblox_AssetRec_dlAssets" cellspacing="0" align="center" border="0" style="width: 800px; border-collapse: collapse;">
											 <tbody>
												<tr>
<?php
switch(true){
	case($ReWDS):
			$i = 0;
			foreach($ReWDS as $AssetInfo){
				$i++;
				switch(true){case($i == 6):echo "</br><tr>";break;}
				$AssetId = $AssetInfo["boughtid"];
				$AssetName = $AssetInfo["boughtname"];
				echo '<td>
<div align="center" class="PortraitDiv" style="width: 140px;overflow: hidden;margin:auto;" visible="True" data-se="recommended-items-0">
<div class="AssetThumbnail">
<a style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="'. $baseUrl .'/Tools/Asset.ashx?id='. $AssetId .'&request=asset" height="110" width="110" border="0"></a>
</div>
<div class="AssetDetails">
<div class="AssetName noTranslate">
<a href="'. $baseUrl .'/Catalog/ViewItem.aspx?id='. $AssetId .'" id="ctl00_cphRoblox_AssetRec_dlAssets_ctl00_AssetNameHyperLinkPortrait" style="font-size:14px;"><b>'. $AssetName .'</b></a>
</div>
<a href="'. $baseUrl .'/Tools/WearItemJob.aspx?id='. $AssetId .'&RequestType=WearItem" style="margin:3px;" title="click to wear" class="btn-small btn-neutral">    
Wear
</a>
</div>
</div>
</td>';
			}
		break;
	default:
		echo '<p align="center">No items were found.</p>';
		break;
}
?>
												</tr>
											 </tbody>
										  </table>
							  </div>
						   </div>
						   <div id="outfit_tab" style="display: none;" class="tab-content">
							  <div class="AssetRecommenderContainer">
								<h2>Unable to fetch.</h2>
							  </div>
						   </div>
						   <div class="tab-content active" id="settings_tab" style="display: block;">
						   </div>
						   <div id="FeedContainer" class="middle-column-box feed-container">
						   <h2>Currently Wearing</h2>
							  <div id="FeedPanel">
								 <div id="AjaxFeed" class="text">
									<div class="feed-container">
									   <div class="AssetRecommenderContainer">
										  <table id="ctl00_cphRoblox_AssetRec_dlAssets" cellspacing="0" align="Center" border="0">
											 <tbody>
												<tr>
<?php
switch(true){
	case($ReWRS):
			$d = 0;
			foreach($ReWRS as $AssetInfo){
				$d++;
				switch(true){case($d == 6):echo "</tr><tr>";break;}
				$AssetId = $AssetInfo["boughtid"];
				$AssetName = $AssetInfo["boughtname"];
				echo '<td>
<div align="center" class="PortraitDiv" style="width: 140px;overflow: hidden;margin:auto;" visible="True" data-se="recommended-items-0">
<div class="AssetThumbnail">
<a style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="'. $baseUrl .'/Tools/Asset.ashx?id='. $AssetId .'&request=asset" height="110" width="110" border="0"></a>
</div>
<div class="AssetDetails">
<div class="AssetName noTranslate">
<a href="'. $baseUrl .'/Catalog/ViewItem.aspx?id='. $AssetId .'" id="ctl00_cphRoblox_AssetRec_dlAssets_ctl00_AssetNameHyperLinkPortrait" style="font-size:14px;"><b>'. $AssetName .'</b></a>
</div>
<a href="'. $baseUrl .'/Tools/WearItemJob.aspx?id='. $AssetId .'&RequestType=UnWearItem" style="margin:3px;" title="click to remove" class="btn-small btn-neutral">    
Remove
</a>
</div>
</div>
</td>';
			}
		break;
	default:
		echo "<p align='center'>You aren't wearing any items.</p>";
		break;
}
?>
												</tr>
											 </tbody>
										  </table>
									   </div>
									</div>
								 </div>
							  </div>
						   </div>
						</div>
						<div class="right-column">
						   <div class="right-column-box" id="Skyscraper-Ad">
							  <div style="width: 160px">
								 <span id="3439303639313930" class="GPTAd skyscraper" data-js-adtype="gptAd">
								 <iframe allowtransparency="true" frameborder="0" width="160" height="600" scrolling="no" src="<?php echo $baseUrl; ?>/Tools/Asset.ashx?request=advertisement&adtype=rectangle&id=0"></iframe>            
								 </span>
							  </div>
						   </div>
						   <div class="clear"></div>
						   <div id="UserScreenContainer"></div>
						</div>
						<div style="clear:both"></div>
					 </div>
				  </div>
			   </div>
			</div>
		</div>
		</div>
		<?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/Footer.php'); ?>
   </body>
</html>