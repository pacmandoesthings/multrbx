<?php
  error_reporting(E_ALL);
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/UserInfo.php');
include($_SERVER['DOCUMENT_ROOT'] . '/FuncTypes.php');
$GameId = (int)($_GET['id'] ?? die(header('Location: '. $baseUrl .'/RobloxDefaultErrorPage.aspx')));

$GameFetch = $MainDB->prepare("SELECT * FROM asset WHERE id = :pid AND itemtype = 'place'");
$GameFetch->execute([":pid" => $GameId]);
$Results = $GameFetch->fetch(PDO::FETCH_ASSOC);
  
$TokenFetch = $MainDB->prepare("SELECT token FROM users WHERE id = :uid");
$TokenFetch->execute([":uid" => $id]);
$ResultsT = $TokenFetch->fetch(PDO::FETCH_ASSOC);

switch(true){case(!$Results):die(header('Location: '. $baseUrl .'/RobloxDefaultErrorPage.aspx'));break;}

$GamePort = $Results['port'];
  
  echo($GamePort);

  
  
  
  ?>