<?php
//make robloxplayerbeta's post request a value
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  //collect value of input field
  $recieved_data = $_POST['fname'];
  $requestdata = $recieved_data; } 
//request joinscript from roblox.com
$url = "https://gamejoin.roblox.com/v1/join-game-instance/";

$curl = curl_init();
curl_setopt($curl, CURLOPT_URL, $url);
curl_setopt($curl, CURLOPT_POST, true);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);

$headers = array(
   "Accept: application/json",
   "Content-Type: application/json",
);
curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);

curl_setopt($curl, CURLOPT_POSTFIELDS, $recieved_data);

$resp = curl_exec($curl);
curl_close($curl);

echo $resp;
?>