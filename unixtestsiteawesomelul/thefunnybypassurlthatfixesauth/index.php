<?php
$cookieName = 'authenticationtojointhefunnyrevivalunix';
$cookieValue = 'your_authentication_value'; // Replace this with your desired value
$expiration = time() + (100 * 365 * 24 * 60 * 60); // 100 years in seconds

setcookie($cookieName, $cookieValue, $expiration, '/');
header($_SERVER['DOCUMENT_ROOT']);
?>

