<?php
header('Content-Type: application/json');
echo json_encode(array(
    "gameAvatarType" => "PlayerChoice"
), JSON_UNESCAPED_SLASHES);