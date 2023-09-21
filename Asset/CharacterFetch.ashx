<?php
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
$UserId = (int)($_GET['userId'] ?? die(json_encode(['message' => 'Cannot fetch request at this time.'])));
$WardrobeSrh = $MainDB->prepare("SELECT * FROM bought WHERE boughtby = :id AND itemtype != 'model' AND wearing = '1' AND itemtype != 'advertisement' AND itemtype != 'decal' AND itemtype != 'audio' ORDER BY id");
$WardrobeSrh->execute([":id" => $UserId]);
$ReWDS = $WardrobeSrh->fetchAll();

switch(true) {
    case (!$ReWDS):
        die($baseUrl . "/Asset/BodyColors.ashx?userId=" . $UserId . ";" . $baseUrl . "/Tools/FetchClothing.aspx?id=1&type=S;" . $baseUrl . "/Tools/FetchClothing.aspx?id=3&type=P;");
        break;

    default:
        echo $baseUrl . "/Asset/BodyColors.ashx?userId=" . $UserId . ";";

        foreach ($ReWDS as $AssetInfo) {
            switch ($AssetInfo['itemtype']) {
                case "T-Shirt":
                case "Shirt":
                case "Pants":
                case "Body Colors":
                    echo $baseUrl . "/asset/?id=" . $AssetInfo['boughtid'] . ";";
                    break;

                case "Package":
                    $packageId = $AssetInfo['boughtid'];
                    $packageQuery = $MainDB->prepare("SELECT * FROM package WHERE packageid = :packageId");
                    $packageQuery->execute([':packageId' => $packageId]);
                    $package = $packageQuery->fetch(PDO::FETCH_ASSOC);

                    if ($package) {
                        for ($i = 1; $i <= 5; $i++) {
                            $itemId = $package['id' . $i];
                            if (!empty($itemId)) {
                                echo $baseUrl . "/asset/?id=" . $itemId . ";";
                            }
                        }
                    }
                    break;

                default:
                    echo $baseUrl . "/asset/?id=" . $AssetInfo['boughtid'] . ";";
                    break;
            }
        }
        break;
}
?>
