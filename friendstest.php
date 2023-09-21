<?php
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
include($_SERVER['DOCUMENT_ROOT'] . '/UserInfo.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/ContextHeader.php');

$check = $MainDB->prepare("SELECT * FROM friends WHERE user1 = $id OR user2 = $id");

$check->execute();

$ActionRows = $check->fetchAll(PDO::FETCH_ASSOC);

echo '
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
  .container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
  }
  
  .box {
    width: 200px;
    height: auto;
    background-color: #f0f0f0;
    border-radius: 10px;
    padding: 20px;
    text-align: center;
    margin: 10px;
  }

  .box img {
    max-width: 100%;
    border-radius: 50%;
  }

  .box p {
    margin-top: 10px;
    font-size: 16px;
  }
</style>
</head>
<body>
<div class="container">
';

foreach ($ActionRows as $row) {
    $otherUserId = ($row['user1'] == $id) ? $row['user2'] : $row['user1'];

    if ($otherUserId != $id) {
        $GameFetch = $MainDB->prepare("SELECT * FROM users WHERE id = :pid");
        $GameFetch->bindParam(":pid", $otherUserId, PDO::PARAM_INT);
        $GameFetch->execute();
        $Results = $GameFetch->fetch(PDO::FETCH_ASSOC);

        // Display user's avatar and information
        echo '
        <div class="box">
          <img src="https://mulrbx.com/thumbs/avatar.ashx?userId=' . $otherUserId . '&x=48&y=48" alt="Avatar">
          <p>' . $Results['name'] . '</p>
        </div>
        ';
    }
}

echo '
</div>
</body>
</html>
';
?>
