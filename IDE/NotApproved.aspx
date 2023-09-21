<?php 
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
include($_SERVER['DOCUMENT_ROOT'] . '/UserInfo.php'); 
switch(true){
	case ($termtype == null):
		header("Location: ". $baseUrl);
		die();
	break;
}
?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/js/IncludeJS.php'); ?>
<!DOCTYPE html>
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/Roblox.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/UnifiedModal.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/GenericModal.css' />
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
   <head>
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <title>
         Account Deleted
      </title>
   <body>
      <div></div>
      <div></div>
      <div id="Container">
	  <?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/ContextHeader.php');  ?>
         <div style="padding-top:40px;"></div>
         <div style="clear: both">
            <div id="Body">
			<?php
			switch ($termtype){
				case "terminated":
						echo "
					<div style='border: solid 1px #000; margin: 0 auto; padding: 30px; max-width: 500px;'>
					   <h2 style='text-align: center;'>Account Deleted</h2>
					   <p>Our content monitors have determined that your behavior at Roblox has been in violation of our Terms of Service.
					   </p>
					   <p>Reviewed: <span style='font-weight: bold'>". $termdate ."</span></p>
					   <div id='ctl00_cphRoblox_ModeratorNotePanel'>
						  <p>Moderator Note: <span style='font-weight: bold'><span id='ctl00_cphRoblox_Label4' mode='Encode'>". $termnote ."</span></span></p>
					   </div>
					   <p>
					   </p>
					   <div style='background-color: #fff; border: solid 1px #000; margin-bottom: 5px; padding: 10px; width: 478px'>
						  <div style='margin-bottom: 5px;'><strong>Reason:</strong> ". $termreason ."</div>
					   </div>
					   <p></p>
					   <p>Please abide by the <a href='". $baseUrl ."/Info/Community-Guidelines'>Roblox Community Guidelines</a> so that Roblox can be fun for users of all ages.</p>
					   <div id='ctl00_cphRoblox_Panel7Days'>
						  <p>Your account has been terminated.<br></p>
					   </div>
					   <p>If you wish to appeal, please contact us via the <a href='". $baseUrl ."/Moderation/Appeal.aspx'>Support Form</a>.</p>
					   <p style='text-align: center;'>
						  <a href='". $baseUrl ."/Login/Logout.ashx?returnUrl=/'><button name='ctl00' value='Logout' id='ctl00_cphRoblox_LogoutButton' class='translate'>Logout</button></a>
					   </p>
					</div>";
					break;
				case "banned":
						echo "
					<div style='border: solid 1px #000; margin: 0 auto; padding: 30px; max-width: 500px;'>
					   <h2 style='text-align: center;'>Account Banned</h2>
					   <p>Our content monitors have determined that your behavior at Roblox has been in violation of our Terms of Service.
						  We will terminate your account if you do not abide by the rules.
					   </p>
					   <p>Reviewed: <span style='font-weight: bold'>". $termdate ."</span></p>
					   <div id='ctl00_cphRoblox_ModeratorNotePanel'>
						  <p>Moderator Note: <span style='font-weight: bold'><span id='ctl00_cphRoblox_Label4' mode='Encode'>". $termnote ."</span></span></p>
					   </div>
					   <p>
					   </p>
					   <div style='background-color: #fff; border: solid 1px #000; margin-bottom: 5px; padding: 10px; width: 478px'>
						  <div style='margin-bottom: 5px;'><strong>Reason:</strong> ". $termreason ."</div>
					   </div>
					   <p></p>
					   <p>Please abide by the <a href='". $baseUrl ."/Info/Community-Guidelines'>Roblox Community Guidelines</a> so that Roblox can be fun for users of all ages.</p>
					   <div id='ctl00_cphRoblox_Panel7Days'>
						  <p>You may reactivate your account after 7 days.<br></p>
					   </div>
					   <p>If you wish to appeal, please contact us via the <a href='". $baseUrl ."/Moderation/Appeal.aspx'>Support Form</a>.</p>
					   <p style='text-align: center;'>
						  <a href='". $baseUrl ."/Login/Logout.ashx?returnUrl=/'><button name='ctl00' value='Logout' id='ctl00_cphRoblox_LogoutButton' class='translate'>Logout</button></a>
					   </p>
					</div>";
					break;
			}
			?>
			</div>
            </div>
            <?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/Footer.php'); ?>
         </div>
      </div>
   </body>
</html>