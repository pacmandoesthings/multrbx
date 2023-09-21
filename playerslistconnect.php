<?php
include($_SERVER['DOCUMENT_ROOT'] . '/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/UserInfo.php'); 
include($_SERVER['DOCUMENT_ROOT'] . '/ProdLogin.php');

$stmt = $MainDB->prepare("UPDATE `open_servers` SET `playerCount` = ? WHERE `jobid` = ?");
$stmt->execute([$_GET['players'],$_GET['jobid']]);

  ?>