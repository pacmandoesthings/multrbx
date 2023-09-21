<?php include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php'); ?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php'); ?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/ProdLogin.php'); ?>

<?php
switch(true){
			case ($RBXTICKET !== null):
			header("Location: ". $baseUrl ."/");
			break;
		}
		
		
		?>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body{ font: 14px sans-serif; }
        .wrapper{ width: 360px; padding: 20px; }
    </style>
</head>
<body>
    <div class="wrapper">
        <h2>Login</h2>
        <p>Please fill in your credentials to login.</p>

        

<form method="POST" action="https://mulrbx.com/mobileapi/login.php">
    <div class="form-group">
        <label>Username</label>
        <input type="text" name="username" class="form-control">
        <span class="invalid-feedback"><?php echo $username_err; ?></span>
    </div>    
    <div class="form-group">
        <label>Password</label>
        <input type="password" name="password" class="form-control">
        <span class="invalid-feedback"></span>
        <?php
        switch(true){
            case (count($errors) > 0):
                foreach ($errors as $error){
                    echo "<div id='ErrorMessage' style='color:Red'>". $error ."</div>";
                }
                break;
        }
        ?>
    </div>
    <div class="form-group">
        <input type="submit" name="loginrbx" class="btn btn-primary" id="loginrbx" value="Login">
    </div>
</form>
  