<?php 
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
$GameId = (int)($_GET['id'] ?? die(header('Location: '. $baseUrl .'/IDE/Error.ashx?err=404')));

$GameFetch = $MainDB->prepare("SELECT * FROM asset WHERE id = :pid AND itemtype = 'place'");
$GameFetch->execute([":pid" => $GameId]);
$Results = $GameFetch->fetch(PDO::FETCH_ASSOC);

switch(true){case(!$Results):die(header('Location: '. $baseUrl .'/IDE/Error.ashx?err=404'));break;}

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

switch(true){case($RBXTICKET):$IsLoggedIn = "Yes";switch(true){case ($CreatorId == $id):$IsCreator = "Yes";break;default:$IsCreator = "No";break;}break;default:$IsLoggedIn = "No";$IsCreator = "No";break;}
switch(true){case($GameApproval !== "1"):die(header('Location: '. $baseUrl .'/MobileView/Error.aspx?err=404'));break;}
switch(true){case($GamePublic !== "1"):die(header('Location: '. $baseUrl .'/MobileView/Error.aspx?err=404'));break;}

switch(true){
	case ($IsLoggedIn == "Yes"):
		$Button = "<a href='games/start?placeid=". $GameId ."' class='ui-btn ui-shadow ui-btn-corner-all ui-btn-up-d'><span class='ui-btn-inner ui-btn-corner-all'><span class='ui-btn-text'>Play</span></span></a>";
		break;
	default:
		$Button = "<a href='games/start?placeID=". $GameId ."' class='ui-btn ui-shadow ui-btn-corner-all ui-btn-up-d'><span class='ui-btn-inner ui-btn-corner-all'><span class='ui-btn-text'>Play (Guest Mode)</span></span></a>";
		break;
}
?>
<!DOCTYPE html>
<title>ROBLOX - Games</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
<link rel="shortcut icon" href="<?php echo $baseUrl; ?>/favicon.ico">
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="<?php echo $baseUrl; ?>/Images/Icon114x114.png">
<link rel="stylesheet" href="<?php echo $baseUrl; ?>/MobileView/Items/MobileCSS.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/mobile/1.5.0-rc1/jquery.mobile-1.5.0-rc1.min.js"></script>
<script type="text/javascript" src="<?php echo $baseUrl; ?>/MobileView/Items/f3cf668ce6f524a713b4676de3716ab8.js"></script>
</head>
<body data-ga-key="UA-486632-9" class="ui-mobile-viewport ui-overlay-c">
   <div id="catalog-search-page" data-role="page" data-dom-cache="true" data-url="catalog-search-page" tabindex="0" class="ui-page ui-body-c ui-page-active" style="min-height: 940px;">
      <div class="wrapper">
<?php
echo "<div data-role='content' class='ui-content' role='main'>
   <div class='page-title'>
      <h3 class='no-margin'>". $GameTitle ." </h3>
      <span class='page-subheader'>Game by <a href='". $baseUrl ."/MobileView/Users/?id=". $CreatorId ."' class='ui-link'>". $CreatorName ."</a></span>
   </div>
   <div class='item-thumb'>
      <img width='288' height='288' src='". $baseUrl ."/Tools/Asset.ashx?id=" . $GameId . "&request=place' alt='". $GameTitle ." '>
   </div>
   <ul data-role='listview' data-inset='true' class='ui-listview ui-listview-inset ui-corner-all ui-shadow'>
      <li class='normal-weight ui-li ui-li-static ui-body-c ui-corner-top'>
         <div class='ui-li-static-text'>
            ". $GameInfo ."
         </div>
      </li>
      <li class='ui-li ui-li-static ui-body-c ui-corner-bottom'>
         <div class='list-toggle-left'>
            Genre
         </div>
         <div class='list-text-right'>
            ". $GameGenre ."
         </div>
         <div class='clear'></div>
      </li>
      <li class='ui-li ui-li-static ui-body-c ui-corner-bottom'>
         <div class='list-toggle-left'>
            Created on
         </div>
         <div class='list-text-right'>
            ". $GameDate ."
         </div>
         <div class='clear'></div>
      </li>
      <li class='ui-li ui-li-static ui-body-c ui-corner-bottom'>
         <div class='list-toggle-left'>
            Last updated on
         </div>
         <div class='list-text-right'>
            ". $GameUpdate ."
         </div>
         <div class='clear'></div>
      </li>
      <li class='ui-li ui-li-static ui-body-c ui-corner-bottom'>
         <div class='list-toggle-left'>
            Played
         </div>
         <div class='list-text-right'>
            ". $GamePlayed ." times
         </div>
         <div class='clear'></div>
      </li>
   </ul>
   ". $Button ."
</div>";
?>
      </div>
   </div>
   <div id="screen-cover"></div>
   <div class="ui-loader ui-corner-all ui-body-a ui-loader-default">
      <span class="ui-icon ui-icon-loading"></span>
      <h1>loading</h1>
   </div>
</body>
</html>