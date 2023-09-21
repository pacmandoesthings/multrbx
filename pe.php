<?php
header("content-type:text/plain");

// Combine both GET and POST parameters
$parameters = array_merge($_GET, $_POST);

// Build the query string
$queryString = http_build_query($parameters);

// Construct the new URL
$newURL = 'https://ecsv2.roblox.com/pe?' . $queryString;

// Initialize cURL session
$ch = curl_init();

// Set cURL options
curl_setopt($ch, CURLOPT_URL, $newURL);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

// Execute cURL session
$response = curl_exec($ch);

// Check for cURL errors
if ($response === false) {
    echo 'cURL error: ' . curl_error($ch);
    // Optionally, you can handle the error here
} else {
    // Output the fetched content
    echo $response;
}

// Close cURL session
curl_close($ch);
?>
