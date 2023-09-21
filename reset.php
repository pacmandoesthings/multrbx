<?php
  include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/FuncTypes.php');
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');

$jobIdToDelete = $_GET['jobid'];

$deleteQuery = "DELETE FROM open_servers WHERE jobid = :jobId";
$deleteStatement = $MainDB->prepare($deleteQuery);
$deleteStatement->execute([':jobId' => $jobIdToDelete]);




