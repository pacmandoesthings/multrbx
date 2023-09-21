<?php
header("Content-Type: application/json");
$data = [

        "robux" => 400,
		"tickets" => 400
];

$json = json_encode($data);

echo $json;
?>
