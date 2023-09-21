<?php
include 'Grid/Rcc/RCCServiceSoap.php';
include 'Grid/Rcc/Job.php';
include 'Grid/Rcc/ScriptExecution.php';
include 'Grid/Rcc/LuaType.php';
include 'Grid/Rcc/LuaValue.php';
include 'Grid/Rcc/Status.php';
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');


$porty = rand(5000, 10000);

$RCCServiceSoap = new Roblox\Grid\Rcc\RCCServiceSoap("127.0.0.1", 56217);
$id = "GAME_" . substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"), 0, 10);
$job = new Roblox\Grid\Rcc\Job($id, 700000);


// If no open server with status 1 exists, proceed to create a new server
$scriptText = file_get_contents('gameserver.lua') . " start(\"" . $_GET['id'] . "\",\"" . $porty . "\",\"http://" . $_SERVER['SERVER_NAME'] . "\",\"" . $Results['creatorid'] . "\", '" . $isR15 . "');";
$script = new Roblox\Grid\Rcc\ScriptExecution("Game", $scriptText);
$jobResult = $RCCServiceSoap->OpenJobEx($job, $script);

// Insert the new server into the open_servers table with status 1



echo ($jobResult);
exit();
?>
