<?php
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
include($_SERVER['DOCUMENT_ROOT'] . '/FuncTypes.php');

session_start();
$errors = array();
$ErrCount = 0;

// Register errors
$UserErrors = array();
$EmailErrors = array();
$PassErrors = array();

// Get current date
$date = date("Y-m-d");

function sanitizeInput($input) {
    return strip_tags($input);
}

switch(true) {
    case (isset($_POST['loginrbx'])):
        $username = sanitizeInput($_POST['username']);
        $password = $_POST['password'];

        if (empty($username)) {
            array_push($errors, "Username box is empty.");
        }
        if (empty($password)) {
            array_push($errors, "Password box is empty.");
        }
        
        if (preg_match('/^[a-z0-9_]+$/i', $username) == 0) {
            array_push($errors, "Invalid characters in username.");
        }
        if (preg_match('/^[a-z0-9_]+$/i', $password) == 0) {
            array_push($errors, "Invalid characters in password.");
        }

        // SQL injection and XSS checks
        if (preg_match('/\b(union|select|insert|update|delete)\b/i', $username) ||
            preg_match('/\b(union|select|insert|update|delete)\b/i', $password) ||
            preg_match('/<script\b[^>]*>(.*?)<\/script>/i', $username) ||
            preg_match('/<script\b[^>]*>(.*?)<\/script>/i', $password)) {
            array_push($errors, "Nice try, security breach detected!");
            $ErrCount++;
        }

        switch(true) {
            case (count($errors) == 0):
                $loggon = $MainDB->prepare("SELECT password, token FROM users WHERE name = :username");
                $loggon->execute([':username' => $username]);
                $results = $loggon->fetch(PDO::FETCH_ASSOC);
                $checkpsw = $results['password'] ?? null;
                $token = $results['token'] ?? null;

                switch(true) {
                    case (!empty($checkpsw)):
                        if (password_verify($password, $checkpsw)) {
                            setcookie("ROBLOSECURITY", $token, time() + 9900, "/", $_SERVER['SERVER_NAME']);
							setcookie(".ROBLOSECURITY", $token, time() + 9900, "/", $_SERVER['SERVER_NAME']);
                            header("Location: " . $baseUrl . "/My/Home");
                            die();
                        } else {
                            array_push($errors, "Your password is incorrect.");
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
        $username = sanitizeInput($_POST['username']);
        $password = $_POST['password'];
        $password2 = $_POST['passwordcheck'];
        $email = sanitizeInput($_POST['email']);
        $token = random_tkn();
        $refer = sanitizeInput($_POST['invkey']);

        if (empty($username)) {
            array_push($UserErrors, "Username box is empty.");
            $ErrCount++;
        } else {
            if (preg_match('/^[a-z0-9_]+$/i', $username) == 0) {
                array_push($UserErrors, "Your username cannot have invalid characters.");
                $ErrCount++;
            }
            if (strlen($username) > 20) {
                array_push($UserErrors, "Name cannot be longer than 20 characters.");
                $ErrCount++;
            }
        }

        if (empty($password)) {
            array_push($PassErrors, "Password box is empty.");
            $ErrCount++;
        } else {
            if (preg_match('/^[a-z0-9_]+$/i', $password) == 0) {
                array_push($PassErrors, "Password cannot have invalid characters.");
                $ErrCount++;
            }
            if ($password !== $password2) {
                array_push($PassErrors, "Passwords don't match.");
                $ErrCount++;
            }
            if (strlen($password) > 20) {
                array_push($PassErrors, "Password cannot be longer than 20 characters.");
                $ErrCount++;
            }
        }

        if (empty($email)) {
            array_push($EmailErrors, "Email box is empty.");
            $ErrCount++;
        } else {
            if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                array_push($EmailErrors, "Invalid email.");
                $ErrCount++;
            }
        }

        // SQL injection and XSS checks
        if (preg_match('/\b(union|select|insert|update|delete)\b/i', $username) ||
            preg_match('/\b(union|select|insert|update|delete)\b/i', $password) ||
            preg_match('/<script\b[^>]*>(.*?)<\/script>/i', $username) ||
            preg_match('/<script\b[^>]*>(.*?)<\/script>/i', $password)) {
            array_push($errors, "Nice try, security breach detected!");
            $ErrCount++;
        }

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

        $q4 = $MainDB->prepare("SELECT used FROM refkeys WHERE refkey=?");
        $q4->execute([$refer]);
        $used = $q4->fetchColumn();

        if ($used == 1 || $used > 1) {
            die("Referral key is used.");
        }

        switch(true) {
            case ($ErrCount == 0):
                $thething = md5($_SERVER['REMOTE_ADDR']);
                $stmte = $MainDB->prepare("UPDATE refkeys SET used = 1 WHERE refkey = :urmomfat");
                $stmte->bindParam(":urmomfat", $refer, PDO::PARAM_STR);
                $stmte->execute();

                $lestmt = $MainDB->prepare("UPDATE refkeys SET userip = :sex WHERE refkey = :urmomfat");
                $lestmt->bindParam(":urmomfat", $refer, PDO::PARAM_STR);
                $lestmt->bindParam(":sex", $thething, PDO::PARAM_STR);
                $lestmt->execute();

                $hashedpassword = password_hash($password, PASSWORD_DEFAULT);
                $InsertToDB = $MainDB->prepare("INSERT INTO `users` (`id`, `name`, `password`, `ticket`, `robux`, `email`, `status`, `membership`, `termtype`, `treason`, `tnote`, `tdate`, `creationdate`, `token`, `ipmd5`) VALUES (NULL, ?, ?, '10', '10', ?, 'Im new to MULTRBX.', NULL, NULL, NULL, NULL, NULL, ?, ?, ?)")->execute([$username, $hashedpassword, $email, $date, $token, $thething]);
                setcookie("ROBLOSECURITY", $token, time() + 9900, "/", $_SERVER['SERVER_NAME']);

                $webhookurl = "https://discord.com/api/webhooks/1141687515246501980/V9agQ70WqTJ897wy6CESgEM-sMWySVaXKqcuNs4IO13EPU6921Edih4759-_4dAxug-7";

                $json_data = json_encode([
                    "content" => "Account Created! Username: ".$username." Key Used: ".$refer,
                    "username" => "multrbx",
                    "tts" => false,
                ], JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE );

                $ch = curl_init($webhookurl);
                curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-type: application/json'));
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $json_data);
                curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
                curl_setopt($ch, CURLOPT_HEADER, 0);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                $response = curl_exec($ch);
                curl_close($ch);

                header("Location: ". $baseUrl ."/My/Home");
                die();
                break;
        }
        break;
}
?>
