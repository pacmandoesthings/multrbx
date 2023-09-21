<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Develop/DevelopAPI/EditUpdate.php');
switch(true){case ($RBXTICKET == null):die(header("Location: ". $baseUrl ."/"));break;}

$ItemId = (int)($_GET['id'] ?? die(header("Location: ". $baseUrl ."/")));
$FetchItem = $MainDB->prepare("SELECT * FROM asset WHERE id = :pid AND creatorid = :id AND itemtype != 'advertisement'");
$FetchItem->execute([":pid" => $ItemId, ":id" => $id]);
$ItemInfo = $FetchItem->fetch(PDO::FETCH_ASSOC);

switch(true){
	case($ItemInfo):
		$ItemTitle = $ItemInfo['name'];
		$ItemBlurb = $ItemInfo['moreinfo'];
		$ItemRobux = $ItemInfo['rsprice'];
		$ItemTicket = $ItemInfo['tkprice'];
		$ItemType = $ItemInfo['itemtype'];
		break;
	default:
		die(header("Location: ". $baseUrl ."/"));
		break;
}
switch($ItemType){
	case "place":
		$ReturnTo = $baseUrl . "/Games/ViewGame.ashx?id=" . $ItemId;
		$ItemRender = $baseUrl . "/Tools/Asset.ashx?id=". $ItemId ."&request=place";
		$Thumbnail = '<h4>Game Thumbnail</h4><div><iframe id="upload-iframe" class="my-upload-iframe" src="'. $baseUrl .'/Tools/Upload.aspx?AssetTypeId=47&gameid='.$ItemId.'" frameborder="0" scrolling="no"></iframe></div>';
$PlaceFile = '<h4>Reupload Place</h4><div><iframe id="upload-iframe" class="my-upload-iframe" src="'. $baseUrl .'/Tools/Upload.aspx?AssetTypeId=401&gameid='.$ItemId.'" frameborder="0" scrolling="no"></iframe></div>';
		$GenreChooser = "<div id='ctl00_cphRoblox_GenreOptionsPanel'>
   <div id='SetGenres'>
      <fieldset>
         <legend>Genre</legend>
         <div class='Suggestion'>
            Classify your place to help people find it.
         </div>
         <div id='ctl00_cphRoblox_AllowOneGenre'>
            <div class='GenreSettings'>
               <p align='center'>
                  <select name='gametype' id='gametype'>
                     <option value='All'>All</option>
                     <option value='Fighthing'>Fighthing</option>
                     <option value='City'>City</option>
					 <option value='Western'>Western</option>
					 <option value='RPG'>RPG</option>
					 <option value='Modern'>Modern</option>
					 <option value='Horror'>Horror</option>
					 <option value='Building'>Building</option>
				  </select>
               </p>
            </div>
         </div>
      </fieldset>
   </div>
</div>";
		$SellOption = null;
		break;
	default:
		$ReturnTo = $baseUrl . "/Catalog/ViewItem.aspx?id=" . $ItemId;
		$ItemRender = $baseUrl . "/Tools/Asset.ashx?id=". $ItemId ."&request=asset";
		$GenreChooser = null;
		$Thumbnail = null;
		$PlaceFile = null;

		$SellOption = "								<div id='ctl00_cphRoblox_SellThisItemPanel'>
								   <div id='SellThisItem'>
									  <fieldset title='Sell this Item'>
										 <legend id='ctl00_cphRoblox_SellLegend'>Sell this Item</legend>
										 <div id='ctl00_cphRoblox_AssetSellSuggestion' class='Suggestion'>
											Check the box below and enter a price if you want to sell this item in the Roblox
											catalog. Uncheck the box to remove the item from the catalog. (Un-checking and re-checking the following box on a <b>free item</b> will cause the item to <b>require a price</b>. Please <b>do not</b> attempt to modify the price of items sold with <b><span class='tickets ' data-se='item-priceintickets'>Tix</span></b>.)
										 </div>
		<div class='SellThisItemRow'>
   <input id='ctl00_cphRoblox_SellThisItemCheckBox' type='checkbox' name='forsale' checked='checked'><label for='ctl00_cphRoblox_SellThisItemCheckBox'>Sell this Item</label>
   <div id='ctl00_cphRoblox_PricingPanel' class='PricingPanel' style=''>
      <div id='Pricing'>
         <div id='OriginalPrice' style='margin-top:10px'>
            <div class='PricingLabel form-label'>
               Original Price:
            </div>
            <div class='PricingField_Robux'>
               <span class='robux UserProfitInRobuxLabel'>". $ItemRobux ."</span>
            </div>
            <div class='PricingField_Tickets'>
               <span class='tickets UserProfitInTicketsLabel'>". $ItemTicket ."</span>
            </div>
            <div style='clear: both;'></div>
         </div>
         <div id='Price'>
            <div class='PricingLabel form-label' style='margin-top: 5px'>
               Price:
            </div>
            <div class='PricingField_Robux'>
               <span class='robux'>&nbsp;</span>
               <input name='pricerobux' id='pricerobux' type='text' maxlength='9' id='ctl00_cphRoblox_RobuxPrice' class='TextBox'>
            </div>
            <div class='PricingField_Tickets'>
               <span class='tickets'>&nbsp;</span>
               <input name='pricetickets' id='pricetickets' type='text' maxlength='9' id='ctl00_cphRoblox_TicketsPrice' class='TextBox'>
            </div>
            <span id='PricingError' class='status-error' style='display:none;'>
            The minimum price for this item is <span class='robux notranslate'>0</span>
            </span>
            <span id='PricingErrorMax' class='status-error' style='display:none;'>
            The maximum price for this item is <span class='robux notranslate'>0</span>
            </span>
            <div style='clear: both;'></div>
         </div>
      </div>
   </div>
</div>
</fieldset>
</div>
</div>";
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
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/RBX2/CSS/Item.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide2.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/MyItem.css' />
<script type="text/javascript" src="<?php echo $baseUrl; ?>/js/Build/bcjsPHP.php"></script>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
   <head>
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <title>
         MULTRBX - Edit
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
<?php
switch(true){
	case (count($errors) > 0):
		foreach ($errors as $error){
			echo '<div id="AccountPageContainer" data-missingparentemail="false" data-userabove13="true" data-currentdateyear="" data-currentdatemonth="" data-currentdateday=""><div id="ctl00_Announcement"><div id="ctl00_SystemAlertDiv" class="SystemAlert"><div id="ctl00_SystemAlertTextColor" class="SystemAlertText"><div id="ctl00_LabelAnnouncement">'. $error .'</div></div></div></div>';
		}
		break;
}
?>
				<?php
				echo "<form method='POST' action='". $CurrPage ."'>
				<div id='Body' class='body-width '>
					   <div id='EditItemContainer'>
						  <h1>Configure ". $ItemType ."</h1>
						  <div>
							 <div id='EditItem' style='width:890px;'>
								<div id='ItemName'>
								   <span id='ctl00_cphRoblox_NameLabel' class='form-label'>Name:</span><br>
								   <input name='name' type='text' value='". $ItemTitle ."' maxlength='50' id='name' class='TextBox'>
								   <span id='ctl00_cphRoblox_NTBRFV' style='color:Red;visibility:hidden;'>A Name is Required</span>
								</div>
								<div id='ItemThumbnail'>
								   <a href='". $ReturnTo ."'><img title='". $ItemTitle ."' alt='". $ItemTitle ."' border='0' height='230' width='230' class='original-image modal-thumb' src='". $ItemRender ."'></a>
								</div>
								<div id='ItemDescription'>
								   <span id='ctl00_cphRoblox_DescriptionLabel' class='form-label'>Description:</span><br>
								   <textarea name='moreinfo' rows='2' cols='20' id='moreinfo' class='text' style='height:150px;width: 410px;padding: 5px;'>". $ItemBlurb ."</textarea>
								</div>
								<div class='Buttons'>
								
								   <button type='submit' name='postUpdate' class='btn-small btn-neutral' style='height:22px;'>
								   Save
								   <span class='btn-text'>Save</span>
								   </button>&nbsp;
								   <button class='btn-small btn-negative' style='height:22px;'>
								   Cancel
								   <span class='btn-text'>Cancel</span>
								   </button>
								</div>
								". $SellOption . $GenreChooser . $Thumbnail . $PlaceFile ."
								<div class='Buttons'>
								   <button type='submit' name='postUpdateExtra' id='postUpdateExtra' class='btn-small btn-neutral' style='height:22px;'>
								   Save
								   <span class='btn-text'>Save</span>
								   </button>&nbsp;
								   <button class='btn-small btn-negative' style='height:22px;'>
								   Cancel
								   <span class='btn-text'>Cancel</span>
								   </button>
								</div>
							 </div>
						  </div>
					   </div>
					   <div style='clear: both;'></div>
					</div>
					</form>";
				?>
			  </div>
			</div>            
         </div>
      </div>
	  </div>
	  <?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/Footer.php'); ?>
   </body>
</html>