<?php
    include 'Grid/Rcc/RCCServiceSoap.php';
    include 'Grid/Rcc/rccrender.php';
 include 'Grid/Rcc/Job.php';
 include 'Grid/Rcc/ScriptExecution.php';
 include 'Grid/Rcc/LuaType.php';
 include 'Grid/Rcc/LuaValue.php';
 include 'Grid/Rcc/Status.php';
  $id = $_GET["id"];
 $RCC= new Roblox\Grid\Rcc\RCCRenderer("127.0.0.1", 48434);
 $path = $_SERVER['DOCUMENT_ROOT'] . '/Tools/RenderedUsers/'.$id.'.png';
  $newURL = "http://mulrbx.com/My/Colours.aspx";
 



       $jobid = "RENDER_".substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"), 0, 10);

            $job = new Roblox\Grid\Rcc\Job($jobid,60);
$scriptText = file_get_contents('avat.lua') . " return start(\"" . $id . "\"" . ",\"http://" . $_SERVER['SERVER_NAME'] . "\");";
  $script = new Roblox\Grid\Rcc\ScriptExecution("Render", $scriptText);
        $jobResult = $RCC->OpenJobEx($job, $script);

                $img = base64_decode($jobResult[0]);
  file_put_contents($path ,$img);
  

  header('Location: '.$newURL);
  




   
              
  
        
  

 







