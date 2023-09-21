<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php'); ?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/ProdLogin.php'); ?>
<?php
$loginRedirect = 1;
switch($loginRedirect){
	case 1:
		switch(true){
			case ($RBXTICKET !== null):
			echo "<script type='text/javascript'>window.parent.location.reload()</script>";
			break;
		}
		break;
	default:
		die(json_encode(["message" => "Cannot process this request right now, try again later."]));
		break;
}
?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
   <head>
      <title>
         MULTRBX Login
      </title>
      <link rel="stylesheet" href="/CSS/YUIReset.css" />
      <script type='text/javascript' src='//ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.2.min.js'></script>
      <script type='text/javascript'>window.jQuery || document.write("<script type='text/javascript' src='/js/jquery/jquery-1.7.2.min.js'><\/script>")</script>
      <script type='text/javascript' src='//ajax.aspnetcdn.com/ajax/4.0/1/MicrosoftAjax.js'></script>
      <script type='text/javascript'>window.Sys || document.write("<script type='text/javascript' src='/js/Microsoft/MicrosoftAjax.js'><\/script>")</script>
   </head>
   <body style="background: #E1E1E1;" data-parent-url="">
      <div id="NotLoggedInPanel">
         <form method="POST" action="<?php echo $CurrPage; ?>">
            <div id="LoginForm">
               <div class="newLogin" id="newLoginContainer">
                  <div class="UserNameDiv">
                     <label class="form-label" for="UserName">Username</label>
                     <br /><input name="username" type="text" id="username" class="text-box text-box-medium LoginFormInput" name="username" style="width: 144px;" />
                  </div>
                  <div class="PasswordDiv">
                     <label class="form-label" for="Password">Password</label>
                     <br /><input name="password" type="password" id="password" class="text-box text-box-medium LoginFormInput" style="width:152px;" />
                  </div>
                  <div style="clear:both"></div>
                  <div id="iFrameCaptchaControl"></div>
					<?php
					switch(true){
						case (count($errors) > 0):
							foreach ($errors as $error){
								echo "<div id='ErrorMessage' style='color:Red'>". $error ."</div>";
							}
							break;
					}
					?>
                  <div class="LoginFormFieldSet">
                     <span id="NotAMemberLink" class="footnote" style="position: absolute;top: 50%;margin-top: -8px;">
                     Not a member?
                     <a href="#" target="_top">Sign up!</a>
                     </span>
                     <span id="ForgotPasswordLink" class="footnote" style="display: none;position: absolute;top: 50%;margin-top: -8px;">
                     <a href="ResetPasswordRequest.aspx" target="_top">Forgot your password?</a>
                     </span>
                     <button type="submit" name="loginrbx" class="btn-small btn-neutral" id="loginrbx" tabindex="4" style="float:right; margin-top:8px;">Login</button>
                     <span id="LoggingInStatus" style="display: none; position: absolute; right: 8px;margin-top: -11px;top: 50%;">
                     <img src="https://s3.amazonaws.com/images.roblox.com/6ec6fa292c1dcdb130dcf316ac050719.gif" style="margin-right: 5px;width: 20px;height: 20px;" alt="" />
                     <span style="top: -5px;position: absolute;position: relative;">Logging in...</span>
                     </span>
                  </div>
               </div>
            </div>
         </form>
      </div>
   </body>
</html>
