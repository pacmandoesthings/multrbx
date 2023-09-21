<?php
include 'Grid/Rcc/RCCServiceSoap.php';
include 'Grid/Rcc/Job.php';
include 'Grid/Rcc/ScriptExecution.php';
include 'Grid/Rcc/LuaType.php';
include 'Grid/Rcc/LuaValue.php';
include 'Grid/Rcc/Status.php';
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');

$GameId = (int) ($_GET['id'] ?? die(header('Location: ' . $baseUrl . '/RobloxDefaultErrorPage.aspx')));
$vipowner = (int) ($_GET['vipowner'] ?? null);


$GameFetch = $MainDB->prepare("SELECT * FROM asset WHERE id = :pid AND itemtype = 'place'");
$GameFetch->execute([":pid" => $GameId]);
$Results = $GameFetch->fetch(PDO::FETCH_ASSOC);

$domain = "mulrbx.com";

switch (true) {
    case (!$Results):
        die(header('Location: ' . $baseUrl . '/RobloxDefaultErrorPage.aspx'));
        break;
}

if ($Results['iscool'] == 1) {
    $isR15 = 1;
} else {
    $isR15 = 0;
}


echo $Results['iscool'];

$porty = rand(5000, 10000);

$RCCServiceSoap = new Roblox\Grid\Rcc\RCCServiceSoap("127.0.0.1", 56217);
$id = "GAME_" . substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"), 0, 10);
$job = new Roblox\Grid\Rcc\Job($id, 700000);

$scriptText = file_get_contents('gameserver.lua') . " start(\"" . $_GET['id'] . "\",\"" . $porty . "\",\"http://" . $_SERVER['SERVER_NAME'] . "\",\"" . $Results['creatorid'] . "\", '" . $isR15 . "');";
$script = new Roblox\Grid\Rcc\ScriptExecution("Game", $scriptText);

// Check if there is already an open server with status 1 for the same game
$checkServerQuery = $MainDB->prepare("SELECT COUNT(*) FROM open_servers WHERE gameid = :gameid AND status = 1");
$checkServerQuery->execute([":gameid" => $GameId]);
$existingServersCount = $checkServerQuery->fetchColumn();

if ($existingServersCount > 0) {
    // If there is an open server with status 1, exit without creating a new server
    exit();
}

// If no open server with status 1 exists, proceed to create a new server
$jobResult = $RCCServiceSoap->OpenJobEx($job, $script);

// Insert the new server into the open_servers table with status 1
if ($vipowner !== null && $vipowner !== 0) {
	$stmte = "INSERT INTO open_servers (jobid, gameid, status, maxPlayers, playerCount, port, vipID) VALUES (?, ?, 1, ?, 0, ?, ?)";
	$MainDB->prepare($stmte)->execute([$id, $GameId, $Results['maxPlayers'], $porty, $vipowner]);
} else {
$stmte = "INSERT INTO open_servers (jobid, gameid, status, maxPlayers, playerCount, port, vipID) VALUES (?, ?, 1, ?, 0, ?, NULL)";
$MainDB->prepare($stmte)->execute([$id, $GameId, $Results['maxPlayers'], $porty]);
}



echo ($jobResult);
exit();
?>
