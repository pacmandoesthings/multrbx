<?php

include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/FuncTypes.php');
  $GameId = (int)($_GET['id'] ?? die(header('Location: '. $baseUrl .'/RobloxDefaultErrorPage.aspx')));
  $vipserv = ($_GET['isVipServer'] ?? null);

  



$GameFetch = $MainDB->prepare("SELECT * FROM asset WHERE id = :pid AND itemtype = 'place'");
$GameFetch->execute([":pid" => $GameId]);
$Results = $GameFetch->fetch(PDO::FETCH_ASSOC);
  
$TokenFetch = $MainDB->prepare("SELECT token FROM users WHERE id = :uid");
$TokenFetch->execute([":uid" => $id]);
$ResultsT = $TokenFetch->fetch(PDO::FETCH_ASSOC);

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
$token = $ResultsT["token"];



$gameargs = "1+launchmode:play+gameinfo:0+placelauncherurl:https://mulrbx.com/game/PlaceLauncher.ashx?request=RequestGame&placeId=".$GameId."&token=".$token;



header("Location: mulrbx-player-mulrbx:".$gameargs);

 
  

 


?>
l>

