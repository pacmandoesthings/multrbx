<?php 
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/FuncTypes.php');
$GameId = (int)($_GET['id'] ?? die(header('Location: '. $baseUrl .'/RobloxDefaultErrorPage.aspx')));

$GameFetch = $MainDB->prepare("SELECT * FROM asset WHERE id = :pid AND itemtype = 'place'");
$GameFetch->execute([":pid" => $GameId]);
$Results = $GameFetch->fetch(PDO::FETCH_ASSOC);


switch(true){case ($admin == 0):die(header("Location: mulrbx.com/games"));break;}

switch(true){case(!$Results):die(header('Location: '. $baseUrl .'/RobloxDefaultErrorPage.aspx'));break;}

$GameTitle = $Results['name'];
$GameInfo = $Results['moreinfo'];
$GameLike = $Results['liked'];
$GameDislike = $Results['disliked'];
$GamePublic = $Results['public'];
$GameFavorite = $Results['favorited'];
$GamePlayed = $Results['played'];
$GameGenre = $Results['genre'];
$GameDate = $Results['createdon'];
$GameUpdate = $Results['updatedon'];
$GameApproval = $Results['approved'];
$CreatorName = $Results['creatorname'];
$CreatorId = $Results['creatorid'];
$GamePercentage = getGameBar($GameLike, $GameDislike);



switch(true){case($RBXTICKET):$IsLoggedIn = "Yes";switch(true){case ($CreatorId == $id):$IsCreator = "Yes";break;default:$IsCreator = "No";break;}break;default:$IsLoggedIn = "No";$IsCreator = "No";break;}

switch(true){
	case ($IsCreator == "Yes"):
		$GameOptions = "<div class='configure divider-top'><div class='form-label'>Options</div><div><a href='". $baseUrl ."/Develop/Edit.aspx?id=". $GameId ."'>Configure this Place</a></div><div><a href='". $baseUrl ."/My/Advertising.ashx?id=". $GameId ."'>Advertise this Place</a></div></div>";
		switch($GameApproval){
			case "2":
				$Notice = '<div id="AccountPageContainer" data-missingparentemail="false" data-userabove13="true" data-currentdateyear="" data-currentdatemonth="" data-currentdateday=""><div id="ctl00_Announcement"><div id="ctl00_SystemAlertDiv" class="SystemAlert"><div id="ctl00_SystemAlertTextColor" class="SystemAlertText"><div id="ctl00_LabelAnnouncement">Your game has not been approved.</div></div></div></div></div>';
				break;
			case null:
				$Notice = '<div id="AccountPageContainer" data-missingparentemail="false" data-userabove13="true" data-currentdateyear="" data-currentdatemonth="" data-currentdateday=""><div id="ctl00_Announcement"><div id="ctl00_SystemAlertDiv" class="SystemAlert"><div id="ctl00_SystemAlertTextColor" class="SystemAlertText"><div id="ctl00_LabelAnnouncement">Your game is under approval, it will not be listed on the Games pages until it gets approved.</div></div></div></div></div>';
				break;
			default:
				$Notice = null;
				break;
		}
		break;
	default:
		$GameOptions = null;
		$Notice = null;
		break;
}

switch(true){
	case ($IsLoggedIn == "Yes"):
		$GameVoting = '<div class="actions"><div class="favorite-button-container" title="Add to favorites"><a><div class="favorite-button" data-toggle-url="/favorite/toggle" data-assetid="'. $GameId .'"></div></a></div><div class="voting"><div class="voting-panel body"><div class="loading"></div><div class="users-vote"><div class="upvote"></div><div class="downvote divider-left"></div></div><div class="vote-summary"><div class="voting-details"><div class="total-upvotes divider-right"><div class="tiny-thumbs-up"></div><span>Thumbs up: '. $GameLike .'</span></div><div class="total-downvotes"><span>Thumbs down: '. $GameDislike .'</span><span class="tiny-thumbs-down"></span></div><div class="clear"></div></div><div class="visual-container"><div class="background votes"></div><div class="percent" style="width:'. $GamePercentage .'%"></div><div class="clear"></div></div></div><div class="clear"></div></div></div><div class="clear"></div><span class="ReportAbuse"><div id="ctl00_cphRoblox_NewGamePageControl_AbuseReportButton_AbuseReportPanel" class="ReportAbuse"><span class="AbuseIcon"><a id="ctl00_cphRoblox_NewGamePageControl_AbuseReportButton_ReportAbuseIconHyperLink" href="'. $baseUrl .'/Tools/ReportAbuse.ashx?id='. $GameId .'&back='. $CurrPage .'"></a></span><span class="AbuseButton"><a id="ctl00_cphRoblox_NewGamePageControl_AbuseReportButton_ReportAbuseTextHyperLink" href="'. $baseUrl .'/Tools/ReportAbuse.ashx?id='. $GameId .'&back='. $CurrPage .'">Report Abuse</a></span></div></span></div>';
		break;
	default:
		$GameVoting = '<div class="actions"><div class="favorite"></div><div class="voting"><div class="voting-panel body"><div class="loading"></div><div class="vote-summary"><div class="voting-details"><div class="total-upvotes divider-right"><div class="tiny-thumbs-up"></div><span>Thumbs up: '. $GameLike .'</span></div><div class="total-downvotes"><span>Thumbs down: '. $GameDislike .'</span><span class="tiny-thumbs-down"></span></div><div class="clear"></div></div><div class="visual-container"><div class="background votes"></div><div class="percent" style="width:'. $GamePercentage .'%"></div><div class="clear"></div></div></div><div class="clear"></div></div></div><div class="clear"></div><span class="ReportAbuse"><div id="ctl00_cphRoblox_NewGamePageControl_AbuseReportButton_AbuseReportPanel" class="ReportAbuse"><span class="AbuseIcon"><a id="ctl00_cphRoblox_NewGamePageControl_AbuseReportButton_ReportAbuseIconHyperLink" href="'. $baseUrl .'/Tools/ReportAbuse.ashx?id='. $GameId .'&back='. $CurrPage .'"></a></span><span class="AbuseButton"><a id="ctl00_cphRoblox_NewGamePageControl_AbuseReportButton_ReportAbuseTextHyperLink" href="'. $baseUrl .'/Tools/ReportAbuse.ashx?id='. $GameId .'&back='. $CurrPage .'">Report Abuse</a></span></div></span></div>';
		break;
}
?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/js/IncludeJS.php'); ?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
   <head>
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <title>
         MULTRBX - <?php echo $GameTitle; ?>
      </title>
   <body>

 <title>MULTRBX</title>
    <meta content="MULTRBX Revival - <?php echo $GameTitle; ?>" property="og:title" />
    <meta content="Game made by <?php echo $CreatorName; ?>  " property="og:description" />
    
    <meta content="http://multrbx.com" property="og:url" />
    <meta content="" property="og:image" />
    <meta content="#00FF00" data-react-helmet="true" name="theme-color" />
<?php 
if ($theme !== 1) {
echo "<link rel='stylesheet' href='$baseUrl/CSS/Base/CSS/Roblox.css' />";
}
?>
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Accounts/AccountMVC.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/UnifiedModal.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/GenericModal.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/GamePage.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/VotingPanel.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Favorites.css' />
      <div id="Container" style="background-color: white;">
         <?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/ContextHeader.php');  ?>
         <div style="padding-top:40px;"></div>
         <div style="clear: both">
			<div id="BodyWrapper">
			<div id="AdvertisingLeaderboard">
			   <div style="left:17px;position:relative;">
				  <iframe allowtransparency="true" frameborder="0" height="90" scrolling="no" src="<?php echo $baseUrl; ?>/Tools/Asset.ashx?request=advertisement&adtype=top&id=0" width="745"></iframe>            
			   </div>
			</div>
			   <div id="RepositionBody">
				  <div id="Body" style="width:auto;">
				  <?php echo $Notice; ?>
					 <div id="ItemContainer" class="PlaceItemContainer new-game-page">
							<?php
							switch(true){
								case ($RBXTICKET == null):
									echo "<div id='JoinRoblox' class='Ads_WideSkyscraper' style='float: left; height: 863px; width: 160px; border: 1px solid rgb(136, 136, 136); text-align: center; margin: 0px 8px 10px 0px;'><div style='padding:20px 7px;'><div style='font:normal 18px Arial, Helvetica, Sans-Serif; color:#666'>Join ROBLOX</div><hr class='PlaceItemHR'><div style='text-align:left; font-size:13px;'><div style='font-weight:bold;margin-top:15px;'>By joining ROBLOX, you can:</div><ul style='padding-left:15px;line-height:1.5em;'><li>Make friends</li><li>Change your character</li><li>Make your own game</li><li>Join groups</li><li>Use gear items</li></ul></div><div style='margin-top:65px; text-align:center'><a href='". $baseUrl ."/Login/NewAge.aspx'><div class='btn-neutral btn-large'>Sign Up</div></a></div></div></div>";
									break;
							}
							echo "
						<div id='Item' class='place-item redesign body'>
						   <div class='item-header'>
							  <h1 class='notranslate'>". $GameTitle ."</h1>
						   </div>
						   <div class='left-column'>
							  <div class='item-media'>
								 <div style='margin: 0px auto; width: 500px'>
									<div id='ItemThumbnail' style='height:280px; width: 500px'>
									   <div id='bigGalleryThumbItem' style='position: absolute;'>
										  <a id='ctl00_cphRoblox_NewGamePageControl_RichMediaThumbDisplay_rbxGalleryAssetThumbnail_rbxAssetImage' class=' notranslate' title='". $GameTitle ."' style='display:inline-block;height:280px;width:500px;cursor:pointer;'><img src='". $baseUrl ."/Tools/Asset.ashx?id=". $GameId ."&request=place' height='280' width='500' border='0' onerror='return Roblox.Controls.Image.OnError(this)' alt='". $GameTitle ."' class=' notranslate'></a>
									   </div>
									</div>
								 </div>
							  </div>
							". $GameVoting ."
							  <div class='description notranslate'>
								 <div id='DescriptionText' class='invisible'>". $GameInfo ."</div>
								 <pre id='PlaceDescription' class='body'>". $GameInfo ."<p></p>
								 <a class='DescriptionSeeMore'>See More</a></pre>
							  </div>
						   </div>
						   <div class='right-column'>
							  <div class='builder divider-bottom'>
								 <div class='builder-image'>
									<div class='roblox-avatar-image' data-user-id='13416513' data-image-size='tiny'>
									   <div style='position: relative;'><a href='". $baseUrl ."/User.php?id='". $CreatorId ."'><img title='". $CreatorName ."' border='0' src='". $baseUrl ."/Tools/Asset.ashx?id=". $CreatorId ."&request=avatar'></a></div>
									</div>
								 </div>
								 <div class='builder-name'><span>Builder: '". $CreatorName ."' </span><span class='notranslate'><a href='". $baseUrl ."/User.php?id=". $CreatorId ."' class='tooltip' original-title='". $CreatorName ."'</span></div>
								 <div class='clear'></div>
							  </div>

							  <div class='buttons'>
								 <div id='VisitButtonContainer'>
									<div class='VisitButtonsLeft Centered'>
									   <div id='ctl00_cphRoblox_NewGamePageControl_VisitButtons_MultiplayerVisitButton' class='VisitButton VisitButtonPlay' placeid='". $GameId ."'>
										  <a style='color: #ffffff;' onclick='MagicLoadBox()' class='btn-medium btn-primary'>Play</a>
									   </div>
									</div>
								 </div>
							  </div> 

							  <div class='details '>
								 <div class='statistics'>
									<div><span class='stat-label'>Created:</span><span class='stat'>". $GameDate ."</span></div>
									<div><span class='stat-label'>Updated:</span><span class='stat'>". $GameUpdate ."</span></div>
									<div><span class='stat-label'>Favorited:</span><span class='stat'>". $GameFavorite ."</span></div>
									<div><span class='stat-label'>Visited:</span><span class='stat'>". $GamePlayed ."</span></div>
									<div><span class='stat-label'>Genres:</span><span class='stat'><a href='". $baseUrl ."/Games'>". $GameGenre ."</a></span></div>
								 </div>
								". $GameOptions ."
								 <div class='clear'></div>
							  </div>
						   </div>
						</div>";
							?>
						<pre id="EpicMagic"></pre>
						<div class="clear"></div>
						<script type='text/javascript'>
                                                        
							function MagicLoadBox(){
								showheight = $(document).height();
								showwidth = $(document).width();
								MagicBox = document.getElementById('EpicMagic');
								MagicBox.innerHTML='<div id="simplemodal-overlay" class="simplemodal-overlay" style="background-color: rgb(0, 0, 0); opacity: 0.8; height: '+showheight+'px; width: '+showwidth+'px; position: fixed; left: 0px; top: 0px; z-index: 1001;"></div><div id="simplemodal-container" class="simplemodal-container" style="position: absolute;left: 50%;top: 50%;transform: translate(-50%, -50%);z-index: 1002;"><div id="PlaceLauncherStatusPanel" style="display:block"><div class="modalPopup blueAndWhite PlaceLauncherModal" style="min-height: 190px"><div id="Spinner" class="Spinner" style="margin:0 1em 1em 0; padding:20px 0;"></div><div id="status" style="min-height:40px;text-align:center;margin:5px 20px"><div id="Starting" class="PlaceLauncherStatus MadStatusStarting" style="display:block"><br></div><div id="Waiting" class="PlaceLauncherStatus MadStatusField">Connecting to Players...</div><div id="StatusBackBuffer" class="PlaceLauncherStatus PlaceLauncherStatusBackBuffer MadStatusBackBuffer"></div></div><div style="text-align:center;margin-top:1em"><a href="/playgame.php?id=<?php echo $GameId ?>" class="Button CancelPlaceLauncherButton translate" value="">join game</a><br><a onclick="MagicGoneBox()" class="Button CancelPlaceLauncherButton translate" value="">or click this if you have changed your mind</a><br><br></div></div></div></div>';
							}
							
							function MagicGoneBox(){
								MagicBox = document.getElementById('EpicMagic');
								MagicBox.innerHTML='';
							}
						</script>
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