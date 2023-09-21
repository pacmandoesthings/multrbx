<?php

header('Content-Type: application/json');

function FilterText(string $text) 
{
    $badlist = array("equinox");
    $filterCount = sizeof($badlist);
    for ($i = 0; $i < $filterCount; $i++) {
        $text = preg_replace_callback('/(' . $badlist[$i] . ')/i', function($matches) {
            return str_repeat('#', strlen($matches[0]));
        }, $text);
    }
    return $text;
}

// Check if the 'apiKey' parameter is present and not empty
if (isset($_GET['apiKey']) && !empty($_GET['apiKey'])) {
    $apiKey = $_GET['apiKey'];
} else {
    $apiKey = 'filtertext.php'; // Default value if 'apiKey' is missing or empty
}

$text = $_POST['text'];
$userid = $_POST['userId'];

$textog = FilterText($text);

$return = json_encode(array(
    "success" => true,
    "data" => array(
        "AgeUnder13" => $textog,
        "Age13OrOver" => $textog
    )
), JSON_UNESCAPED_SLASHES);

echo $return;
