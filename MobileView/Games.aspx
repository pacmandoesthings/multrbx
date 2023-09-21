<?php 
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
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
         <div data-role="content" class="ui-content" role="main">
            <div class="add-large-margin-top">
               <ul data-results-list="" data-role="listview" class="ui-listview">
<?php
$ActionFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND itemtype = 'place'");
$ActionFetch->execute();
$ActionRows = $ActionFetch->fetchAll();
switch(true){
	case ($ActionRows):
		foreach($ActionRows as $GameInfo){
			echo "<li class='catalog-list-item ui-btn ui-btn-icon-right ui-li ui-li-has-thumb ui-btn-up-c' data-icon='false' data-corners='false' data-shadow='false' data-iconshadow='true' data-wrapperels='div' data-iconpos='right' data-theme='c'>
   <div class='ui-btn-inner ui-li'>
      <div class='ui-btn-text'>
         <a href='". $baseUrl ."/MobileView/Games/?id=". $GameInfo['id'] ."' class='ui-link-inherit'>
            <img width='80' height='80' src='". $baseUrl ."/Tools/Asset.ashx?id=" . $GameInfo['id'] . "&request=place' alt='". $GameInfo['name'] ."' class='ui-li-thumb'>
            <h3 class='ui-li-heading'>". $GameInfo['name'] ."</h3>
            <p class='catalog-list-description ui-li-desc'>". $GameInfo['moreinfo'] ."</p>
         </a>
      </div>
   </div>
</li>";
		}
		break;
	default:
		echo "<li data-load-more='' data-icon='false' data-corners='false' data-shadow='false' data-iconshadow='true' data-wrapperels='div' data-iconpos='right' data-theme='c' class='ui-btn ui-btn-up-c ui-btn-icon-right ui-li'>
   <div class='ui-btn-inner ui-li'>
      <div class='ui-btn-text'>
         <a href='#'class='ui-link-inherit'>
            <h3 style='text-align: center; color: #444;' class='ui-li-heading'>There are no games.</h3>
         </a>
      </div>
   </div>
</li>";
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