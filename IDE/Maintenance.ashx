<?php include($_SERVER['DOCUMENT_ROOT'] . '/config.php'); ?>
<!DOCTYPE html>
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/Roblox.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/UnifiedModal.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/GenericModal.css' />
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
   <head>
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <title>
         Site Offline
      </title>
   <body>
      <div></div>
      <div></div>
      <div id="Container">
         <div id="SmallHeaderContainer" style="height: 50px; top:0px;">
            <div id="Banner" style="margin:0px;padding:0px;">
               <div class="BannerCenterContainer">
                  <a href="#" class="btn-logo"></a>
               </div>
            </div>
         </div>
         <div style="padding-top:40px;"></div>
         <div style="clear: both">
            <div id="Body">
               <p style="text-align: center">
                  &nbsp;
               </p>
               <p style="text-align: center">
                  <img src="<?php echo $baseUrl; ?>/Images/IDE/CurrentlyDown.jpg" id="ctl00_cphRoblox_imgRobloxTeam" alt="Offline">
               </p>
               <h3 style="text-align: center">
                  The site is currently offline for maintenance and upgrades. Please check back soon!
               </h3>
               <br>
               <br>
               <br>
               <br>
               <br>
               <br>
               <br>
               <p>
                  <input name="ctl00$cphRoblox$Textbox1" type="password" id="ctl00_cphRoblox_Textbox1">
                  <input type="submit" name="ctl00$cphRoblox$Button1" value="V" id="ctl00_cphRoblox_Button1">
                  <input type="submit" name="ctl00$cphRoblox$Button2" value="R" id="ctl00_cphRoblox_Button2">
                  <input type="submit" name="ctl00$cphRoblox$Button3" value="B" id="ctl00_cphRoblox_Button3">
                  <input type="submit" name="ctl00$cphRoblox$Button4" value="L" id="ctl00_cphRoblox_Button4">
                  <input type="submit" name="ctl00$cphRoblox$Button5" value="X" id="ctl00_cphRoblox_Button5">
               </p>
            </div>
            <?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/Footer.php'); ?>
         </div>
      </div>
   </body>
</html>