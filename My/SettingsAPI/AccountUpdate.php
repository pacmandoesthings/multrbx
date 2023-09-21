<?php 
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
include($_SERVER['DOCUMENT_ROOT'] . '/UserInfo.php');
include($_SERVER['DOCUMENT_ROOT'] . '/FuncTypes.php');
switch(true){
  case ($RBXTICKET == null):
    header("Location: ". $baseUrl ."/");
    die();
    break;
}
$date = date("Y/m/d") . " at " . date("H:i");
$errors = array();
$success = "0";
switch(true){
  case (isset($_POST['passupd'])):
    $oldpass = strip_tags($_POST['oldpass']);
    $newpass = strip_tags($_POST['newpass']);
    switch(true){case (empty($oldpass)):array_push($errors, "Please fill in all textboxes.");break;}
    switch(true){case (empty($newpass)):array_push($errors, "Please fill in all textboxes.");break;}
    switch(true){case (preg_match('/^[a-z0-9_]+$/i', $oldpass) == 0):array_push($errors, "Invalid old password.");break;}
    switch(true){case (preg_match('/^[a-z0-9_]+$/i', $newpass) == 0):array_push($errors, "Invalid new password.");break;}
    switch(true){case(strlen($newpass) > 60):array_push($errors, "Password is too big.");break;}
    
    switch(true){
      case (count($errors) == 0):
        $UpdPass = $MainDB->prepare("SELECT password FROM users WHERE token = :token");
        $UpdPass->execute([':token' => $RBXTICKET]);
        $RST = $UpdPass->fetch(PDO::FETCH_ASSOC);
        $CheckPSS = ($RST['password'] ?? null);
      
        switch(true){
          case (!empty($CheckPSS)):
            switch(true){
              case (password_verify($oldpass,$CheckPSS)):
                //the old pass matches.
                //begin updating the DB for new pass.
                $success = "1";
                $HashPSW = password_hash($newpass, PASSWORD_DEFAULT);
                $NewTKN = random_tkn();
                
                //we change the password, but also give our user a new token, because if they changed their password it could be because:
                //someone else knows their token, someone got access to their account and got their token
                //someone cookie logged them and got their token, etc.
                $CompletePass = $MainDB->prepare("UPDATE users SET password=:psw, token=:ntwkn WHERE token=:tkn")->execute([':psw' => $HashPSW, ':ntwkn' => $NewTKN, ':tkn' => $RBXTICKET]);
                setcookie("ROBLOSECURITY", $NewTKN, time()+9900, "/", $_SERVER['SERVER_NAME']);
                die(header('Location: '. $baseUrl .'/My/Account.aspx'));
                break;
              default:
                array_push($errors, "The old password is incorrect.");
                break;
            }
            break;
          default:
            //Something is wrong...
            //there are no matches for the account that is trying to change their password...
            //this means their token might be fucked, send them back to Logout page, so that shit dosent break.
            header('Location: '. $baseUrl .'/Login/Logout.ashx?returnUrl=/');
            break;
        }
        break;
    }
    break;
  case (isset($_POST['emailupd'])):
    $emailupdate = strip_tags($_POST['email']);
    switch(true){case (empty($emailupdate)):array_push($errors, "Email can't be empty.");break;}
    switch(true){case (!filter_var($emailupdate, FILTER_VALIDATE_EMAIL)):array_push($errors, "Invalid email.");break;}
    
    switch(true){
      case(count($errors) == 0):
        $success = "1";
        $UpdateEmail = $MainDB->prepare("UPDATE users SET email=?, emailverified=NULL WHERE token=?")->execute([$emailupdate, $RBXTICKET]);
        break;
    }
    break;
  case (isset($_POST['changename'])):
    $newname = strip_tags($_POST['newname']);
    switch(true){case (empty($newname)):array_push($errors, "Name can't be empty.");break;}
    switch(true){case (preg_match('/^[a-z0-9_]+$/i', $newname) == 0):array_push($errors, "Invalid username.");break;}
    switch(true){case(strlen($newname) > 20):array_push($errors, "Name is too big.");break;}
    switch(true){case(2138127391273812379812 > $robux):array_push($errors, "Not enough ROBUX.");break;}
    
    //we check if name is already taken
    $UEC = $MainDB->prepare("SELECT * FROM users WHERE name = :username");
    $UEC->execute([':username' => $newname]);
    $Row = $UEC->fetch(PDO::FETCH_ASSOC);
    switch(true){case ($Row):array_push($errors, "Name has been taken.");break;}
    
    switch(true){
      case(count($errors) == 0):
        $ResultRobux = $robux - 2138127391273812379812;
        $success = "1";
        $UpdateName = $MainDB->prepare("UPDATE users SET name=?, robux=? WHERE token=?")->execute([$newname, $ResultRobux, $RBXTICKET]);
        $UpdateGames = $MainDB->prepare("UPDATE asset SET creatorname=?, creatorid=? WHERE creatorid=?")->execute([$newname, $id, $id]);
        $UpdateFeed = $MainDB->prepare("UPDATE feed SET creatorname=?, creatorid=? WHERE creatorid=?")->execute([$newname, $id, $id]);
        break;
    }
    break;
  case(isset($_POST['UpdateBlurb'])):
    $Blurb = strip_tags($_POST['blurbText']);
    switch(true){case (empty($Blurb)):array_push($errors, "Blurb cant be empty.");break;}
    switch(true){case (preg_match('/[a-z0-9_"\']+$/i', $Blurb) == 0):array_push($errors, "Blurb cant contain invalid characters.");break;}
    switch(true){case(strlen($Blurb) > 1000):array_push($errors, "Blurb can't be that big!");break;}
    
    switch(true){
      case(count($errors) == 0):
        $success = "1";
        $UpdateBlurb = $MainDB->prepare("UPDATE users SET status=? WHERE token=?")->execute([$Blurb, $RBXTICKET]);
        die(header('Location: '. $baseUrl .'/My/Account.aspx'));
    }
    break;
  case(isset($_POST['updatestatus'])):
    $status = strip_tags($_POST['txtStatusMessage']);
    switch(true){case (empty($status)):array_push($errors, "Status can't be empty.");break;}
    switch(true){case (preg_match('/[a-z0-9_"\']+$/i', $status) == 0):array_push($errors, "Status cant contain invalid characters.");break;}
    switch(true){case(strlen($status) > 255):array_push($errors, "Status cant be that big!");break;}
    
    switch(true){
      case(count($errors) == 0):
        $InsertToDB = $MainDB->prepare("INSERT INTO `feed` (`id`, `creatorid`, `creatorname`, `content`, `date`, `announcement`) VALUES (NULL, ?, ?, ?, ?, '0')")->execute([$id, $name, $status, $date]);
        die(header('Location: '. $baseUrl .'/My/Home'));
        break;
    }
    break;
}
?>