<?php 
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/My/SettingsAPI/AccountUpdate.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
switch(true){
	case ($RBXTICKET == null):
		header("Location: ". $baseUrl ."/");
		die();
		break;
}

switch(true){
	case ($robux > 2138127391273812379812):
		$PurchaseUsername = "UsernamePurchase()";
		break;
	case(2138127391273812379812 > $robux):
		$PurchaseUsername = "NotEnough()";
		break;
	case($robux = 2138127391273812379812):
		$PurchaseUsername = "UsernamePurchase()";
		break;
}
$wasterobux = $robux - 2138127391273812379812;
include($_SERVER['DOCUMENT_ROOT'] . '/js/IncludeJS.php'); 
?>
<!DOCTYPE html>
<?php 
if ($theme !== 1) {
echo "<link rel='stylesheet' href='$baseUrl/CSS/Base/CSS/Roblox.css' />";
}
?>
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Accounts/AccountMVC.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/UnifiedModal.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/GenericModal.css' />
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
   <head>
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <title>
         MULTRBX - Settings
      </title>
   <body>
      <div></div>
      <div></div>
      <div id="Container">
         <?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/ContextHeader.php');  ?>
         <div style="padding-top:40px;"></div>
         <div style="clear: both">
			<div id="BodyWrapper">
			<div id="RepositionBody">
			   <div id="Body" class="" style="width:970px">
								<?php
								switch(true){
									case (count($errors) > 0):
										foreach ($errors as $error){
											echo '<div id="AccountPageContainer" data-missingparentemail="false" data-userabove13="true" data-currentdateyear="" data-currentdatemonth="" data-currentdateday=""><div id="ctl00_Announcement"><div id="ctl00_SystemAlertDiv" class="SystemAlert"><div id="ctl00_SystemAlertTextColor" class="SystemAlertText"><div id="ctl00_LabelAnnouncement">'. $error .'</div></div></div></div>';
										}
										break;
								}
								switch($success){
									case "1":
										echo '<div id="AccountPageContainer" data-missingparentemail="false" data-userabove13="true" data-currentdateyear="" data-currentdatemonth="" data-currentdateday=""><div id="ctl00_Announcement"><div id="ctl00_SystemAlertDiv" class="SystemAlert" style="background-color:steelblue"><div id="ctl00_SystemAlertTextColor" style="background-color:steelblue" class="SystemAlertText"><div id="ctl00_LabelAnnouncement">Settings saved.</div></div></div></div>';
										break;
								}
								?>
					 <div id="AccountPageLeft" class="divider-right">
						<p><h1>My Account</h1></p>
						<form action="<?php echo $CurrPage; ?>" method="POST">
						   <div class="tab-container">
							  <div class="tab active tab-active" data-id="settings_tab">Settings</div>
						   </div>
						   <div class="tab-content active" id="settings_tab" style="display: block;">
							  <div id="AccountSettings" class="settings-section">
								 <div class="SettingSubTitle" id="UsernameSetting" data-email-verified="True" data-alerturl="https://s3.amazonaws.com/images.roblox.com/cbb24e0c0f1fb97381a065bd1e056fcb.png" data-change-username-verifyurl="/account/username/verifyupdate" data-change-username-url="/account/username/update" data-buy-robux-url="/upgrades/robux">
									<span class="settingLabel form-label">Username:</span> <span id="username"><?php echo $name; ?></span>
									<a id="changeNameLink" onclick="<?php echo $PurchaseUsername; ?>" class="changeUsername btn-control btn-control-small">
									Change Username</a>
								 </div>
								 <div id="PasswordSetting" class="SettingSubTitle">
									<span class="settingLabel form-label">Password:</span> <span id="securePassword">*********</span>
									<a id="changePassLink" class="changePassWord btn-control btn-control-small" onclick="ChangePassword()">
									Change Password</a>
								 </div>
								 <div id="EmailAddressSetting" class="SettingSubTitle">
									<span id="emailAddressLabel" class="settingLabel form-label">Email address:</span>
									<div id="emailBlock">
									   <span id="UserEmail"><?php echo $email; ?></span>
									   <?php
									   switch($verified){
										   case "1":
												echo '<span id="EmailVerificationStatus" class="verifiedEmail"></span>';
												break;
									   }
									   ?>
									<a id="changeEmailBtn" onclick="MagicLoadBox()" class="changeEmail btn-control btn-control-small">
									Change Email</a>
									</div>
								 </div>
								 <div id="PersonalBlurbSetting" class="SettingSubTitle">
									<span class="settingLabel form-label">Personal blurb:</span>
									<div id="BlurbDesc">
									   <textarea class="roblox-blurb-default-text accountPageChangeMonitor text blurbGreyText valid" cols="20" data-val="true" data-val-length="The field Personal Blurb must be a string with a maximum length of 1000." data-val-length-max="1000" id="blurbText" name="blurbText" rows="2" placeholder="Describe yourself here."></textarea>
									   <br>
									   <div id="blurbSubtext" class="footnote">
										  Do not provide any details that can be used to identify you outside of MULTRBX.
										  <span class="footnote"><br>(1000 character limit)</span>
									   </div>
									</div>
								 </div>
							  </div>
							  <p></p>
							  <button class="btn-medium btn-neutral updateSettingsBtn btn-update btn-neutral btn-medium" name="UpdateBlurb" id="UpdateBlurb">Update<span class="btn-text">Update</span></button>
						   </div>
						</form>
					 </div>
					 <div id="AccountPageRight">
						<div id="UpgradeAccount" style="margin-left: 10px">
						 
						   <div id="AdvertisementRight">
							  <div style="margin-top: 10px">
								 <iframe allowtransparency="true" frameborder="0" height="270" scrolling="no" src="<?php echo $baseUrl; ?>/Tools/Asset.ashx?request=advertisement&adtype=block&id=0" width="300" data-js-adtype="iframead"></iframe>
							  </div>
						   </div>
						</div>
						<div style="clear: both"></div>
					 </div>
				  </div>
				  <div class="GenericModal modalPopup unifiedModal smallModal" style="display:none;">
					 <div class="Title"></div>
					 <div class="GenericModalBody">
						<div>
						   <div class="ImageContainer">
							  <img class="GenericModalImage" alt="generic image">
						   </div>
						   <div class="Message"></div>
						</div>
						<div class="clear"></div>
						<div id="GenericModalButtonContainer" class="GenericModalButtonContainer">
						   <a class="ImageButton btn-neutral btn-large roblox-ok">OK<span class="btn-text">OK</span></a>
						</div>
					 </div>
				  </div>
				  <style type="text/css">
					 #Body  /*Needs to be on the Page to override MasterPage #Body */
					 {
					 width:970px;
					 padding:10px;
					 }
				  </style>
						<pre id="EpicMagic"></pre>
						<div class="clear"></div>
						<script type='text/javascript'>
							function MagicLoadBox(){
								showheight = $(document).height();
								showwidth = $(document).width();
								MagicBox = document.getElementById('EpicMagic');
							MagicBox.innerHTML='<div id="simplemodal-overlay" class="simplemodal-overlay" style="background-color: rgb(0, 0, 0); opacity: 0.8; height: '+showheight+'px; width: '+showwidth+'px; position: fixed; left: 0px; top: 0px; z-index: 1001;"></div><div id="simplemodal-container" class="simplemodal-container" style="position: absolute;left: 50%;top: 50%;transform: translate(-50%, -50%);z-index: 1002;"><form method="POST" action="<?php echo $CurrPage; ?>"><div id="AddEmailScreenModal" style="display:block;" class="PurchaseModal simplemodal-data" data-uid="59896360"><div id="CloseAddEmailScreen" class="simplemodal-close"><a id="closeEmailModal" onclick="MagicGoneBox()" runat="server" class="ImageButton closeBtnCircle_20h"></a></div><div id="changeEmailTitle" class="titleBar">Change Email Address</div><div id="updateEmailBody"><div id="AddEmailDialog"><p><b>You will have to verify your email again.</b></p><p><label>Email Address: </label><input class="text" name="email" type="text" id="email"></p><p></p><div id="SubmitEmailButton"><input id="SubmitInfoButton" type="submit" value="Update" id="emailupd" name="emailupd" class="btn-medium btn-neutral"></input> <input id="CancelInfoButton" onclick="MagicGoneBox()" type="button" value="Cancel" class="btn-cancel-m btn-negative btn-medium"></input><p></p></div></div></div></div></div></form>';
							}
							
							function UsernamePurchase(){
								showheight = $(document).height();
								showwidth = $(document).width();
								MagicBox = document.getElementById('EpicMagic');
							MagicBox.innerHTML='<div id="simplemodal-overlay" class="simplemodal-overlay" style="background-color: rgb(0, 0, 0); opacity: 0.8; height: '+showheight+'px; width: '+showwidth+'px; position: fixed; left: 0px; top: 0px; z-index: 1001;"></div><div id="simplemodal-container" class="simplemodal-container" style="position: absolute;left: 50%;top: 50%;transform: translate(-50%, -50%);z-index: 1002;"><a class="modalCloseImg simplemodal-close" title="Close"></a><div tabindex="-1" class="simplemodal-wrap" style="height: 100%; outline: 0px; width: 100%; overflow: visible;"><div class="ConfirmationModal modalPopup unifiedModal smallModal simplemodal-data" data-modal-handle="confirmation" style="height:279px;" id="simplemodal-data"><a class="genericmodal-close ImageButton closeBtnCircle_20h" style="display: none;"></a><form method="POST" action="<?php echo $CurrPage; ?>"><div class="Title">Buy New Username</div><div class="GenericModalBody"><div style="font-size:20px" class="TopBody">Would you like to purchase a new username for <span class="currency CurrencyColor1">100</span>?<p><label>New Username: </label><input class="text" name="newname" type="newname" id="newname"></p><p></p></div><div class="ConfirmationModalButtonContainer"><button style="height: 50px;" type="submit" id="changename" name="changename" class="btn-large btn-primary">Buy Now<span class="btn-text">Buy Now</span></button>  <button style="height: 50px;" onclick="MagicGoneBox()" class="btn-large btn-negative">Cancel<span class="btn-text">Cancel</span></button></div><div class="ConfirmationModalFooter">Your balance after this transaction will be <?php echo $wasterobux; ?>.</div></form></div></div></div></div>';
							}
							
							function NotEnough(){
								showheight = $(document).height();
								showwidth = $(document).width();
								MagicBox = document.getElementById('EpicMagic');3
							MagicBox.innerHTML='<div id="simplemodal-overlay" class="simplemodal-overlay" style="background-color: rgb(0, 0, 0); opacity: 0.8; height: '+showheight+'px; width: '+showwidth+'px; position: fixed; left: 0px; top: 0px; z-index: 1001;"></div><div id="simplemodal-container" class="simplemodal-container" style="position: absolute;left: 50%;top: 50%;transform: translate(-50%, -50%);z-index: 1002;"><a class="modalCloseImg simplemodal-close" title="Close"></a><div tabindex="-1" class="simplemodal-wrap" style="height: 100%; outline: 0px; width: 100%; overflow: visible;"><div class="ConfirmationModal modalPopup unifiedModal smallModal simplemodal-data" data-modal-handle="confirmation" style="" id="simplemodal-data"><a class="genericmodal-close ImageButton closeBtnCircle_20h" style="display: none;"></a><div class="Title">Insufficient Funds</div><div class="GenericModalBody"><div style="font-size:20px" class="TopBody">You need <span class="currency CurrencyColor1">2138127391273812379812</span> to purchase a new username.</div><div class="ConfirmationModalButtonContainer"><a onclick="MagicGoneBox()" class="btn-large btn-negative">Cancel<span class="btn-text">Cancel</span></a></div><div</div></div></div></div>';
							}
							
							function ChangePassword(){
								showheight = $(document).height();
								showwidth = $(document).width();
								MagicBox = document.getElementById('EpicMagic');
							MagicBox.innerHTML='<div id="simplemodal-overlay" class="simplemodal-overlay" style="background-color: rgb(0, 0, 0); opacity: 0.8; height: '+showheight+'px; width: '+showwidth+'px; position: fixed; left: 0px; top: 0px; z-index: 1001;"></div><div id="simplemodal-container" class="simplemodal-container" style="position: absolute;left: 50%;top: 50%;transform: translate(-50%, -50%);z-index: 1002;"><form action="<?php echo $CurrPage; ?>" method="POST"><div id="AddEmailScreenModal" style="display:block;" class="PurchaseModal simplemodal-data" data-uid="59896360"><div id="CloseAddEmailScreen" class="simplemodal-close"><a id="closeEmailModal" onclick="MagicGoneBox()" runat="server" class="ImageButton closeBtnCircle_20h"></a></div><div id="changeEmailTitle" class="titleBar">Change Password</div><div id="updateEmailBody"><div id="AddEmailDialog"><p><b>If you forgot your password, <a href="<?php echo $baseUrl; ?>/My/PasswordRecovery.aspx">click here</a>.</b></p><p><label>Old Password: </label><input class="translate text-box text-box-large status-textbox" name="oldpass" type="password" id="oldpass"></p><p><label>New Password: </label><input class="translate text-box text-box-large status-textbox" name="newpass" type="password" id="newpass"></p><p></p><div id="SubmitEmailButton"><input id="SubmitInfoButton" type="submit" value="Update" name="passupd" class="btn-medium btn-neutral"> <input id="CancelInfoButton" onclick="MagicGoneBox()" type="button" value="Cancel" class="btn-cancel-m btn-negative btn-medium"><p></p></div></div></div></div></form></div>';
							}
							
							function MagicGoneBox(){
								MagicBox = document.getElementById('EpicMagic');
								MagicBox.innerHTML='';
							}
						</script>
			   </div>
			</div>
			<?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/Footer.php'); ?>
         </div>
      </div>
   </body>
</html>