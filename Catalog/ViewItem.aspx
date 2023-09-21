<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php'); 
$ItemId = (int)($_GET['id'] ?? die(header('Location: '. $baseUrl .'/RobloxDefaultErrorPage.aspx')));

$AssetFetch = $MainDB->prepare("SELECT * FROM asset WHERE id = :pid AND itemtype != 'place'");
$AssetFetch->execute([":pid" => $ItemId]);
$Results = $AssetFetch->fetch(PDO::FETCH_ASSOC);

switch(true){case(!$Results):die(header('Location: '. $baseUrl .'/RobloxDefaultErrorPage.aspx'));break;}

$AssetTitle = $Results['name'];
$AssetInfo = $Results['moreinfo'];
$AssetPublic = $Results['public'];
$AssetFavorite = $Results['favorited'];
$AssetGenre = $Results['itemtype'];
$AssetDate = $Results['createdon'];
$AssetUpdate = $Results['updatedon'];
$AssetApproval = $Results['approved'];
$AssetRS = $Results['rsprice'];
$AssetTicket = $Results['tkprice'];
$AssetFree = $Results['free'];
$CreatorName = $Results['creatorname'];
$CreatorId = $Results['creatorid'];

switch(true){case($RBXTICKET):$IsLoggedIn = "Yes";switch(true){case ($CreatorId == $id):$IsCreator = "Yes";break;default:$IsCreator = "No";break;}break;default:$IsLoggedIn = "No";$IsCreator = "No";break;}

switch(true){
	case ($AssetRS !== null):
		$Price = "<div class='BuyPriceBoxContainer'><div class='BuyPriceBox'><div id='ctl00_cphRoblox_RobuxPurchasePanel'><div id='RobuxPurchase'><div class='calloutParent'>Price: <span class='robux ' data-se='item-priceinrobux'>". $AssetRS ."</span></div><div id='BuyWithRobux'><div onclick='RobuxPurchase()' data-expected-currency='1' data-asset-type='Hat' class='btn-primary btn-medium PurchaseButton '>Buy with R$<span class='btn-text'>Buy with R$</span></div></div></div></div></div>
<div class='BuyPriceBoxContainer'><div class='BuyPriceBox'><div id='ctl00_cphRoblox_RobuxPurchasePanel'><div id='RobuxPurchase'><div class='calloutParent'>Price: <span class='tickets' data-se='item-priceinrobux'>". $AssetTicket ."</span></div><div id='BuyWithTickets'><div onclick='TicketsPurchase()' data-expected-currency='1' data-asset-type='Hat' class='btn-primary btn-medium PurchaseButton '>Buy with Tix<span class='btn-text'>Buy with Tix</span></div></div></div></div></div>";
		break;
	
		
		
	case ($AssetTicket !== null && $AssetRS !== null):
		$Price = "<div class='BuyPriceBoxContainer'><div class='BuyPriceBox'><div id='ctl00_cphRoblox_RobuxPurchasePanel'><div id='RobuxPurchase'><div class='calloutParent'>Price: <span class='robux ' data-se='item-priceinrobux'>". $AssetRS ."</span></div><div id='BuyWithRobux'><div onclick='RobuxPurchase()' data-expected-currency='1' data-asset-type='Hat' class='btn-primary btn-medium PurchaseButton '>Buy with R$<span class='btn-text'>Buy with R$</span></div></div><span>or</span><div class='calloutParent'>Price: <span class='tickets' data-se='item-priceinrobux'>". $AssetTicket ."</span></div><div id='BuyWithTickets'><div onclick='TicketsPurchase()' data-expected-currency='1' data-asset-type='Hat' class='btn-primary btn-medium PurchaseButton '>Buy with Tix<span class='btn-text'>Buy with Tix</span></div></div></div></div></div>";
		break;
	case ($AssetFree !== null):
		$Price = "<div class='BuyPriceBoxContainer'><div class='BuyPriceBox'><div id='ctl00_cphRoblox_RobuxPurchasePanel'><div id='RobuxPurchase'><div class='calloutParent'>Price: <span style='color: #060;'><b>Free</b></span></div><div id='BuyWithRobux'><div onclick='FreePurchase()' data-expected-currency='1' data-asset-type='Hat' class='btn-primary btn-medium PurchaseButton '>Take One<span class='btn-text'>Take One</span></div></div></div></div></div>";
		break;
}

switch($IsLoggedIn){
	case "Yes":
		$PurchaseCheck = $MainDB->prepare("SELECT * FROM bought WHERE boughtby = :id AND boughtid = :bid");
		$PurchaseCheck->execute([":id" => $id, ":bid" => $ItemId]);
		$CheckShow = $PurchaseCheck->fetch(PDO::FETCH_ASSOC);
		
		switch(true){
			case($CheckShow):
				$Options = '<div id="ctl00_cphRoblox_GearDropDown" class="SetList ItemOptions"><a href="#" class="btn-dropdown"><img src="'. $baseUrl .'/Images/gearsetting.png"></a><div class="clear"></div><div class="SetListDropDown"><div class="SetListDropDownList invisible"><div class="menu invisible"><div id="ctl00_cphRoblox_ItemOwnershipPanel" class=""><a>Delete from My Stuff</a></div></div></div></div></div>';
				$Price = '<div class="BuyPriceBoxContainer"><div class="BuyPriceBox"><div id="ctl00_cphRoblox_RobuxPurchasePanel"><div id="RobuxPurchase"><div class="calloutParent">You already own this item.</div><div id="BuyWithRobux"><div onclick="Customize()" data-expected-currency="1" data-asset-type="Hat" class="btn-primary btn-medium PurchaseButton">Customize<span class="btn-text">Customize</span></div></div></div></div></div>';
				break;
			default:
				$Options = null;
				break;
		}
		break;
	default:
		$Options = null;
		break;
}

switch(true){
	case ($IsCreator == "Yes"):
		$Options = '<div id="ctl00_cphRoblox_GearDropDown" class="SetList ItemOptions"><a href="#" class="btn-dropdown"><img src="'. $baseUrl .'/Images/gearsetting.png"></a><div class="clear"></div><div class="SetListDropDown"><div class="SetListDropDownList invisible"><div class="menu invisible"><div id="ctl00_cphRoblox_ItemOwnershipPanel" class=""><a>Delete from My Stuff</a><a id="ctl00_cphRoblox_btnConfigure" href="'. $baseUrl .'/Develop/Edit.aspx?id='. $ItemId .'">Configure</a></div></div></div></div></div>';
		switch($AssetApproval){
			case "2":
				$Notice = '<div id="AccountPageContainer" data-missingparentemail="false" data-userabove13="true" data-currentdateyear="" data-currentdatemonth="" data-currentdateday=""><div id="ctl00_Announcement"><div id="ctl00_SystemAlertDiv" class="SystemAlert"><div id="ctl00_SystemAlertTextColor" class="SystemAlertText"><div id="ctl00_LabelAnnouncement">Your item has not been approved.</div></div></div></div></div>';
				break;
			case null:
				$Notice = '<div id="AccountPageContainer" data-missingparentemail="false" data-userabove13="true" data-currentdateyear="" data-currentdatemonth="" data-currentdateday=""><div id="ctl00_Announcement"><div id="ctl00_SystemAlertDiv" class="SystemAlert"><div id="ctl00_SystemAlertTextColor" class="SystemAlertText"><div id="ctl00_LabelAnnouncement">Your item is under approval, it will not be listed on the Catalog until it gets approved.</div></div></div></div></div>';
				break;
			default:
				$Notice = null;
				break;
		}
		break;
	default:
		$Notice = null;
		switch(true){case($AssetApproval !== "1"):die(header('Location: '. $baseUrl .'/IDE/Error.ashx?err=404'));break;}
		switch(true){case($AssetPublic !== "1"):die(header('Location: '. $baseUrl .'/IDE/Error.ashx?err=404'));break;}
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
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Catalog/PlacesAndSets.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Accounts/AccountMVC.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide3.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Catalog.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/UnifiedModal.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/GenericModal.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/Item.css' />
<script type="text/javascript" src="<?php echo $baseUrl; ?>/js/Item.js"></script>
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
			<div id="AdvertisingLeaderboard">
			   <div style="left:17px;position:relative;">
				  <iframe allowtransparency="true" frameborder="0" height="90" scrolling="no" src="<?php echo $baseUrl; ?>/Tools/Asset.ashx?request=advertisement&adtype=top&id=0" width="745"></iframe>            
			   </div>
			</div>
         <div style="clear: both">
<?php
							echo "
<div id='BodyWrapper'>
   <div id='RepositionBody'>
      <div id='Body' style='width:970px;'>
         <div id='ItemContainer' class='text'>
            <div>
				". $Options ."
               <h1 class='notranslate' data-se='item-name'>
                  ". htmlspecialchars($AssetTitle) ."
               </h1>
               <h3>
                  MULTRBX Item
               </h3>
            </div>
            <div id='Item'>
               <div id='Details'>
                  <div id='assetContainer'>
                     <div id='Thumbnail'>
                        <div id='AssetThumbnail' class='thumbnail-holder' data-3d-thumbs-enabled='' data-url='". $baseUrl ."/Tools/Asset.ashx?id=". $ItemId ."&request=asset' style='width:320px; height:320px;'>
                           <span class='thumbnail-span' data-3d-url='#' data-js-files='#'><img class='' width='320' height='320' src='". $baseUrl ."/Tools/Asset.ashx?id=". $ItemId ."&request=asset'></span>
                        </div>
                     </div>
                  </div>
                  <div id='Summary'>
                     <div class='SummaryDetails'>
                        <div id='Creator' class='Creator'>
                           <div class='Avatar'>
                              <a id='ctl00_cphRoblox_AvatarImage' class=' notranslate' title='". $CreatorName ."' href='". $baseUrl ."/User.php?id=". $CreatorId ."' style='display:inline-block;height:70px;width:70px;cursor:pointer;'><img src='". $baseUrl ."/Tools/Asset.ashx?id=". $CreatorId ."&request=avatar' height='70' width='70' border='0' onerror='return Roblox.Controls.Image.OnError(this)' alt='". $CreatorName ."' class=' notranslate'></a>
                           </div>
                        </div>
                        <div class='item-detail'>
                           <span class='stat-label notranslate'>Creator:</span>
                           <a id='ctl00_cphRoblox_CreatorHyperLink' class='stat notranslate' href='". $baseUrl ."/User.php?ID=". $CreatorId ."'>". $CreatorName ."</a>
                           <div>
                              <span class='stat-label'>Created:</span>
                              <span class='stat'>
                              ". $AssetDate ."
                              </span>
                           </div>
                           <div id='LastUpdate'>
                              <span class='stat-label'>Updated:</span>
                              <span class='stat'>
                              ". $AssetUpdate ."
                              </span>
                           </div>
                        </div>
						<div id='ctl00_cphRoblox_DescriptionPanel' class='DescriptionPanel notranslate'>
						<pre class='Description Full text'>". htmlspecialchars($AssetInfo) ."</pre>
						<pre class='Description body text'>". htmlspecialchars($AssetInfo) ."</pre>
                        </div>
                        <div class='ReportAbuse'>
                           <div id='ctl00_cphRoblox_AbuseReportButton1_AbuseReportPanel' class='ReportAbuse'>
                              <span class='AbuseIcon'><a id='ctl00_cphRoblox_AbuseReportButton1_ReportAbuseIconHyperLink' href='". $baseUrl ."/Tools/ReportAbuse.ashx?id=". $ItemId ."&back=". $CurrPage ."'><img src='/web/20141014202817im_/http://www.roblox.com/images/abuse.PNG?v=2' alt='Report Abuse' style='border-width:0px;'></a></span>
                              <span class='AbuseButton'><a id='ctl00_cphRoblox_AbuseReportButton1_ReportAbuseTextHyperLink' href='". $baseUrl ."/Tools/ReportAbuse.ashx?id=". $ItemId ."&back=". $CurrPage ."'>Report Abuse</a></span>
                           </div>
                        </div>
                        <div class='GearGenreContainer divider-top'>
                           <div id='GenresDiv'>
                              <div id='ctl00_cphRoblox_Genres'>
                                 <div class='stat-label'>
                                    Genres:
                                 </div>
                                 <div class='GenreInfo stat'>
                                    <div>
                                       <div id='ctl00_cphRoblox_GenresDisplayTest_AssetGenreRepeater_ctl00_AssetGenreRepeaterPanel' class='AssetGenreRepeater_Container'>
                                          <div class='GamesInfoIcon All'></div>
                                          <div><a href='". $baseUrl ."/'>". $AssetGenre ."</a></div>
                                       </div>
                                       <div style='clear:both;'></div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                           <div class='clear'></div>
                        </div>
                        <div class='PluginMessageContainer' style='display: none;'>
                           <p>
                              <span class='status-confirm'>A newer version is available.</span>
                           </p>
                        </div>
                     </div>
". $Price ."
                        <div class='clear'></div>
                     </div>
                     <div class='clear'></div>
                     <div class='SocialMediaContainer'>
                     </div>
                  </div>
                  <div class='clear'></div>
               </div>
		<iframe allowtransparency='true' frameborder='0' width='800' height='400' scrolling='no' src='". $baseUrl ."/Catalog/ShowMore.php?ItemType=Catalog'></iframe>
            </div>
<div class='Ads_WideSkyscraper'>
	<div style='width: 160px;'>
		<iframe allowtransparency='true' frameborder='0' width='160' height='600' scrolling='no' src='". $baseUrl ."/Tools/Asset.ashx?request=advertisement&adtype=rectangle&id=0' width='300' data-js-adtype='iframead'></iframe>
	</div>
</div>
            <div class='clear'>
            </div>
         </div>
         <div style='clear:both'></div>
      </div>
   </div>
</div>";
?>
						<pre id="EpicMagic"></pre>
			<?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/Footer.php'); ?>
						<script type="text/javascript">
						function Customize(){
							window.location.href='<?php echo $baseUrl; ?>/My/Character.aspx';
						}
						function TicketsPurchase(){
								showheight = $(document).height();
								showwidth = $(document).width();
								MagicBox = document.getElementById('EpicMagic');
								MagicBox.innerHTML="<div id='simplemodal-overlay' class='simplemodal-overlay' style='background-color: rgb(0, 0, 0); opacity: 0.8; height: "+showheight+"px; width: "+showwidth+"px; position: fixed; left: 0px; top: 0px; z-index: 1001;'></div><div id='simplemodal-container' class='simplemodal-container' style='position: absolute;left: 50%;top: 50%;transform: translate(-50%, -50%);z-index: 1002;'><div class='GenericModal modalPopup unifiedModal smallModal' style='display:block;'><div class='Title'>Buy Item</div><div class='GenericModalBody'><div><div style='margin-left: 20px;' class='ImageContainer roblox-item-image' data-image-size='small' data-no-overlays='' data-no-click=''><img src='<?php echo $baseUrl; ?>/Tools/Asset.ashx?id=<?php echo $ItemId; ?>&request=asset' class='GenericModalImage' alt='generic image'></div><div class='Message'><p align='center'>Are you sure you wanna buy <?php echo $AssetTitle; ?> for <span class='currency CurrencyColor2'><?php echo $AssetTicket; ?></span>?</p></div><div style='clear:both'></div></div><div style='margin-top:10px; margin-bottom:-7px;' class='GenericModalButtonContainer'><a onclick='PurchaseTicket()' class='ImageButton btn-primary btn-large roblox-ok'>Buy Now<span class='btn-text'>Buy Now</span></a> <a onclick='ByeBox()' class='ImageButton btn-neutral btn-large roblox-ok'>Cancel<span class='btn-text'>Cancel</span></a></div></div></div></div>";
						}
						
						function PurchaseTicket(){
							window.location.href='<?php echo $baseUrl; ?>/Tools/PurchaseItem.ashx?id=<?php echo $ItemId; ?>&HandleMethod=Tickets';
						}
						
						function RobuxPurchase(){
								showheight = $(document).height();
								showwidth = $(document).width();
								MagicBox = document.getElementById('EpicMagic');
								MagicBox.innerHTML="<div id='simplemodal-overlay' class='simplemodal-overlay' style='background-color: rgb(0, 0, 0); opacity: 0.8; height: "+showheight+"px; width: "+showwidth+"px; position: fixed; left: 0px; top: 0px; z-index: 1001;'></div><div id='simplemodal-container' class='simplemodal-container' style='position: absolute;left: 50%;top: 50%;transform: translate(-50%, -50%);z-index: 1002;'><div class='GenericModal modalPopup unifiedModal smallModal' style='display:block;'><div class='Title'>Buy Item</div><div class='GenericModalBody'><div><div style='margin-left: 20px;' class='ImageContainer roblox-item-image' data-image-size='small' data-no-overlays='' data-no-click=''><img src='<?php echo $baseUrl; ?>/Tools/Asset.ashx?id=<?php echo $ItemId; ?>&request=asset' class='GenericModalImage' alt='generic image'></div><div class='Message'><p align='center'>Are you sure you wanna buy <?php echo $AssetTitle; ?> for <span class='currency CurrencyColor1'><?php echo $AssetRS; ?></span>?</p></div><div style='clear:both'></div></div><div style='margin-top:10px; margin-bottom:-7px;' class='GenericModalButtonContainer'><a onclick='PurchaseRobux()' class='ImageButton btn-primary btn-large roblox-ok'>Buy Now<span class='btn-text'>Buy Now</span></a> <a onclick='ByeBox()' class='ImageButton btn-neutral btn-large roblox-ok'>Cancel<span class='btn-text'>Cancel</span></a></div></div></div></div>";
						}
						
						function PurchaseRobux(){
							window.location.href='<?php echo $baseUrl; ?>/Tools/PurchaseItem.ashx?id=<?php echo $ItemId; ?>&HandleMethod=Robux';
						}
						
						function ByeBox(){
								showheight = $(document).height();
								showwidth = $(document).width();
								MagicBox = document.getElementById('EpicMagic');
								MagicBox.innerHTML='';
						}
						
						function FreePurchase(){
							window.location.href='<?php echo $baseUrl; ?>/Tools/PurchaseItem.ashx?id=<?php echo $ItemId; ?>&HandleMethod=Free';
						}
						
						function DropDownOpen(){
							MagicDropDown = document.getElementById('DropDownWithCustomJS');
							MagicDropdown.classList.contains()
						}
						</script>
         </div>
      </div>
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