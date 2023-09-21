<?php
include 'Grid/Rcc/RCCServiceSoap.php';
include 'Grid/Rcc/Job.php';
include 'Grid/Rcc/ScriptExecution.php';
include 'Grid/Rcc/LuaType.php';
include 'Grid/Rcc/LuaValue.php';
include 'Grid/Rcc/Status.php';
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');


   $job = $_GET['job'];
   
   
$RBXTICKET = $_COOKIE['ROBLOSECURITY'] ?? null;

switch (true) {
    case ($RBXTICKET == null):
        header("Location: " . $baseUrl . "/");
        die();
        break;
    default:
        // Redirect to the video if $admin is not set to 1
        if ($admin != 1) {
            header("Location: " . $baseUrl . "/adminpanel/video.mp4");
            die();
        }
        break;
}   



$RCCServiceSoap = new Roblox\Grid\Rcc\RCCServiceSoap("127.0.0.1", 56217);

$scriptText = file_get_contents('nootnoot.lua');
$script = new Roblox\Grid\Rcc\ScriptExecution("Get Fucked", $scriptText);


// If no open server with status 1 exists, proceed to create a new server
$jobResult = $RCCServiceSoap->Execute($job, $script);


exit();
?>
