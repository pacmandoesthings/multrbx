<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');

function userExists($id)
{
    include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
	$get = $MainDB->prepare("SELECT * FROM users WHERE id = :i");
	$get->bindParam(":i", $id, PDO::PARAM_INT);
	$get->execute();
	if($get->rowCount() > 0) 
	{
		return true;
	}
	return false;
}


function areUsersFriends($user1, $user2)
{
	include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
	$check = $MainDB->prepare("SELECT * FROM friends WHERE (user1 = :u and user2 = :u2 OR user1 = :ua and user2 = :ua2)");
	$check->bindParam(":u", $user1, PDO::PARAM_INT);
	$check->bindParam(":u2", $user2, PDO::PARAM_INT);
	$check->bindParam(":ua", $user2, PDO::PARAM_INT);
	$check->bindParam(":ua2", $user1, PDO::PARAM_INT);
	$check->execute();
	if($check->rowCount() > 0) 
	{
		return true;
	}
	return false;
}

function CreateFriend($firstuserid, $seconduserid) //used on the game server
{
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');

	if (!areUsersFriends($firstuserid, $seconduserid)) //gotta not be friends
	{
		if (userExists($firstuserid) && userExists($seconduserid))
		{
			include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');

			
			$newfriend = $MainDB->prepare("INSERT into friends(id,user1, user2) VALUES(NULL,:u, :u2)");
			$newfriend->bindParam(":u", $firstuserid, PDO::PARAM_INT);
			$newfriend->bindParam(":u2", $seconduserid, PDO::PARAM_INT);
			$newfriend->execute();
		}
	}
}


$firstuser = $_GET['firstUserId'];
$seconduser = $_GET['secondUserId'];

CreateFriend($firstuser, $seconduser);