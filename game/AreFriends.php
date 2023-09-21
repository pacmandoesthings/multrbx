<?php
header("Cache-Control: no-cache, no-store");
header("Pragma: no-cache");
header("Expires: -1");
header("Last-Modified: " . gmdate("D, d M Y H:i:s T") . " GMT");
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');

$userId = $_GET['userId'];
$otherUserIds = $_GET['otherUserIds'];

function friendsWithUser($user1, $user2)
{
    include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
    
    $check = $MainDB->prepare("SELECT * FROM friends WHERE (user1 = :u AND user2 = :u2 OR user1 = :ua AND user2 = :ua2)");
    $check->bindParam(":u", $user1, PDO::PARAM_INT);
    $check->bindParam(":u2", $user2, PDO::PARAM_INT);
    $check->bindParam(":ua", $user2, PDO::PARAM_INT);
    $check->bindParam(":ua2", $user1, PDO::PARAM_INT);
    $check->execute();
    
    return $check->rowCount() > 0;
}
$users = [];

if (!empty($otherUserIds)) {
    $otherUserIdsArray = explode(",", $otherUserIds);

    foreach ($otherUserIdsArray as $user) {
        if (friendsWithUser($userId, $user)) {
            $users[] = "," . $user . ",";
        }
    }
}

if (!empty($users)) {
    $users = array_unique($users); // Remove duplicate values
}

echo implode("", $users);
