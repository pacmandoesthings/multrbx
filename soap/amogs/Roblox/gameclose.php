<?php 
include 'Grid/Rcc/RCCServiceSoap.php';
 include 'Grid/Rcc/Job.php';
 include 'Grid/Rcc/ScriptExecution.php';
 include 'Grid/Rcc/LuaType.php';
 include 'Grid/Rcc/LuaValue.php';
 include 'Grid/Rcc/Status.php';
    include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
   $job = $_GET['job'];

  

  


 
  
 $RCCServiceSoap = new Roblox\Grid\Rcc\RCCServiceSoap("127.0.0.1", 56217);
 $RCCServiceSoap->CloseJob($job);




$webhookurl = "https://discord.com/api/webhooks/1141687515246501980/V9agQ70WqTJ897wy6CESgEM-sMWySVaXKqcuNs4IO13EPU6921Edih4759-_4dAxug-7";


$timestamp = date("c", strtotime("now"));

$json_data = json_encode([
    "content" => "Game Closed. Job ID: ".$job,
    "username" => "multrbx",
    "tts" => false,
], JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE );


$ch = curl_init( $webhookurl );
curl_setopt( $ch, CURLOPT_HTTPHEADER, array('Content-type: application/json'));
curl_setopt( $ch, CURLOPT_POST, 1);
curl_setopt( $ch, CURLOPT_POSTFIELDS, $json_data);
curl_setopt( $ch, CURLOPT_FOLLOWLOCATION, 1);
curl_setopt( $ch, CURLOPT_HEADER, 0);
curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1);

$response = curl_exec( $ch );
curl_close( $ch );

?>