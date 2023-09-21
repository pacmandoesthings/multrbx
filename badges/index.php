<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
header("content-type:text/plain");


if (isset($_SERVER['PATH_INFO'])) {
    $pathInfo = $_SERVER['PATH_INFO'];
    // Remove the leading slash from the path
    $badgeId = ltrim($pathInfo, '/');
	
    $GameFetch = $MainDB->prepare("SELECT * FROM badge WHERE id = :pid");
    $GameFetch->execute([":pid" => $badgeId]);
    $Results = $GameFetch->fetch(PDO::FETCH_ASSOC);
	
	
	$GameFetch2 = $MainDB->prepare("SELECT * FROM asset WHERE id = :pid AND itemtype = 'place'");
    $GameFetch2->execute([":pid" => $Results['badgeplace']]);
    $Results2 = $GameFetch2->fetch(PDO::FETCH_ASSOC);

    if ($Results) {
        $jsonData = [
            "id" => $Results['id'],
            "name" => $Results['name'],
            "description" => $Results['moreinfo'],
            "displayName" => $Results['name'],
            "displayDescription" => $Results['name'],
            "enabled" => true,
            "iconImageId" => $Results['id'],
            "displayIconImageId" => $Results['id'],
            "created" => null,
            "updated" => null,
            "statistics" => [
                "pastDayAwardedCount" => 0,
                "awardedCount" => 1646,
                "winRatePercentage" => 0
            ],
            "awardingUniverse" => [
                "id" => $Results['badgeplace'],
                "name" => $Results2['name'],
                "rootPlaceId" => $Results['badgeplace']
            ]
        ];

        $encodedData = json_encode($jsonData);
        echo $encodedData;
    } else {
        die(json_encode(["success" => false]));
    }
}
