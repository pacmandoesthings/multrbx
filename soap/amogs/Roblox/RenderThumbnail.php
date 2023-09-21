<?php


    include 'Grid/Rcc/RCCServiceSoap.php';
 include 'Grid/Rcc/Job.php';
 include 'Grid/Rcc/ScriptExecution.php';
 include 'Grid/Rcc/LuaType.php';
 include 'Grid/Rcc/LuaValue.php';
 include 'Grid/Rcc/Status.php';
  include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
      $GameId = (int)($_GET['id'] ?? die(header('Location: '. $baseUrl .'/RobloxDefaultErrorPage.aspx')));

   $path = $_SERVER['DOCUMENT_ROOT'] . '/Tools/RenderedAssets/'.$GameId.'.png';

  

 $GameFetch = $MainDB->prepare("SELECT * FROM asset WHERE id = :pid");
$GameFetch->execute([":pid" => $GameId]);
$Results = $GameFetch->fetch(PDO::FETCH_ASSOC);




 $RCCServiceSoap = new Roblox\Grid\Rcc\RCCServiceSoap("127.0.0.1", 48434);
  $id = "CLOTHING_".substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"), 0, 10);
$job = new Roblox\Grid\Rcc\Job($id,700000);
       
        $scriptText = file_get_contents('clothing_render.lua') . " return start(\"" . $GameId . "\"" . ",\"http://" . $_SERVER['SERVER_NAME'] . "\");";
        $script = new Roblox\Grid\Rcc\ScriptExecution("Clothing", $scriptText);
        $jobResult = $RCCServiceSoap->OpenJobEx($job, $script);
		
		
		                $img = base64_decode($jobResult[0]);
  file_put_contents($path ,$img);
  