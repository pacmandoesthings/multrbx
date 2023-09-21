<?php
  error_reporting(0);
ini_set('display_errors', 0);
  include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/FuncTypes.php');
$GameId = (int)($_GET['id'] ?? die(header('Location: '. $baseUrl .'/RobloxDefaultErrorPage.aspx')));

$GameFetch = $MainDB->prepare("SELECT * FROM asset WHERE id = :pid AND itemtype = 'place'");
$GameFetch->execute([":pid" => $GameId]);
$Results = $GameFetch->fetch(PDO::FETCH_ASSOC);
  
  
file_get_contents("http://181.215.226.46/rcc/runrcc.php?placeid=". $GameId ."&deathtoall=0");
exit();
  

  
  
  