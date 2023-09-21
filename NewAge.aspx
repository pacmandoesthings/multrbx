<?php 


include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
include($_SERVER['DOCUMENT_ROOT'] . '/UserInfo.php');
include($_SERVER['DOCUMENT_ROOT'] . '/ProdLogin.php');
$refer = $_GET['refer'] ?? null;
if (!isset($refer) || empty($refer) || $refer == null) {
  die("you need a invite key get one on the discord verification<br><a href='https://discord.gg/pXe6WVHCFU'>Discord server</a>");
} else{
$referstmt = $MainDB->prepare("SELECT * FROM refkeys WHERE refkey = :urmomfat");
$referstmt->bindParam(":urmomfat", $refer, PDO::PARAM_STR);
$referstmt->execute();
$referkeyxdorsomething = $referstmt->fetch(PDO::FETCH_ASSOC);
$q = $referstmt->rowCount();
if ($q == 0 || $q < 1) {
die("Referral key doesnt exist.");
}
$referstmt2 = $MainDB->prepare("SELECT used FROM refkeys WHERE refkey = :urmomfat");
$referstmt2->bindParam(":urmomfat", $refer, PDO::PARAM_STR);
$referstmt2->execute();
$referkeyxdorsomething2 = $referstmt2->fetch(PDO::FETCH_ASSOC);

$q4= $MainDB->prepare("SELECT used FROM refkeys WHERE refkey=?");
$q4->execute([$refer]);
$used = $q4->fetchColumn();









if ($used == 1 || $used > 1) {
die("Referral key is used.");
}
}
$NameErrors = null;
$PassSHOW = null;
$EmailSHOW = null;
$KeySHOW = null;
switch(true){
	case ($RBXTICKET !== null):
		header("Location: ". $baseUrl ."/");
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
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Games/Games.css' />
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
   <head>
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <title>
         MULTRBX - Welcome
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
				  <div id="Body" style="">
					 <div class="SignupWrapper">
						<div class="title">
						   <h1>Sign up to build &amp; make friends</h1>
						</div>
						<form method="POST" action="<?php echo $CurrPage; ?>">
						<div class="SignupBox divider-right">
						   <div class="formRow">
							  <label class="form-label" for="username">Desired Username:</label>
							  <div class="rightFormColumn">
								 <div class="inputColumn">
									<input name="username" type="text" id="username" tabindex="6" class="text-box text-box-large">
								 </div>
<?php
switch(true){
	case(count($UserErrors) > 0):
		foreach($UserErrors as $Info){
			$NameErrors = $NameErrors . $Info;
		}
			echo '<div class="validation">
	<table id="UsernameError" class="validator-container" style="display: block;">
		<tbody>
			<tr>
				<td>
					<div class="validator-tooltip-top"></div>
						<div class="validator-tooltip-main">
						<div id="usernameErrorMessage">'. $NameErrors .'</div>
					</div>
					<div class="validator-tooltip-bottom"></div>
				</td>
			</tr>
		</tbody>
	</table>
</div>';
		break;
}
?>
								 <div class="clear" style="font-size:0;"></div>
								 <span class="tip-text">3-20 alphanumeric characters, no spaces</span>
							  </div>
						   </div>
						   <div class="formRow">
							  <label class="form-label" for="password1">Password:</label>
							  <div class="rightFormColumn">
								 <div class="inputColumn">
									<input name="password" value="" id="password" class="text-box text-box-large" tabindex="7" type="password">
								 </div>
<?php
switch(true){
	case(count($PassErrors) > 0):
		foreach($PassErrors as $Info){
			$PassSHOW = $PassSHOW . $Info;
		}
			echo '<div class="validation">
	<table id="UsernameError" class="validator-container" style="display: block;">
		<tbody>
			<tr>
				<td>
					<div class="validator-tooltip-top"></div>
						<div class="validator-tooltip-main">
						<div id="usernameErrorMessage">'. $PassSHOW .'</div>
					</div>
					<div class="validator-tooltip-bottom"></div>
				</td>
			</tr>
		</tbody>
	</table>
</div>';
		break;
}
?>
								 <div class="clear" style="font-size:0;"></div>
								 <span class="tip-text">6-20 characters, minimum of 4 letters &amp; 2 numbers</span>
							  </div>
						   </div>
						   <div class="formRow">
							  <label class="form-label" for="password2">Confirm Password:</label>
							  <div class="inputColumn">
								 <input name="passwordcheck" value="" id="passwordcheck" class="text-box text-box-large" tabindex="8" type="password">
							  </div>
							  <div class="validation">
								 <table id="passwordConfirmError" class="validator-container">
									<tbody>
									   <tr>
										  <td>
											 <div class="validator-tooltip-top"></div>
											 <div class="validator-tooltip-main">
												<div id="PasswordConfirmMessage"></div>
											 </div>
											 <div class="validator-tooltip-bottom"></div>
										  </td>
									   </tr>
									</tbody>
								 </table>
								 <div id="passwordConfirmGood" class="validator-checkmark"></div>
							  </div>
						   </div>
						   <div class="formRow">
							  <label class="form-label" for="email">Email:</label>
							  <div class="rightFormColumn">
								 <div class="inputColumn">
									<input name="email" value="" id="email" class="text-box text-box-large" tabindex="7" type="text">
								 </div>
<?php
switch(true){
	case(count($EmailErrors) > 0):
		foreach($EmailErrors as $Info){
			$EmailSHOW = $EmailSHOW . $Info;
		}
			echo '<div class="validation">
	<table id="UsernameError" class="validator-container" style="display: block;">
		<tbody>
			<tr>
				<td>
					<div class="validator-tooltip-top"></div>
						<div class="validator-tooltip-main">
						<div id="usernameErrorMessage">'. $EmailSHOW .'</div>
					</div>
					<div class="validator-tooltip-bottom"></div>
				</td>
			</tr>
		</tbody>
	</table>
</div> ';
		break;
}
?>
							 

								 <div class="clear" style="font-size:0;"></div>
								 <span class="tip-text">We use this for password recovery and other services.</span>
							  </div>
						   </div>
						   <div class="clear" style="font-size:0;"></div>
						   <div class="CreateAccountWrapper" style="text-align:center">
							  <button type="submit" name="registerrbx" id="registerrbx" data-se="SignUpButton" style="height: 50px;" class="btn-large btn-primary">
							  Sign Up
							  <span class="btn-text">
							  Sign Up
							  </span>
							  <br></br>
							  </button>
						   </div>
						   <script type="text/javascript">
							  $(function () {
							  
								  //<sl:translate>
								  Roblox.SignupFormValidator.Resources = {
								  doesntMatch : "Doesn't match",
								  requiredField : "Required field",
								  tooLong : "Too long",
								  tooShort : "Too short",
								  containsInvalidCharacters : "Contains invalid characters",
								  needsFourLetters : "Needs 4 letters",
								  needsTwoNumbers : "Needs 2 numbers",
								  noSpaces : "No spaces allowed",
								  weakKey : "Weak key combination.",
								  invalidName : "Can't be your character name",
								  alreadyTaken : "Already taken",
								  cantBeUsed : "Can't be used",
								  password : "password"
                                                                  refer : "refer"
								  };
								  //</sl:translate>
							  });
						   </script>       
						</div>
						</form>
						<div class="UpperRightBox divider-bottom">
						   <span style="margin-top: 5px;float: left;">Already registered?</span> 
						   <a href="<?php echo $baseUrl; ?>/" class="btn-small btn-negative" style="margin-left:5px;">Login<span class="btn-text">Login</span></a>
						</div>
						<div class="LowerRightBox">
						   <span>Terms and Conditions</span>
						   <div class="Termsandconditions">
							  By clicking Sign Up, you agree to our <a id="ctl00_cphRoblox_HyperLinkToS" href="/web/20130420143209/https://www.roblox.com/info/terms-of-service" target="_blank">Terms of Service</a>, <a id="ctl00_cphRoblox_HyperLinkEULA" href="/web/20130420143209/https://www.roblox.com/Info/EULA.htm" target="_blank">Licensing Agreement</a>, and <a id="ctl00_cphRoblox_HyperLinkPrivacy" href="/web/20130420143209/https://www.roblox.com/Info/Privacy.aspx?layout=null" target="_blank">Privacy Policy</a>. We will not share your information with 3rd parties. 
						   </div>
						</div>
					 </div>
					 <div style="clear:both"></div>
				  </div>
			   </div>
			</div>
			<?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/Footer.php'); ?>
         </div>
      </div>
   </body>
</html>