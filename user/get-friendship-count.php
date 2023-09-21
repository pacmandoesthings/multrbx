<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
header("content-type:text/plain");


$userId = (int)($_GET['userId'] ?? die(json_encode(["message" => "Cannot process request at this time."])));


$GameFetch = $MainDB->prepare("SELECT * FROM users WHERE id = :pid");
$GameFetch->execute([":pid" => $userId]);
$Results = $GameFetch->fetch(PDO::FETCH_ASSOC);

switch(true){case(!$Results):die(json_encode(["success" => false]));break;}

echo json_encode(["success" => true, "message" => "Success", "count" => $Results['friends']]);







