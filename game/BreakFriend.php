<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');


function BreakFriend($firstuserid, $seconduserid) //used on the game server
{
	include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
	$remove = $MainDB->prepare("DELETE FROM friends WHERE (user1 = :u and user2 = :u2 OR user1 = :ua and user2 = :ua2)");
	$remove->bindParam(":u", $firstuserid, PDO::PARAM_INT);
	$remove->bindParam(":u2", $seconduserid, PDO::PARAM_INT);
	$remove->bindParam(":ua", $seconduserid, PDO::PARAM_INT);
	$remove->bindParam(":ua2", $firstuserid, PDO::PARAM_INT);
	$remove->execute();
}

$firstuser = $_GET['firstUserId'];
$seconduser = $_GET['secondUserId'];

BreakFriend($firstuser, $seconduser);