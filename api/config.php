<?php

$baseUrl = "https://".$_SERVER['SERVER_NAME'];
$domainUrl = $_SERVER['SERVER_NAME'];

//for ios/android, it allows you to disable that annoying "Upgrade Me" popup
$allowedVersions = array('AppAndroidV2.234.70767','AppAndroidV2.276.102913','AppAndroidV2.158.48944','AppAndroidV2.275.102906','AppAndroidV2.166.50996','AppAndroidV2.237.72017','AppAndroidV2.269.94916','AppAndroidV2.270.96141');
$rbxUserAgent = array('Mozilla/5.0 (3946MB; 1600x900; 240x240; 1066x600; Samsung go fuck yourself; 9) AppleWebKit/537.36 (KHTML, like Gecko)  ROBLOX Android App 2.269.94916 Tablet Hybrid()');
$allowedmd5hashes = array('2b4ba7fc-5843-44cf-b107-ba22d3319dcd');

$hostdb = "127.0.0.1";
$accdb = "multrbx";
$passdb = "LszD73wJ2@vcNK(P";
$namedb = "multrbxnew";

$SignType = 1; // 1 for rbxsig, 2 for no rbxsig
$Offline = false;
$CurrPage = $_SERVER["REQUEST_URI"];
$StarterID = 20; //Put in here your starterscript's asset id!
$AssetRedirect = true;
$CurrentVersion = "version-27973050fb3b494f";

$AdminList = array("1","6","11");

switch($Offline){
  case true:
    switch ($CurrPage){
      case ($CurrPage !== "/IDE/Maintenance.ashx"):
        header("Location: ". $baseUrl . "/IDE/Maintenance.ashx");
        die();
        break;
    }
    break;
}

$MainDB = new PDO("mysql:host=$hostdb;dbname=$namedb", $accdb, $passdb);
$MainDB->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
?>