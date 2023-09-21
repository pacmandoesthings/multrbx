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

<style>
body {
  background-color: black;
}

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

.div-container {
  position: fixed;
  background: rgba(255, 255, 255, 0.8);
  color: #f1f1f1;
  top: 40%;
  left: 50%;
  transform: translate(-50%, -50%);
  margin: auto;
  width: 450px;
  padding: 20px;
  border-radius: 3px;
  padding-top: 5px;
  box-shadow: 5px 5px 16px black;
  margin-top: 100px;
  padding-bottom: 10px;
}

.register-title {
  color: black;
  font-size: 30px;
  text-align: center;
}

.login-title {
  color: black;
  font-size: 30px;
  text-align: center;
}

.error-title {
  color: black;
  font-size: 30px;
  text-align: center;
}

p {
  color: black;
  text-overflow: ellipsis;
  white-space: nowrap;
  overflow: hidden;
  margin-bottom: 0px;
}

.wrap-text {
  white-space: wrap;
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

.button {
  background-color: rgb(80, 135, 255);
  border: none;
  color: white;
  width: 100%;
  height: 35px;
  margin-top: 10px;
  transition: background-color 200ms;
  border-radius: 3px;
}

.button:hover {
  background-color: rgb(132, 171, 255);
}

#background-fade {
  background-color: black;
  position: fixed;
  height: 100%;
  width: 100%;
  z-index: 0;
}

.logo-text {
  position: fixed;
  height: 220px;
  width: 100%;
  margin: auto;
  top: 100px;
  padding-bottom: 0;
  padding-top: 0;
  left: 50%;
  transform: translate(-50%, -50%);
}

#slogan-text {
  position: fixed;
  text-align: center;
  vertical-align: bottom;
  width: 500px;
  left: 50%;
  top: 140px;
  font-size: 35px;
  margin-bottom: 0;
  color: white;
  text-shadow: 5px 5px 5px black;
  background-color: rgba(0, 0, 0, 0.4);
  transform: translate(-50%, -50%);
  height: 70px;
  z-index: 1;
  line-height: 70px;
}

#randomize-slogan-button {
  position: fixed;
  bottom: 0;
  text-align: center;
  vertical-align: bottom;
  width: 500px;
  left: 50%;
  top: 140px;
  font-size: 35px;
  margin-bottom: 0;
  color: white;
  border: none;
  background-color: rgba(0, 0, 0, 0);
  transform: translate(-50%, -50%);
  height: 70px;
  z-index: 3;
}

.logo-text img {
  position: relative;
  transform: translate(-50%, -50%);
  left: 50%;
  top: 80px;
  width: auto;
  height: 130px;
  z-index: 2;
}

@media (max-width: 500px) {
  .div-container {
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

  .login-title {
    visibility: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
  }

  .login-title:after {
    color: black;
    font-size: 30px;
    width: 100%;
    text-align: center;
    content: "Login!";
    position: absolute;
    visibility: visible;
    text-align: center;
    left: 0;
    top: 0;
  }

  .error-title {
    visibility: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
  }

  .error-title:after {
    color: black;
    font-size: 30px;
    width: 100%;
    text-align: center;
    content: "404";
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
  #slogan-text {
    visibility: hidden;
  }
  #randomize-slogan-button {
    visibility: hidden;
  }
}

@media (max-height: 675px) {
  .div-container {
    top: 45%;
  }
}

</style>
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

    <meta
      name="description"
      content="MULTRBX is a 2017e Roblox revival with Android support. So come and join MULTRBX!"
    />
    <meta name="keywords" content="Roblox, Revival, 2017 Roblox, Old Roblox" />
  </head>
  <body>
    <video autoplay muted id="backgroundVideo">
      <source src="" type="video/mp4"/>
    </video>

    <div id="background-fade"></div>

    <div class="logo-text">
      <img src="funnylogo.png" alt="MULTRBX Logo" draggable="false">
      <p id="slogan-text">2017e revival</p>
      <button id="randomize-slogan-button"></button>
    </div>

    <div class="div-container">
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

        <button class="button" name="registerrbx" id="registerrbx">
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
      <p class="text m-0">Have an account? <a href="login">Login!</a></p>
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
        "cool revival",
        "&#60;h1&#62;Multrbx!&#60;/h1&#62;",
        "your such a poopy head",
        "describe 9/11 in emojis!",
        "######## ### ## #####",
        "### ####### ### ## ##",
        "########################",
        "187.91.41.91",
        "127.0.0.1",
        "308 Negra Arroyo Lane",
        "my dad was a pilot at 9/11/01",
        "oceangate more like oceanfate",
        "samsung batteries are pillows",
        "welcome to microsoft support",
        "lets eat grandma!",
        "spek englesh looser,",
        "hey wanna buy some lettuce?",
        "<i>bruh</i>",
        "i will swear word u",
        "now with smart fridge support",
        "now with toaster support",
        "put a magnet near your hdd",
        "help me please i dont have time",
        "super sex",
        "Lorem ipsum dolor sit amet.",
        "47 bodies, 0 found",
        "this is like minecraft splash text",
        "ios support at [REDACTED] days",
        "xX_MumFucker78_Xx",
        "today im unboxing at a funeral",
        "cp violation",
        "the cake is a lie",
        "do a barrel roll!",
        "<i>`age doesnt matter`</i> - r kelly",
        "✈ 🏢 🏢",
        "this text is one out of million",
        "8901.4152.9412.5168",
        "HOW DO I CENTER A DIV",
        "cum in the name of piss",
        "wait shes 6?",
        "🤓",
        "thats what she said",
        "she said she was 12",
        "#### you",
        "Uncaught ReferenceError: slogans is not defined",
        "the best quality revival!",
        "we <s>dont</s> pay our employees!",
        "Math.random() * (mx-mn) + mn",
        "<b>turn around</b>",
        "go touch some grass",
        "how do i type",
        "despacito",
        "i have nightmares abt that cat",
        "01110011 01100101 01111000",
        "i hope ted sees this 🖕🖕🖕",
        "from source code of vrblx!",
        "i love my sister",
        "note: i dont love my sister - ifar",
        "life.remove();",
        "mmmm expired meat",
        "its so long!",
        "youtu.be/dQw4w9WgXcQ",
        "youtu.be/SHRAEqxoN0c",
        "Undefined",
        "magical mushrooms! 😍😍😍",
        "i didn't know she was my sister!",
        "we recreated 9/11!",
        "#### you ###### wish you ###",
        "Powering Imagination!",
        ":nerd_face:",
        "whats minions leader in 1940?",
        "you won a fre iphon!1!!1",
        "the fog is cumming",
        "the fog is coming",
        "ambatukam",
        "peter the horse is cumming",
        "peter the horse is coming",
        "this is the 100th slogan!",
        "what the fuck is python",
        "give me your pfp url!111!!!1",
      ];

      const randomVideos = [
        "/logtrailer.mp4",
        "/trailer2.mp4",
        "/trailer3.mp4",
        "/trailer4.mp4",
        "/trailer5.mp4",
        "/trailer6.mp4",
      ];

      function random(mn, mx) {
        return Math.round(Math.random() * (mx - mn) + mn);
      }

      function wait(seconds) {
        new Promise((seconds) => setTimeout(seconds, seconds * 1000));
      }

      document.getElementById("randomize-slogan-button").onclick = function () {
        document.getElementById("slogan-text").innerHTML =
          randomSlogans[random(0, randomSlogans.length - 1)];
      };

      document.getElementById("slogan-text").innerHTML =
        randomSlogans[random(0, randomSlogans.length - 1)];

      const videoBackground = document.getElementById("backgroundVideo");

      function sleep(ms) {
        return new Promise((resolve) => setTimeout(resolve, ms));
      }

      const fadeBackground = document.getElementById("background-fade");

      function fade(element) {
        var op = 1; // initial opacity
        var timer = setInterval(function () {
          if (op <= 0.1) {
            clearInterval(timer);
            element.style.display = "none";
          }
          element.style.opacity = op;
          element.style.filter = "alpha(opacity=" + op * 100 + ")";
          op -= op * 0.1;
        }, 50);
      }

      function unfade(element) {
        var op = 0.1; // initial opacity
        element.style.display = "block";
        var timer = setInterval(function () {
          if (op >= 1) {
            clearInterval(timer);
          }
          element.style.opacity = op;
          element.style.filter = "alpha(opacity=" + op * 100 + ")";
          op += op * 0.1;
        }, 10);
      }

      unfade(fadeBackground);

      videoEnded();

      videoBackground.addEventListener("ended", videoEnded, false);

      var previousVideo = null;

      function videoEnded() {
        function chooseRandomVideo() {
          var randomVideoChosen = Math.floor(Math.random() * randomVideos.length);
          if (randomVideoChosen !== previousVideo) {
            unfade(fadeBackground);
            setTimeout(() => {
              fade(fadeBackground);
            }, 1000);
            console.log(`Different video was chosen`);
            setTimeout(() => {
              videoBackground.src = randomVideos[randomVideoChosen];
            }, 1000);
            previousVideo = randomVideoChosen;
          } else {
            console.log("Same video was chosen, rerolling");
            chooseRandomVideo();
          }
        }

        console.log("Current video ended");
        chooseRandomVideo();
      }

    </script>

  </body>
</html>
