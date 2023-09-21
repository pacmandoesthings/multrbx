<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
$xml = file_get_contents('php://input');

$validXML = true;
try {
    new SimpleXMLElement($xml);
} catch (Exception $e) {
    $validXML = false;
}

if ($validXML) {
    $report = $MainDB->prepare("INSERT INTO `user_reports`(`report`, `whenReported`) VALUES(:report, UNIX_TIMESTAMP())");
    $report->bindParam(":report", $xml, PDO::PARAM_STR);
    $report->execute();
}