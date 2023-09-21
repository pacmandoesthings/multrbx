<?php
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
include($_SERVER['DOCUMENT_ROOT'] . '/UserInfo.php');
switch (true) {
    case ($RBXTICKET == null):
        die(header('Location: ' . $baseUrl . '/Tools/ShowPopup.aspx?Err=4'));
        break;
}

$WearItem = (int) ($_GET['id'] ?? die(header('Location: ' . $baseUrl . '/Tools/ShowPopup.aspx?Err=5')));
$RequestType = ($_GET['RequestType'] ?? die(header('Location: ' . $baseUrl . '/Tools/ShowPopup.aspx?Err=5')));

$WardrobeSrh = $MainDB->prepare("SELECT * FROM bought WHERE boughtid = :id AND boughtby = :bid AND itemtype != 'model' AND itemtype != 'advertisement' AND itemtype != 'decal' AND itemtype != 'audio' ORDER BY id DESC LIMIT 6");
$WardrobeSrh->execute([":id" => $WearItem, ":bid" => $id]);
$ReWDS = $WardrobeSrh->fetchAll();

switch (true) {
    case (!$ReWDS):
        die(header('Location: ' . $baseUrl . '/Tools/ShowPopup.aspx?Err=5'));
        break;
}

switch ($RequestType) {
    case "WearItem":
        $UpdateDB = $MainDB->prepare("UPDATE bought SET wearing = '1' WHERE boughtid=? AND boughtby=?")->execute([$WearItem, $id]);

        // Load the URL in the background
        file_get_contents('http://mulrbx.com/soap/amogs/roblox/render.php?id='.$id);

        die(header('Location: ' . $baseUrl . '/My/Character.aspx'));
        break;
    case "UnWearItem":
        $UpdateDB = $MainDB->prepare("UPDATE bought SET wearing = null WHERE boughtid=? AND boughtby=?")->execute([$WearItem, $id]);

        // Load the URL in the background
        file_get_contents('http://mulrbx.com/soap/amogs/roblox/render.php?id='.$id);

        die(header('Location: ' . $baseUrl . '/My/Character.aspx'));
        break;
    default:
        die(header('Location: ' . $baseUrl . '/Tools/ShowPopup.aspx?Err=5'));
        break;
}
?>
