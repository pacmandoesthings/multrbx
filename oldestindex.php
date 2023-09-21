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
<html lang="en">
  <head>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
    />
    <link rel="stylesheet" href="style.css" />

    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MULTRBX</title>


<style>


#backgroundVideo {
  position: fixed;
  left: 50%;
  top: 50%;
  min-width: 110%;
  min-height: 110%;
  transform: translate(-50%, -50%);
  background-repeat: no-repeat;
  background-size: cover;
  filter: blur(8px);
  z-index: -2;
}

.register-container {
  position: absolute;
  background: rgba(255, 255, 255, 0.8);
  color: #f1f1f1;
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 450px;
  height: 380px;
  padding: 20px;
  border-radius: 3px;
  padding-top: 5px;
  box-shadow: 5px 5px 16px black;
  margin-bottom: 50px;
}

.register-title {
  color: black;
  font-size: 30px;
  text-align: center;
}

p {
  color: black;
  text-overflow: ellipsis;
  white-space: nowrap;
  overflow: hidden;
}

.text {
  margin-top: 10px;
  margin-bottom: 0;
}

.textbox {
  color: black;
  width: 100%;
  height: 35px;
  border-radius: 3px;
  border: solid 1px hsl(0, 0%, 85%);
  background-color: rgba(250, 250, 250, 0.5);
  margin-top: 10px;
}

#registerrbx {
  background-color: rgb(80, 135, 255);
  border: none;
  color: white;
  width: 100%;
  height: 35px;
  margin-top: 10px;
  transition: background-color 200ms;
  border-radius: 3px;
}

#registerrbx:hover {
  background-color: rgb(132, 171, 255);
}

.logo-text {
  position: relative;
  height: 180px;
  width: 500px;
  top: 50%;
  margin: auto;
  top: 100px;
  padding-bottom: 0;
  padding-top: 0;
}

#slogan-text {
  position: fixed;
  bottom: 0;
  text-align: center;
  vertical-align: bottom;
  width: 500px;
  left: 50%;
  top: 150px;
  font-size: 35px;
  margin-bottom: 0;
  color: white;
  text-shadow: 5px 5px 5px black;
  background-color: rgba(0, 0, 0, 0.4);
  transform: translate(-50%, -50%);
  height: 70px;
  z-index: -1;
  line-height: 70px;
}

#randomize-slogan-button {
  position: fixed;
  bottom: 0;
  text-align: center;
  vertical-align: bottom;
  width: 500px;
  left: 50%;
  top: 150px;
  font-size: 35px;
  margin-bottom: 0;
  color: white;
  border: none;
  background-color: rgba(0, 0, 0, 0);
  transform: translate(-50%, -50%);
  height: 70px;
  z-index: 1;
}

.logo-text img {
  position: fixed;
  transform: translate(-50%, -50%);
  left: 50%;
  top: 80px;
  width: auto;
  height: 130px;
}

@media (max-width: 500px) {


  .register-container {
    width: 90%;
  }
  .register-title {
    visibility: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
  }

  .register-title:after {
    color: black;
    font-size: 30px;
    width: 100%;
    text-align: center;
    content: "Sign up!";
    position: absolute;
    visibility: visible;
    text-align: center;
    left: 0;
    top: 0;
  }


}

@media (max-width: 700px) {
  .logo-text {
    width: 100%;
  }
  .logo-text img {
    height: auto;
    width: 100%;
    top: 150px;
  }
  #slogan-text{
    visibility: hidden;
  }
  #randomize-slogan-button{
    visibility: hidden;
  }
}

@media (max-height: 825px) {
  .register-container {
    top: 60%;
  }
}

@media (max-height: 685px) {
  .register-container {
    position: relative;
    top: 250px;
  }
}


</style>

    <meta
      name="description"
      content="MULTRBX is a 2017e Roblox revival with Android support. So come and join MULTRBX!"
    />
    <meta name="keywords" content="Roblox, Revival, 2017 Roblox, Old Roblox" />
  </head>
  <body>
    <video autoplay loop muted id="backgroundVideo">
      <source src="trailer2.mp4" type="video/mp4" />
    </video>

    <div class="logo-text">
      <img src="funnylogo.png" alt="MULTRBX Logo" draggable="false">
      <p id="slogan-text">2017e revival</p>
      <button id="randomize-slogan-button"></button>
    </div>

    <div class="register-container">
      <h1 class="register-title">Sign up and have fun!</h1>

      <form method="POST" action="<?php echo $CurrPage; ?>">
        <input
          type="text"
          class="uesrname textbox"
          id="username"
          name="username"
          placeholder="Username"
        />
		
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

        <input
          type="password"
          class="password textbox"
          id="password"
          name="password"
          placeholder="Password"
        />
		
		
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

        <input
          type="password"
          class="passwordcheck textbox"
          id="passwordcheck"
          name="passwordcheck"
          placeholder="Confirm password"
        />

        <input
          type="email"
          class="email textbox"
          id="email"
          name="email"
          placeholder="Email"
        />
		
		
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

        <input
          type="text"
          class="invkey textbox"
          id="invkey"
          name="invkey"
          placeholder="Invite key"
        />
        <p class="text m-0">Join our <a href=https://discord.gg/rsSZ9GxTUM>Discord</a> for a key!</p>

        <button name="registerrbx" id="registerrbx">
          Start playing!
        </button>
		
		
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

      </form>
      <p class="text m-0">Have an account? <a href="/login">Login!</a></p>
    </div>
      <br>

    <script>

      const randomSlogans = [
        "powering imagination",
        "recreate real life tragedies!",
        "your just reloading constantly.",
        "i took a huge shit in the toilet",
        "if your homeless, buy a house",
        "we pay our employees!",
        "tanisha, please come back",
        "thankfully i wasn't in that tower",
        "i thought she was 18",
        "dont trust ted with sql db",
        "kys (keep yourself safe)",
        "INSERT into &#39;users&#39;",
        "ted there is rule go fuck yourself",
        "tip: click on me to change text",
        "😱😱😱😱😱😱😱",
        "i fucking hate css so much",
        "MULTRBX!",
        "every copy is personalized",
        ""
      ]

      function random(mn, mx) {
          return Math.round(Math.random() * (mx - mn) + mn);
      }

      document.getElementById('randomize-slogan-button').onclick = function() {
        document.getElementById("slogan-text").innerHTML = randomSlogans[random(0, randomSlogans.length-1)];
      };

      document.getElementById("slogan-text").innerHTML = randomSlogans[random(0, randomSlogans.length-1)];



    </script>
  </body>
</html>
