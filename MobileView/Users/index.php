<?php 
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
$UserId = (int)($_GET['id'] ?? die(header('Location: '. $baseUrl .'/IDE/Error.ashx?err=404')));

$UserFetch = $MainDB->prepare("SELECT * FROM users WHERE id = :pid");
$UserFetch->execute([":pid" => $UserId]);
$Results = $UserFetch->fetch(PDO::FETCH_ASSOC);

switch(true){case(!$Results):die(header('Location: '. $baseUrl .'/IDE/Error.ashx?err=404'));break;}

$InfoName = $Results['name'];
$InfoStatus = $Results['status'];
$InfoDate = $Results['creationdate'];
$InfoTermination = $Results['termtype'];

switch(true){case($InfoTermination !== null):die(header('Location: '. $baseUrl .'/MobileView/Error.aspx?err=404'));break;}
?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/js/IncludeJS.php'); ?>
<!DOCTYPE html>
<title>ROBLOX - <?php echo $InfoName; ?></title>
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
      <h3 class='no-margin'>". $InfoName ."</h3>
   </div>
   <div class='catalog-item-thumb'>
	  <div class='item-thumb'>
      <img src='". $baseUrl ."/Tools/Asset.ashx?id=". $UserId ."&request=avatar' alt='". $InfoName ."'>
	  </div>
   </div>
   <div style='display: none;' data-info='' data-user-id='19358' data-user-name='". $InfoName ."'></div>
   <ul data-role='listview' data-inset='true' class='ui-listview ui-listview-inset ui-corner-all ui-shadow'>
      <li class='normal-weight ui-li ui-li-static ui-body-c ui-corner-top'>
         <div class='ui-li-static-text'>
            ". htmlspecialchars($InfoStatus) ."
         </div>
      </li>
      <li class='ui-li ui-li-static ui-body-c ui-corner-bottom'>
         <div class='list-toggle-left'>
            Joined ROBLOX on
         </div>
         <div class='list-text-right'>
            ". $InfoDate ."
         </div>
         <div class='clear'></div>
      </li>
   </ul>
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