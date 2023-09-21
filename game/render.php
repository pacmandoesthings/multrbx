<?php

$b64 = $_GET['b64'];
$id = $_GET['id'];

// Obtain the original content (usually binary data)
$bin = base64_decode($b64);

// Gather information about the image using the GD library
$size = getImageSizeFromString($bin);

// Check the MIME type to be sure that the binary data is an image
if (empty($size['mime']) || strpos($size['mime'], 'image/') !== 0) {
  die('Base64 value is not a valid image');
}

// Mime types are represented as image/gif, image/png, image/jpeg, and so on
// Therefore, to extract the image extension, we subtract everything after the “image/” prefix
$ext = substr($size['mime'], 6);

// Make sure that you save only the desired file extensions
if (!in_array($ext, ['png', 'gif', 'jpeg'])) {
  die('Unsupported image type');
}

$img_file = '../Tools/RenderedUsers/6.png';


file_put_contents($img_file, $bin);



