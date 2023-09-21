<?php
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
$UserIdid= (int)($_GET['id'] ?? die(json_encode(['message' => 'Cannot fetch request at this time.'])));

$i = 0;


			echo $baseUrl . "/asset/?id=" . $UserIdid . ";";

?>