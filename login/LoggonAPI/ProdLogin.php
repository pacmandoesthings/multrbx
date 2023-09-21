<?php include($_SERVER['DOCUMENT_ROOT'] . '/config.php'); ?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/FuncTypes.php'); ?>

<?php
session_start();
$errors = array();
$ErrCount = 0;
//register errors
$UserErrors = array();
$EmailErrors = array();
$PassErrors = array();
//date
$date = date("Y-m-d");

switch(true){
  case (isset($_POST['loginrbx'])):
    $username = strip_tags($_POST['username']);
    $password = strip_tags($_POST['password']);
    
    switch(true){case (empty($username)):array_push($errors, "Username box is empty.");break;}
    switch(true){case (empty($username)):array_push($errors, "Password box is empty.");break;}
    switch(true){case (preg_match('/^[a-z0-9_]+$/i', $username) == 0):array_push($errors, "User does not exist.");break;}
    switch(true){case (preg_match('/^[a-z0-9_]+$/i', $password) == 0):array_push($errors, "User does not exist.");break;}
    
    switch(true){
      case (count($errors) == 0):
        $loggon = $MainDB->prepare("SELECT password, token FROM users WHERE name = :username");
        $loggon->execute([':username' => $username]);
        $results = $loggon->fetch(PDO::FETCH_ASSOC);
        $checkpsw = ($results['password'] ?? null);
        $token = ($results['token'] ?? null);
      
        switch(true){
          case (!empty($checkpsw)):
            switch(true){
              case (password_verify($password,$checkpsw)):
                setcookie("ROBLOSECURITY", $token, time()+9900, "/", $_SERVER['SERVER_NAME']);
				setcookie(".ROBLOSECURITY", $token, time()+9900, "/", $_SERVER['SERVER_NAME']);
                header("Refresh: 0");
                die();
                break;
              default:
                array_push($errors, "Your password is incorrect.");
                break;
            }
            break;
          default:
            array_push($errors, "This account does not exist.");
            break;
        }
        break;
    }
    break;
  case (isset($_POST['registerrbx'])):
    $username = strip_tags($_POST['username']);
    $password = strip_tags($_POST['password']);
    $password2 = strip_tags($_POST['passwordcheck']);
    $email = strip_tags($_POST['email']);
    $token = random_tkn();
    $refer = ($_GET['refer']);
    
    switch(true){
      case (empty($username)):
        array_push($UserErrors, "Username box is empty.");
        break;
      default:
        switch(true){case (preg_match('/^[a-z0-9_]+$/i', $username) == 0):array_push($UserErrors, "Your username cannot have invalid characters.");$ErrCount = $ErrCount + 1;break;}
        switch(true){case(strlen($username) > 20):array_push($UserErrors, "Name cannot be longer than 20 characters.");$ErrCount = $ErrCount + 1;break;}
        break;
    }
    switch(true){
      case (empty($password)):
        array_push($PassErrors, "Password box is empty.");
        $ErrCount = $ErrCount + 1;
        break;
      default:
        switch(true){case (preg_match('/^[a-z0-9_]+$/i', $password) == 0):array_push($PassErrors, "Password cannot have invalid characters.");$ErrCount = $ErrCount + 1;break;}
        switch(true){case ($password !== $password2):array_push($PassErrors, "Passwords dont match.");$ErrCount = $ErrCount + 1;break;}
        switch(true){case(strlen($password) > 20):array_push($PassErrors, "Password cannot be longer than 20 characters.");$ErrCount = $ErrCount + 1;break;}
        break;
    }
    switch(true){
      case (empty($email)):
        array_push($EmailErrors, "Email box is empty.");
        $ErrCount = $ErrCount + 1;
        break;
      default:
        switch(true){case (!filter_var($email, FILTER_VALIDATE_EMAIL)):array_push($EmailErrors, "Invalid email.");$ErrCount = $ErrCount + 1;break;}
        break;
    }
    
    //UEC User Exist Check
    $UEC = $MainDB->prepare("SELECT * FROM users WHERE name = :username");
    $UEC->execute([':username' => $username]);
    $Row = $UEC->fetch(PDO::FETCH_ASSOC);
    switch(true){case ($Row):array_push($UserErrors, "User already exists.");$ErrCount = $ErrCount + 1;break;}
    
    $q4= $MainDB->prepare("SELECT used FROM refkeys WHERE refkey=?");
$q4->execute([$refer]);
$used = $q4->fetchColumn();









if ($used == 1 || $used > 1) {
die("Referral key is used.");
}

    switch(true){
      case ($ErrCount == 0):

$thething= md5($_SERVER['REMOTE_ADDR']);
 $stmte = $MainDB->prepare("UPDATE refkeys SET used= 1 WHERE refkey= :urmomfat");
 $stmte->bindParam(":urmomfat", $refer, PDO::PARAM_STR);
 $stmte->execute();
        $lestmt = $MainDB->prepare("UPDATE refkeys SET userip = :sex WHERE refkey= :urmomfat");
 $lestmt->bindParam(":urmomfat", $refer, PDO::PARAM_STR);
        $lestmt->bindParam(":sex", $thething, PDO::PARAM_STR);
 $lestmt->execute();
        $hashedpassword = password_hash($password, PASSWORD_DEFAULT);
        $InsertToDB = $MainDB->prepare("INSERT INTO `users` (`id`, `name`, `password`, `ticket`, `robux`, `email`, `status`, `membership`, `termtype`, `treason`, `tnote`, `tdate`, `creationdate`, `token`, `ipmd5`) VALUES (NULL, ?, ?, '10', '10', ?, 'Im new to MULTRBX.', NULL, NULL, NULL, NULL, NULL, ?, ?, ?)")->execute([$username, $hashedpassword, $email, $date, $token, $thething]);
        setcookie("ROBLOSECURITY", $token, time()+9900, "/", $_SERVER['SERVER_NAME']);
		setcookie(".ROBLOSECURITY", $token, time()+9900, "/", $_SERVER['SERVER_NAME']);
        header("Location: ". $baseUrl ."/My/Home");
        die();
        break;
    }
    break;
}
?>




