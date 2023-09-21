<?php
header('Content-Type: application/json');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');

 function OwnsAsset(int $userid, $assetid)
        {
			include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');

            $ownership = $MainDB->prepare("SELECT COUNT(*) FROM `bought` WHERE `boughtid` = :assetid AND `boughtby` = :userid");
            $ownership->bindParam(":assetid", $assetid, PDO::PARAM_INT);
            $ownership->bindParam(":userid", $userid, PDO::PARAM_INT);
            $ownership->execute();
            if($ownership->fetchColumn() > 0) {
                return true;
            }
            return false;
        }

$userid = $_GET['userId'];
$assetId = $_GET['assetId'];

if (OwnsAsset($userid, $assetId) || isOwner($assetId, $userid))
{
    echo(json_encode(true));
}
else
{
    echo(json_encode(false));
}