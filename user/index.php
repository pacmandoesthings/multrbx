<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/js/IncludeJS.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php'); 
$userid = (int)($_GET['id']);
$GameFetch = $MainDB->prepare("SELECT * FROM users WHERE id = :pid");
$GameFetch->execute([":pid" => $userid]);
$Results = $GameFetch->fetch(PDO::FETCH_ASSOC);

switch(true){case(!$Results):die(header('Location: '. $baseUrl .'/RobloxDefaultErrorPage.aspx'));break;}

$username = $Results['name'];
$status = $Results['status'];

  ?>
<!DOCTYPE html>
<?php 
if ($theme !== 1) {
echo "<link rel='stylesheet' href='$baseUrl/CSS/Base/CSS/Roblox.css' />";
}
?>
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Accounts/AccountMVC.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide2.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/UnifiedModal.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/GenericModal.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Home/Home.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Home/RobloxFeed.css' />
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
   <head>
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <title>
          MULTRBX - User
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
             <div>

               
               <h2 class="title">
    <span id="ctl00_cphRoblox_rbxUserPane_lUserRobloxURL"><?php echo $username; ?>'s Profile</span></h2>
<div class="divider-bottom" style="position: relative;z-index:3;padding-bottom: 20px">
    <div style="width: 100%">
        <div id="ctl00_cphRoblox_rbxUserPane_onlineStatusRow">
            <div style="text-align: center;">
                
                <span id="ctl00_cphRoblox_rbxUserPane_lUserOnlineStatus" class="UserOfflineMessage">[Online]</span>
                
            </div>
        </div>
        <div>
            <div>
                <center>
                    <div style="margin-bottom: 10px;">
                        <span style="font-size: 13px;">
                            <a id="ctl00_cphRoblox_rbxUserPane_hlUserRobloxURL" href="http://mulrbx.com/User.php?id=<?php echo $userid; ?>">http://mulrbx.com/User.php?id=<?php echo $userid; ?></a></span><br>
                        
                    </div>
                    <a id="ctl00_cphRoblox_rbxUserPane_AvatarImage" disabled="disabled" title="<?php echo $username; ?>" onclick="return false" style="display:inline-block;height:150px;width:150px;"><img src="http://mulrbx.com/Tools/Asset.ashx?id=<?php echo $userid; ?>&request=avatar" height="150" width="150" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="<?php echo $username; ?>"><img src="http://vrblxxd.ga/Images/UI/bconly.png" align="left" style="position:relative;top:-19px;"></a>
                    <br>
                    
                    

<div class="UserBlurb" style="margin-top: 10px; overflow-y: auto; max-height: 450px; ">
<?php echo $Results['status']; ?>
</div>
<div id="ProfileButtons" style="margin: 10px auto; width: 256px;">
    
                <a id="FriendButton" class="GrayButton Disabled">Send Friend Request</a>
            
    <div class="SendMessageProfileBtnDiv">
        
        <a data-js-supersafeprivacymode="" id="MessageButton" style="margin:0 5px" class="GrayButton " href="https://web.archive.org/web/20130423172215/http://roblox.com/My/PrivateMessage.aspx?RecipientID=1">Send Message</a>
    </div>
  
  <h2 class="title">
<span>MULTRBX Badges</span>
</h2>

<div class="divider-bottom" style="padding-bottom: 20px">
    <div style="display: inline-block">
      <table id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges" cellspacing="0" align="Left" border="0" style="border-collapse:collapse;">
  <tbody><tr>
    <td>
      
      <h2 class="title"><span>Player Badges</span></h2>
<div class="" style="min-height:300px;">
      
    <div id="ctl00_cphRoblox_rbxBadgesDisplay_BadgesUpdatePanel" class="BadgesUpdatePanel">
  
            <div class="BadgesLoading_Container"></div>
            <div class="BadgesListView_Container">
                
                         
                        
                    
                    
            </div>
      
      
      <h2 class="title"><span>Statistics</span></h2>

<div class="divider-bottom" style="padding-bottom: 20px">
<table class="statsTable">
    <tbody><tr>
        <td class="statsLabel">
        <acronym title="The number of this user&#39;s friends.">Friends</acronym>:
        </td>
        <td class="statsValue">
        <span id="ctl00_cphRoblox_rbxUserStatisticsPane_lFriendsStatistics">0</span>
        </td>
    </tr>
    
    <tr>
        <td class="statsLabel"><acronym title="The number of posts this user has made to the multrbx forum.">Forum Posts</acronym>:</td>
        <td class="statsValue"><span id="ctl00_cphRoblox_rbxUserStatisticsPane_lForumPostsStatistics" class="notranslate">0</span></td>
    </tr>
    <tr>
        <td class="statsLabel"><acronym title="The number of times this user&#39;s profile has been viewed.">Profile Views</acronym>:</td>
        <td class="statsValue"><span id="ctl00_cphRoblox_rbxUserStatisticsPane_lProfileViewsStatistics" class="notranslate">0</span></td>
    </tr>
    <tr>
        <td class="statsLabel"><acronym title="The number of times this user&#39;s place has been visited.">Place Visits</acronym>:</td>
        <td class="statsValue"><span id="ctl00_cphRoblox_rbxUserStatisticsPane_lPlaceVisitsStatistics" class="notranslate">0</span></td>
    </tr>
    <tr>
        <td class="statsLabel"><acronym title="The number of times this user&#39;s character has destroyed another user&#39;s character in-game.">Knockouts</acronym>:</td>
        <td class="statsValue"><span id="ctl00_cphRoblox_rbxUserStatisticsPane_lKillsStatistics" class="notranslate">0</span></td>
    </tr>
    
     <tr>
        <td class="statsLabel"><acronym title="The all-time highest voting accuracy this user has achieved when voting in contests.">Highest Ever Voting Accuracy</acronym>:</td>
        <td class="statsValue"><span id="ctl00_cphRoblox_rbxUserStatisticsPane_lHighestEverVotingAccuracyStatistics">0</span>%</td>
    </tr>
     
</tbody></table>    
</div>
            
            
          




             