<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
include($_SERVER['DOCUMENT_ROOT'] . '/My/SettingsAPI/AccountUpdate.php');
appCheckRedirect("Profile");
switch(true){case ($RBXTICKET == null):die(header("Location: ". $baseUrl ."/"));break;}

 include($_SERVER['DOCUMENT_ROOT'] . '/js/IncludeJS.php');
  


  ?>
<!DOCTYPE html>
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/Roblox.css' />
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
         MULTRBX - real
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
               <?php
  $link = "mulrbx.com/uhhthisisnotthekeysystem68pointnineaaaax/create.php";
               
  
           echo'<h1> Your Referrals <h1>
                 <form action="'. $link .'">
   <input type="submit" value="Create Referral" />
</form>';
                 

