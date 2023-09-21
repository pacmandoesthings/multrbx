<?php
header('Content-type: image/png');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');

$errimg = file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/Images/IDE/not-approved.png");
$penimg = file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/Images/IDE/pending.png");

$id = (int) ($_GET['id'] ?? null);
if ($id === 0) {
    $id = (int) ($_GET['AssetID'] ?? null);
}

if ($id === 0) {
    die($errimg);
}

$request = ($_GET['request'] ?? null);

// Check if the image exists in RenderedAssets directory
$renderedImagePath = $_SERVER['DOCUMENT_ROOT'] . "/Tools/RenderedAssets/" . $id . ".png";
if (file_exists($renderedImagePath)) {
    die(file_get_contents($renderedImagePath));
} else {
    // Fetch from mulrbx.com
    $mulrbxImageUrl = "https://mulrbx.com/asset/?id=" . $id;
    $mulrbxImageData = file_get_contents($mulrbxImageUrl);

    if ($mulrbxImageData !== false) {
        // Save the fetched image locally
        file_put_contents($renderedImagePath, $mulrbxImageData);
        // Output the fetched image
        die($renderedImagePath);
    } else {
        die($penimg);
    }
}
?>
