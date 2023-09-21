<?php 
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
include($_SERVER['DOCUMENT_ROOT'] . '/My/SettingsAPI/AccountUpdate.php');

switch(true){case ($RBXTICKET == null):die(header("Location: ". $baseUrl ."/"));break;}
$AssignFriends = " OR ";
$i = 0;

foreach($friends as $friendid){
	$i++;
	switch(true){
		case (empty($friends)):
			$AssignFriends = "";
			break;
		case ($i > 1):
			$AssignFriends = $AssignFriends . " OR `creatorid` = '". $friendid ."'";
			break;
		default:
			$AssignFriends = $AssignFriends . "`creatorid` = '". $friendid ."'";
			break;
	}
}

$FeedSearch = $MainDB->prepare("SELECT * FROM feed WHERE `creatorid` = ". $id  . $AssignFriends . " AND announcement = '0' ORDER BY id DESC LIMIT 3");
$FeedSearch->execute();
$Results = $FeedSearch->fetchAll();
?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/js/IncludeJS.php'); ?>
<!DOCTYPE html>
<title>ROBLOX - Home</title>
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
         <div data-role="content" class="ui-content" role="main">
            <div class="add-large-margin-top">
               <ul data-results-list="" data-role="listview" class="ui-listview">
<?php
echo "<li class='catalog-list-item ui-btn ui-btn-icon-right ui-li ui-li-has-thumb ui-btn-up-c' data-icon='false' data-corners='false' data-shadow='false' data-iconshadow='true' data-wrapperels='div' data-iconpos='right' data-theme='c'>
   <div class='ui-btn-inner ui-li'>
      <div class='ui-btn-text'>
         <a href='#' class='ui-link-inherit'>
            <img width='80' height='80' src='". $baseUrl ."/Tools/Asset.ashx?id=". $id ."&request=avatar' alt='". $name ."' class='ui-li-thumb'>
            <h3 class='ui-li-heading'>". $name ."</h3>
			<p class='catalog-list-price ui-li-desc'>
                <span class='currency-robux'>". $robux ."</span> <span class='currency-ticket'>". $ticket ."</span>
			</p>
         </a>
      </div>
   </div>
</li>";
?>
               </ul>
			   <br></br>
			   <form method="POST" action="<?php echo $CurrPage; ?>">
				   <p>My Status:</p>
				   <input data-val="true" id="txtStatusMessage" name="txtStatusMessage" placeholder="My Status" type="text" maxlength="254" class="ui-input-text ui-body-c ui-corner-all ui-shadow-inset">
				   <div data-corners="true" data-shadow="true" data-iconshadow="true" data-wrapperels="span" data-icon="null" data-iconpos="null" data-theme="b" data-inline="false" data-mini="false" class="ui-btn ui-shadow ui-btn-corner-all ui-fullsize ui-btn-block ui-submit ui-btn-up-b" aria-disabled="false"><span class="ui-btn-inner ui-btn-corner-all"><span class="ui-btn-text">Update Status</span></span><button type="submit" name="updatestatus" id="updatestatus" data-theme="b" class="ui-btn-hidden" aria-disabled="false">Update Status</button></div>
			   </form>
			   <br></br>
			   <ul data-results-list="" data-role="listview" class="ui-listview">
<?php
switch(true){
	case ($Results):
		foreach($Results as $StatusInfo){
			echo "<li class='catalog-list-item ui-btn ui-btn-icon-right ui-li ui-li-has-thumb ui-btn-up-c' data-icon='false' data-corners='false' data-shadow='false' data-iconshadow='true' data-wrapperels='div' data-iconpos='right' data-theme='c'>
   <div class='ui-btn-inner ui-li'>
      <div class='ui-btn-text'>
         <a href='". $baseUrl ."/MobileView/Users/?id=". $StatusInfo['creatorid'] ."' class='ui-link-inherit'>
            <img width='80' height='80' src='". $baseUrl ."/Tools/Asset.ashx?id=". $StatusInfo['creatorid'] ."&request=avatar' alt='". $StatusInfo['creatorname'] ."' class='ui-li-thumb'>
            <h3 class='ui-li-heading'>". $StatusInfo['creatorname'] ."</h3>
			<p class='catalog-list-description ui-li-desc'>". $StatusInfo['content'] ."</p>
         </a>
      </div>
   </div>
</li>";
		}
		break;
}
?>
				</ul>
			</div>
         </div>
      </div>
    </div>
   <div id="screen-cover"></div>
   <div class="ui-loader ui-corner-all ui-body-a ui-loader-default">
      <span class="ui-icon ui-icon-loading"></span>
      <h1>loading</h1>
   </div>
</body>
</html>