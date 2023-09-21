<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
$id = $_GET['id'];
$job = $_GET['jobid'];
$port = $_GET['port'];

$GameFetch = $MainDB->prepare("SELECT * FROM asset WHERE id = :pid AND itemtype = 'place'");
$GameFetch->execute([":pid" => $id]);
$Results = $GameFetch->fetch(PDO::FETCH_ASSOC);

// Update the status to 2 for rows with matching port and jobid
$updateStatusQuery = $MainDB->prepare("UPDATE open_servers SET status = 2 WHERE port = :port AND jobid = :jobid");
$updateStatusQuery->execute([":port" => $port, ":jobid" => $job]);
?>

<?php


$webhookurl = "https://discord.com/api/webhooks/1141687515246501980/V9agQ70WqTJ897wy6CESgEM-sMWySVaXKqcuNs4IO13EPU6921Edih4759-_4dAxug-7";


$timestamp = date("c", strtotime("now"));

$json_data = json_encode([
    "content" => "Game Started! Game Name : ".$Results['name']." Job ID: ".$job,
    "username" => "multrbx",
    "tts" => false,
], JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE );


$ch = curl_init( $webhookurl );
curl_setopt( $ch, CURLOPT_HTTPHEADER, array('Content-type: application/json'));
curl_setopt( $ch, CURLOPT_POST, 1);
curl_setopt( $ch, CURLOPT_POSTFIELDS, $json_data);
curl_setopt( $ch, CURLOPT_FOLLOWLOCATION, 1);
curl_setopt( $ch, CURLOPT_HEADER, 0);
curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1);

$response = curl_exec( $ch );
curl_close( $ch );

?>
