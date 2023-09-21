<?php
    include 'Grid/Rcc/RCCServiceSoap.php';
 include 'Grid/Rcc/Job.php';
 include 'Grid/Rcc/ScriptExecution.php';
 include 'Grid/Rcc/LuaType.php';
 include 'Grid/Rcc/LuaValue.php';
 include 'Grid/Rcc/Status.php';
  include($_SERVER['DOCUMENT_ROOT'] . '/config.php');

  $GameId = (int)($_GET['id'] ?? die(header('Location: '. $baseUrl .'/RobloxDefaultErrorPage.aspx')));
  
$GameFetch = $MainDB->prepare("SELECT * FROM asset WHERE id = :pid AND itemtype = 'place'");
$GameFetch->execute([":pid" => $GameId]);
$Results = $GameFetch->fetch(PDO::FETCH_ASSOC);
  
$domain = "mulrbx.com";

switch(true){case(!$Results):die(header('Location: '. $baseUrl .'/RobloxDefaultErrorPage.aspx'));break;}

$porty = file_get_contents("http://mulrbx.com/portdetect.php?id=" . $GameId);


 $RCCServiceSoap = new Roblox\Grid\Rcc\RCCServiceSoap("37.143.61.72", 64989);
  $id = "GAME_".substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"), 0, 10);
$job = new Roblox\Grid\Rcc\Job($id,700000);
       
        $scriptText = file_get_contents('gameserver3.lua') . " start(\"".$_GET['id']."\",\"". $porty ."\",\"http://".$_SERVER['SERVER_NAME']."\");";
        $script = new Roblox\Grid\Rcc\ScriptExecution("Game", $scriptText);
        $jobResult = $RCCServiceSoap->OpenJobEx($job, $script);
        echo($jobResult);
  
 $stmte = "UPDATE asset SET jobid= ? WHERE id= ?";
$MainDB->prepare($stmte)->execute([$id, $GameId]);

echo("everything worked");
  
  exit();

  






