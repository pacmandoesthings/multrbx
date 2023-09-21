<?php
$cookieName = 'authenticationtojointhefunnyrevivalunix';
$userAgent = $_SERVER['HTTP_USER_AGENT'];


if (
    !isset($_COOKIE[$cookieName]) ||
    (strpos($userAgent, 'Roblox') !== false) ||
    (strpos($userAgent, 'WinInet') !== false)
) {
    die('You are not authenticated in UNIX! Please authenticate.');
}

?>
