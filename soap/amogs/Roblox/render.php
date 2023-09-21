<?php
include 'Grid/Rcc/RCCServiceSoap.php';
include 'Grid/Rcc/rccrender.php';
include 'Grid/Rcc/Job.php';
include 'Grid/Rcc/ScriptExecution.php';
include 'Grid/Rcc/LuaType.php';
include 'Grid/Rcc/LuaValue.php';
include 'Grid/Rcc/Status.php';

$id = $_GET["id"];
$redirect = ($_GET["redirect"] ?? true); // Default to true if not specified

$RCC = new Roblox\Grid\Rcc\RCCRenderer("127.0.0.1", 48434);

$path1 = $_SERVER['DOCUMENT_ROOT'] . '/Tools/RenderedUsers/' . $id . '.png';
$path2 = $_SERVER['DOCUMENT_ROOT'] . '/Tools/RenderedUsers/' . $id . '-closeup' . '.png';

$newURL = "http://mulrbx.com/My/Character.aspx";

$jobidNormal = "RENDER_NORMAL_" . substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"), 0, 10);
$jobNormal = new Roblox\Grid\Rcc\Job($jobidNormal, 60);

$jobidCloseup = "RENDER_CLOSEUP_" . substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"), 0, 10);
$jobCloseup = new Roblox\Grid\Rcc\Job($jobidCloseup, 60);

$scriptTextNormal = file_get_contents('avat.lua') . " return start(\"" . $id . "\",\"" . $_SERVER['SERVER_NAME'] . "\");";
$scriptNormal = new Roblox\Grid\Rcc\ScriptExecution("Render", $scriptTextNormal);
$jobResultNormal = $RCC->OpenJobEx($jobNormal, $scriptNormal);

$scriptTextCloseup = file_get_contents('avatcloseup.lua') . " return start(\"" . $id . "\");";
$scriptCloseup = new Roblox\Grid\Rcc\ScriptExecution("Render", $scriptTextCloseup);
$jobResultCloseup = $RCC->OpenJobEx($jobCloseup, $scriptCloseup);

$imgNormal = base64_decode($jobResultNormal[0]);
$imgCloseup = base64_decode($jobResultCloseup[0]);

file_put_contents($path1, $imgNormal);
file_put_contents($path2, $imgCloseup);

if ($redirect !== "false") {
	 $RCCServiceSoap->CloseJob($jobNormal);
	 $RCCServiceSoap->CloseJob($jobCloseup);
    header('Location: ' . $newURL);
} else {
    // Output the contents of the PNG files
		 $RCCServiceSoap->CloseJob($jobNormal);
	 $RCCServiceSoap->CloseJob($jobCloseup);
    header('Content-Type: image/png');
    readfile($path1); // You can choose to output normal or closeup here based on your requirement
}
?>
