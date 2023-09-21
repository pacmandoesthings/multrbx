<?php include($_SERVER['DOCUMENT_ROOT'] . '/config.php'); ?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/UserInfo.php'); ?>
<?php
$Error = (int)($_GET['Err'] ?? die(header('Location: '. $baseUrl .'/')));

switch($Error){
	case "1":
		$ErrorMsg = "LoadAlreadyPurchased()";
		break;
	case "2":
		$ErrorMsg = "LoadNotEnough()";
		break;
	case "3":
		$ErrorMsg = "LoadCompleted()";
		break;
	case "4":
		$ErrorMsg = "NotLoggedIn()";
		break;
	case "5":
		$ErrorMsg = "RegularError()";
		break;
	case "6":
		$ErrorMsg = "Done()";
		break;
	default:
		die(header('Location: '. $baseUrl .'/'));
		break;
}
?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/js/IncludeJS.php'); ?>
<!DOCTYPE html>
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/Roblox.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Accounts/AccountMVC.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/UnifiedModal.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/GenericModal.css' />
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
   <head>
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <title>
         MULTRBX
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
				  <script type="text/javascript" src="<?php echo $baseUrl; ?>/js/jquery.validate.js"></script>
				  <script type="text/javascript" src="<?php echo $baseUrl; ?>/js/jquery.validate.unobtrusive.js"></script>
				  <script type="text/javascript" src="<?php echo $baseUrl; ?>/Services/Secure/AddParentEmail.js"></script>
				  <script type="text/javascript" src="<?php echo $baseUrl; ?>/js/SignupFormValidator.js"></script>
				  <script type="text/javascript" src="<?php echo $baseUrl; ?>/js/My/AccountMVC.js"></script>
				  <script type="text/javascript" src="<?php echo $baseUrl; ?>/js/AddEmail.js"></script>
				  <script type="text/javascript" src="<?php echo $baseUrl; ?>/js/SuperSafePrivacyIndicator.js"></script>
						<pre id="EpicMagic"></pre>
						<div class="clear"></div>
						<script type='text/javascript'>
							function LoadNotEnough(){
								showheight = $(document).height();
								showwidth = $(document).width();
								MagicBox = document.getElementById('EpicMagic');
							MagicBox.innerHTML='<div id="simplemodal-overlay" class="simplemodal-overlay" style="background-color: rgb(0, 0, 0); opacity: 0.8; height: '+showheight+'px; width: '+showwidth+'px; position: fixed; left: 0px; top: 0px; z-index: 1001;"></div><div id="simplemodal-container" class="simplemodal-container" style="position: absolute;left: 50%;top: 50%;transform: translate(-50%, -50%);z-index: 1002;"><div class="GenericModal modalPopup unifiedModal smallModal simplemodal-data" style="" id="simplemodal-data"><div class="Title">Insufficient Funds</div><div class="GenericModalBody"><div><div class="ImageContainer"><img class="GenericModalImage" alt="generic image" src="/images/Icons/img-alert.png"></div><div class="Message">You dont have enough Funds!</div></div><div class="clear"></div><div id="GenericModalButtonContainer" class="GenericModalButtonContainer"><a href="<?php echo $baseUrl; ?>" class="btn-large btn-neutral">OK<span class="btn-text">OK</span></a></div></div></div></div>';
							}
							
							function LoadAlreadyPurchased(){
								showheight = $(document).height();
								showwidth = $(document).width();
								MagicBox = document.getElementById('EpicMagic');
							MagicBox.innerHTML='<div id="simplemodal-overlay" class="simplemodal-overlay" style="background-color: rgb(0, 0, 0); opacity: 0.8; height: '+showheight+'px; width: '+showwidth+'px; position: fixed; left: 0px; top: 0px; z-index: 1001;"></div><div id="simplemodal-container" class="simplemodal-container" style="position: absolute;left: 50%;top: 50%;transform: translate(-50%, -50%);z-index: 1002;"><div class="GenericModal modalPopup unifiedModal smallModal simplemodal-data" style="" id="simplemodal-data"><div class="Title">Already Purchased</div><div class="GenericModalBody"><div><div class="ImageContainer"><img class="GenericModalImage" alt="generic image" src="/images/Icons/img-alert.png"></div><div class="Message">You cannot purchase items twice.</div></div><div class="clear"></div><div id="GenericModalButtonContainer" class="GenericModalButtonContainer"><a href="<?php echo $baseUrl; ?>" class="btn-large btn-neutral">OK<span class="btn-text">OK</span></a></div></div></div></div>';
							}
							
							function LoadCompleted(){
								showheight = $(document).height();
								showwidth = $(document).width();
								MagicBox = document.getElementById('EpicMagic');
							MagicBox.innerHTML='<div id="simplemodal-overlay" class="simplemodal-overlay" style="background-color: rgb(0, 0, 0); opacity: 0.8; height: '+showheight+'px; width: '+showwidth+'px; position: fixed; left: 0px; top: 0px; z-index: 1001;"></div><div id="simplemodal-container" class="simplemodal-container" style="position: absolute;left: 50%;top: 50%;transform: translate(-50%, -50%);z-index: 1002;"><div class="GenericModal modalPopup unifiedModal smallModal simplemodal-data" style="" id="simplemodal-data"><div class="Title">Purchase Complete</div><div class="GenericModalBody"><div><p>Your purchase has been completed sucessfully.</p></div><div class="clear"></div><div id="GenericModalButtonContainer" class="GenericModalButtonContainer"><a href="<?php echo $baseUrl; ?>" class="btn-large btn-neutral">Go Home</a><a href="<?php echo $baseUrl; ?>/Catalog" class="btn-large btn-neutral">Keep Shopping</a</div></div></div></div>';
							}
							
							function NotLoggedIn(){
								showheight = $(document).height();
								showwidth = $(document).width();
								MagicBox = document.getElementById('EpicMagic');
								MagicBox.innerHTML='<div id="simplemodal-overlay" class="simplemodal-overlay" style="background-color: rgb(0, 0, 0); opacity: 0.8; height: '+showheight+'px; width: '+showwidth+'px; position: fixed; left: 0px; top: 0px; z-index: 1001;"></div><div id="simplemodal-container" class="simplemodal-container" style="position: absolute;left: 50%;top: 50%;transform: translate(-50%, -50%);z-index: 1002;"><div class="GenericModal modalPopup unifiedModal smallModal simplemodal-data" style="" id="simplemodal-data"><div class="Title">Not Logged In</div><div class="GenericModalBody"><div><div class="ImageContainer"><img class="GenericModalImage" alt="generic image" src="/images/Icons/img-alert.png"></div><div class="Message">You need to be logged in to purchase items!</div></div><div class="clear"></div><div id="GenericModalButtonContainer" class="GenericModalButtonContainer"><a href="<?php echo $baseUrl; ?>" class="btn-large btn-neutral">OK<span class="btn-text">OK</span></a></div></div></div></div>';
							}
							
							function RegularError(){
								showheight = $(document).height();
								showwidth = $(document).width();
								MagicBox = document.getElementById('EpicMagic');
								MagicBox.innerHTML='<div id="simplemodal-overlay" class="simplemodal-overlay" style="background-color: rgb(0, 0, 0); opacity: 0.8; height: '+showheight+'px; width: '+showwidth+'px; position: fixed; left: 0px; top: 0px; z-index: 1001;"></div><div id="simplemodal-container" class="simplemodal-container" style="position: absolute;left: 50%;top: 50%;transform: translate(-50%, -50%);z-index: 1002;"><div class="GenericModal modalPopup unifiedModal smallModal simplemodal-data" style="" id="simplemodal-data"><div class="Title">Error</div><div class="GenericModalBody"><div><div class="ImageContainer"><img class="GenericModalImage" alt="generic image" src="/images/Icons/img-alert.png"></div><div class="Message">Something went wrong.</div></div><div class="clear"></div><div id="GenericModalButtonContainer" class="GenericModalButtonContainer"><a href="<?php echo $baseUrl; ?>" class="btn-large btn-neutral">OK<span class="btn-text">OK</span></a></div></div></div></div>';
							}
							
							function Done(){
								showheight = $(document).height();
								showwidth = $(document).width();
								MagicBox = document.getElementById('EpicMagic');
							MagicBox.innerHTML='<div id="simplemodal-overlay" class="simplemodal-overlay" style="background-color: rgb(0, 0, 0); opacity: 0.8; height: '+showheight+'px; width: '+showwidth+'px; position: fixed; left: 0px; top: 0px; z-index: 1001;"></div><div id="simplemodal-container" class="simplemodal-container" style="position: absolute;left: 50%;top: 50%;transform: translate(-50%, -50%);z-index: 1002;"><div class="GenericModal modalPopup unifiedModal smallModal simplemodal-data" style="" id="simplemodal-data"><div class="Title">Done</div><div class="GenericModalBody"><div><p>Task has been done successfully.</p></div><div class="clear"></div><div id="GenericModalButtonContainer" class="GenericModalButtonContainer"><a href="<?php echo $baseUrl; ?>" class="btn-large btn-neutral">Go Home<span class="btn-text">Go Home</span></a></div></div></div></div>';
							}
							
							window.onload = <?php echo $ErrorMsg; ?>;
						</script>
			   </div>
			</div>
			<?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/Footer.php'); ?>
         </div>
      </div>
   </body>
					  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
  <style>
    .big {
      font-size: 60px;
    }

    .card-main {
      margin: 100px;
    }

    .card-blurb {
      display: flex;
      margin-left: 100px;
      margin-top: 400px;
    }

    .card-feed {
      margin-left: 450px;
      margin-top: -687px;
    }

    .feed-message-avatar {
      width: 80px;
    }
  </style>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
</html>
</html>
