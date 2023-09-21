<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/FuncTypes.php');
header("content-type: application/json");

$placeId = (int) ($_GET['placeId'] ?? die(json_encode(["message" => "Cannot process request at this time."])));
$request = $_GET['request'] ?? die(json_encode(["message" => "Cannot process your request at this time. Try again later."]));
$token = $_GET['token'] ?? die(json_encode(["message" => "Cannot process your request at this time. Try again later."]));

// Check if the game exists
$GetGameInfo = $MainDB->prepare("SELECT id, maxPlayers FROM asset WHERE approved = '1' AND id = :pid AND itemtype = 'place'");
$GetGameInfo->execute([':pid' => $placeId]);
$GameInfo = $GetGameInfo->fetch(PDO::FETCH_ASSOC);

$GetOpenServer = $MainDB->prepare("SELECT playerCount, maxPlayers, jobid FROM open_servers WHERE gameID = :pid AND playerCount < maxPlayers");
$GetOpenServer->execute([':pid' => $placeId]);
$OpenServer = $GetOpenServer->fetch(PDO::FETCH_ASSOC);

if ($OpenServer && $OpenServer['playerCount'] !== $OpenServer['maxPlayers']) {
    // An open server is available with available slots and the game is not full
    switch ($request) {
        case "RequestGame":
        case "RequestGameJob": // Add RequestGameJob case
            // Allow the user to join since the game is not full
            if ($token) {
                $joinScript = $baseUrl . "/Game/join.ashx?placeId=" . $placeId . "&joinType=json&jobid=".$OpenServer['jobid']."&TokenPlay=" . $token;
            } else {
                $joinScript = $baseUrl . "/Game/joinguest.ashx?placeId=" . $placeId . "&joinType=json&jobid=".$OpenServer['jobid'];
            }

            die(json_encode([
                "jobId" => $OpenServer['jobid'],
                "status" => 2,
                "joinScriptUrl" => $joinScript,
                "authenticationUrl" => "http://mulrbx.com/Login/Negotiate.ashx",
                "authenticationTicket" => null
            ], JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK));
            break;
        default:
            // Return a generic response for other request types
            die(json_encode([
                "jobId" => null,
                "status" => 1,
                "joinScriptUrl" => null,
                "authenticationUrl" => null,
                "authenticationTicket" => "Guest:0"
            ], JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK));
            break;
    }
}

// No open server available or game is full
$url = "http://mulrbx.com/startelgameserversexlmao.php?id=" . $placeId;
file_get_contents($url);

// Check if a new open server was created
$GetNewOpenServer = $MainDB->prepare("SELECT playerCount, jobid FROM open_servers WHERE gameID = :pid");
$GetNewOpenServer->execute([':pid' => $placeId]);
$NewOpenServer = $GetNewOpenServer->fetch(PDO::FETCH_ASSOC);

if ($NewOpenServer) {
    // A new open server was created
    if ($NewOpenServer['playerCount'] >= $GameInfo['maxPlayers']) {
        $status = 6; // Maximum players reached
    } else {
        $status = 0; // Game has available slots
    }

    if ($token) {
        $joinScript = $baseUrl . "/Game/join.ashx?placeId=" . $placeId . "&joinType=json&jobid=".$NewOpenServer['jobid']."&TokenPlay=" . $token;
    } else {
        $joinScript = $baseUrl . "/Game/joinguest.ashx?placeId=" . $placeId . "&joinType=json&jobid=".$NewOpenServer['jobid'];
    }

    die(json_encode([
        "jobId" => $NewOpenServer['jobid'],
        "status" => $status,
        "joinScriptUrl" => $joinScript,
        "authenticationUrl" => "http://mulrbx.com/Login/Negotiate.ashx",
        "authenticationTicket" => null
    ], JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK));
}

// No new open server found
die(json_encode([
    "jobId" => null,
    "status" => 6,
    "joinScriptUrl" => null,
    "authenticationUrl" => null,
    "authenticationTicket" => null
], JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK));
?>
