<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');

function getUserBadgeInfo($id)
{
    include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');

    $check = $MainDB->prepare("SELECT * FROM badges WHERE id = :i");
    $check->bindParam(":i", $id, PDO::PARAM_INT);
    $check->execute();
    if ($check->rowCount() > 0) {
        return $check->fetch(PDO::FETCH_OBJ);
    }
    return false;
}

function rewardUserBadge($UserID, $BadgeID, $PlaceID)
{
    include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');

    $badge = getUserBadgeInfo($BadgeID);
    if ($badge !== FALSE && $badge->AwardingPlaceID == $PlaceID) {
        $rbadge = $MainDB->prepare("INSERT INTO user_badges(uid,bid,isOfficial,whenEarned) VALUES(:n, :d, 0, UNIX_TIMESTAMP())");
        $rbadge->bindParam(":n", $UserID, PDO::PARAM_INT);
        $rbadge->bindParam(":d", $BadgeID, PDO::PARAM_INT);
        $rbadge->execute();
        return true;
    }
    return false;
}

$userid = $_GET['UserID'];
$badgeid = $_GET['BadgeID'];
$placeid = $_GET['PlaceID'];

if (rewardUserBadge($userid, $badgeid, $placeid)) {
    echo getUserBadgeInfo($badgeid)->name;
} else {
    echo 0;
}
