<?php



include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
include($_SERVER['DOCUMENT_ROOT'] . '/UserInfo.php');
include($_SERVER['DOCUMENT_ROOT'] . '/ProdLogin.php');

$NameErrors = null;
$PassSHOW = null;
$EmailSHOW = null;
$KeySHOW = null;

switch(true){case ($RBXTICKET !== null):header("Location: ". $baseUrl ."/My/Home");break;}

?>


<!DOCTYPE html>
<html>
<!-- The video -->
<video autoplay muted loop id="myVideo">
  <source src="trailer2.mp4" type="video/mp4">
</video>

<!-- Optional: some overlay text to describe the video -->

<head>
  <meta charset="utf-8">

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Welcome to MULTRBX</title>
<div class="video-background">
  <video autoplay muted loop id="video-bg">
    <source src="trailer2.mp4" type="video/mp4">
  </video>
  <img src="logous.png" class="logo">
  <p class="text">A 2017E old Roblox revival.</p>
</div>
   <style>

    .wrapper{ width: 360px; padding: 20px; }

  
    .main {
     
        position: absolute;
        box-sizing: border-box;
    }
	
	#video-bg {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.logo {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  max-width: 2000px; /* Adjust the size as needed */
}

.text {
  position: absolute;
  top: 60%; /* Adjust the vertical position */
  left: 50%;
  transform: translateX(-50%);
  color: black;
  font-size: 50px;
  
}

    .register {
   
        
        margin-top: 170px;
        border-style: solid;
        border-radius: 0.375rem;
        border-color: #7E7E7E;
    }

    </style>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
</head>
<body>


<center><div class="register">
     <div class="wrapper">
        <h2>Register</h2>
        <p>this page is in beta</p>
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

 <label class="form-label" for="ivkey">Invitation Key:</label>
							  <div class="rightFormColumn">
								 <div class="inputColumn">
									<input name="invkey" type="text" id="invkey" tabindex="6" class="text-box text-box-large">
								 </div>

								 <div class="clear" style="font-size:0;"></div>
								 
							  </div>
						   </div>
							 

								 <div class="clear" style="font-size:0;"></div>
								 <span class="tip-text">We use this for password recovery and other services.</span>
							  </div>
						   </div>
						   <div class="clear" style="font-size:0;"></div>
						   <div class="CreateAccountWrapper" style="text-align:center">
							  <div class="form-group">
                <input type="submit" name="registerrbx" id="registerrbx" class="btn btn-primary" value="Submit">
            </div>
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
                 
       
         

      
            
            <p>Or, if you already have an account, <a href="/login">login!</a></p>
        </form>
    </div>
</div>
</div>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
</body>
</html>


