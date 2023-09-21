<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/FuncTypes.php');
header("content-type: text/plain");
$AssetID = (int)(($_GET['id'] ?? $_GET['assetversionid']) ?? die(json_encode(["message" => "Unable to process request."])));

function fetchAssetContent($AssetID) {
    $assetURL = 'https://assetdelivery.roblox.com/v1/asset/?id=' . $AssetID;
    $assetContent = file_get_contents($assetURL);
    if ($assetContent !== false) {
        return $assetContent;
    }
    return null;
}

$AssetFetch = $MainDB->prepare("SELECT * FROM asset WHERE id = :pid");
$AssetFetch->execute([":pid" => $AssetID]);
$Results = $AssetFetch->fetch(PDO::FETCH_ASSOC);

$AssetType = ($Results['itemtype'] ?? null);

switch ($AssetType) {
    case "CoreScript":
        switch (file_exists($_SERVER["DOCUMENT_ROOT"] . "/asset/" . $AssetID)) {
            case true:
                $file = file_get_contents($_SERVER["DOCUMENT_ROOT"] . "/asset/" . $AssetID);
                sign("\r\n" . $file);
                break;
            default:
                die(json_encode(['message' => 'Requested asset was not found.']));
        }
        break;
    default:
        switch (file_exists($_SERVER["DOCUMENT_ROOT"] . "/asset/" . $AssetID)) {
            case true:
                $file = file_get_contents($_SERVER["DOCUMENT_ROOT"] . "/asset/" . $AssetID);

                while (substr($file, 0, 1) === "{") {
                    $json = json_decode($file, true);
                    if (isset($json['assetId'])) {
                        $AssetID = (int)$json['assetId'];
                        $file = fetchAssetContent($AssetID);
                    } else {
                        break;
                    }
                }

                // Replace "roblox.com" with "mulrbx.com" in the file content
                $file = str_replace('roblox.com', 'mulrbx.com', $file);

                // Set appropriate headers for file download
                header('Content-Type: application/octet-stream');
                header('Content-Disposition: attachment; filename="' . $AssetID . '"');

                // Output the file content
                echo $file;

                // Save the updated asset content to the local directory
                $localFilePath = $_SERVER["DOCUMENT_ROOT"] . "/asset/" . $AssetID;
                file_put_contents($localFilePath, $file);
                break;

            default:
                // Download the asset from mulrbx.com and save it locally
                $assetContent = fetchAssetContent($AssetID);

                while ($assetContent !== null && substr($assetContent, 0, 1) === "{") {
                    $json = json_decode($assetContent, true);
                    if (isset($json['assetId'])) {
                        $AssetID = (int)$json['assetId'];
                        $assetContent = fetchAssetContent($AssetID);
                    } else {
                        break;
                    }
                }

                if ($assetContent !== null) {
                    // Replace "roblox.com" with "mulrbx.com" in the downloaded content
                    $assetContent = str_replace('roblox.com', 'mulrbx.com', $assetContent);

                    // Set appropriate headers for file download
                    header('Content-Type: application/octet-stream');
                    header('Content-Disposition: attachment; filename="' . $AssetID . '"');

                    // Output the downloaded content
                    echo $assetContent;

                    // Save the downloaded asset content to the local directory
                    $localFilePath = $_SERVER["DOCUMENT_ROOT"] . "/asset/" . $AssetID;
                    file_put_contents($localFilePath, $assetContent);
                } else {
                    die(json_encode(['message' => 'Requested asset was not found.']));
                }
                break;
        }
        break;
}
?>
