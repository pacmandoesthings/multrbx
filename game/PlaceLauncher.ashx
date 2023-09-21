<?php
// Include necessary files
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/FuncTypes.php');
include($_SERVER['DOCUMENT_ROOT'] . '/UserInfo.php');

// Set the response content type to JSON
header("content-type: application/json");

// Get the 'placeId', 'request', 'token', and 'lua' parameters from the request URL
$placeId = (int) ($_GET['placeId'] ?? die(json_encode(["message" => "Cannot process request at this time."])));
$request = $_GET['request'] ?? die(json_encode(["message" => "Cannot process your request at this time. Try again later."]));
$token = $_GET['token'] ?? null;
$lua = $_GET['lua'] ?? null;
$isTeleport = ($_GET['isTeleport'] ?? null);
$isVipServer = (int)($_GET['VipServOwner'] ?? null);

// Set whether guests are allowed or not
$guests = false; // Set to true or false to allow or disallow guests

// Check if the game exists in the database
$GetGameInfo = $MainDB->prepare("SELECT id, maxPlayers FROM asset WHERE approved = '1' AND id = :pid AND itemtype = 'place'");
$GetGameInfo->execute([':pid' => $placeId]);
$GameInfo = $GetGameInfo->fetch(PDO::FETCH_ASSOC);

// Check if there is an open server with available slots for the game
$GetOpenServer = $MainDB->prepare("SELECT playerCount, maxPlayers, jobid, status, vipID FROM open_servers WHERE gameID = :pid AND vipID IS NULL AND playerCount < maxPlayers");
$GetOpenServer->execute([':pid' => $placeId]);
$OpenServer = $GetOpenServer->fetch(PDO::FETCH_ASSOC);

// Set the default status to 0 (no open server with available slots)
$status = 0;

// If there is an open server with available slots and the status is 1, set status to 0
if ($OpenServer && $OpenServer['status'] == 1) {
    $status = 0;
}

// If there is an open server with available slots and the status is 2, set status to 2
if ($OpenServer && $OpenServer['status'] == 2) {
    $status = 2;
}

// Check if the user has a valid token
$cookieName = isset($_COOKIE['.ROBLOSECURITY']) ? '.ROBLOSECURITY' : 'ROBLOSECURITY';
if (isset($_COOKIE[$cookieName])) {
    $VerifyUser = $MainDB->prepare("SELECT token FROM users WHERE token = :token");
    $VerifyUser->execute([':token' => $_COOKIE[$cookieName]]);
    $Verification = $VerifyUser->fetch(PDO::FETCH_ASSOC);

    if ($Verification !== false) {
        $token = $_COOKIE[$cookieName];
    }
}

// Process the response based on the status of the open server

// If there is an open server with available slots
if ($OpenServer && $OpenServer['playerCount'] !== $OpenServer['maxPlayers']) {
    // An open server is available with available slots and the game is not full

    // Check the request type and allow the user to join the game
    switch ($request) {
        case "RequestGame":
        case "RequestGameJob": // Add RequestGameJob case
            // Allow the user to join since the game is not full
            if ($token) {
                $joinScript = "http://mulrbx.com/Game/join.ashx?placeId=" . $placeId . "&joinType=" . ($lua ? "json" : "json") . "&jobid=".$OpenServer['jobid']."&TokenPlay=" . $token;
            } else {
                if ($guests) {
                    $joinScript = $baseUrl . "/Game/joinguest.ashx?placeId=" . $placeId . "&joinType=" . ($lua ? "json" : "json") . "&jobid=".$OpenServer['jobid'];
                } else {
                    die(json_encode(["message" => "Guests are not allowed in this game."]));
                }
            }

            // Respond with the required JSON for joining the game
            die(json_encode([
                "jobId" => $OpenServer['jobid'],
                "status" => $status, // Set the status based on the status of the open server
                "joinScriptUrl" => $joinScript,
                "authenticationUrl" => "http://mulrbx.com/Login/Negotiate.ashx",
                "authenticationTicket" => null
            ], JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK));
            break;
        default:
            // Return a generic response for other request types
            die(json_encode([
                "jobId" => null,
                "status" => 1, // Set the status to 1 since the game has available slots
                "joinScriptUrl" => null,
                "authenticationUrl" => null,
                "authenticationTicket" => "Guest:0"
            ], JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK));
            break;
    }
}

// No open server available or game is full
// Create a new open server (Note: There's a URL in the code, but it's not complete, so I'm just including it as a placeholder)
$url = "http://mulrbx.com/startelgameserversexlmao.php?id=" . $placeId;
if ($isVipServer !== null && $isVipServer !== 0) {
$url = "http://mulrbx.com/startelgameserversexlmao.php?VipOwner=".$isVipServer."&id=" . $placeId;
}
file_get_contents($url);

// Check if a new open server was created
$GetNewOpenServer = $MainDB->prepare("SELECT playerCount, jobid, status FROM open_servers WHERE gameID = :pid");
$GetNewOpenServer->execute([':pid' => $placeId]);
$NewOpenServer = $GetNewOpenServer->fetch(PDO::FETCH_ASSOC);

if ($NewOpenServer) {
    // A new open server was created

    // Determine the status based on the player count and maxPlayers of the game
    if ($NewOpenServer['playerCount'] >= $GameInfo['maxPlayers']) {
        $status = 6; // Maximum players reached
    } else {
        $status = 0; // Game has available slots
    }

    // Check the request type and allow the user to join the game
    if ($token) {
        $joinScript = "http://mulrbx.com/Game/join.ashx?placeId=" . $placeId . "&joinType=" . ($lua ? "json" : "json") . "&jobid=".$NewOpenServer['jobid']."&TokenPlay=" . $token;
    } else {
        if ($guests) {
            $joinScript = $baseUrl . "/Game/joinguest.ashx?placeId=" . $placeId . "&joinType=" . ($lua ? "json" : "json") . "&jobid=".$NewOpenServer['jobid'];
        } else {
            die(json_encode(["message" => "Guests are not allowed in this game."]));
        }
    }

    // Respond with the required JSON for joining the game
    die(json_encode([
        "jobId" => $NewOpenServer['jobid'],
        "status" => $status, // Set the status based on the player count and maxPlayers
        "joinScriptUrl" => $joinScript,
        "authenticationUrl" => "http://mulrbx.com/Login/Negotiate.ashx",
        "authenticationTicket" => null
    ], JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK));
} else {
    // No new open server found
    // Determine the status based on the player count and maxPlayers of the game
    $status = ($GameInfo && $GameInfo['maxPlayers'] > 0) ? 6 : 0; // Check if maxPlayers is greater than zero
    die(json_encode([
        "jobId" => null,
        "status" => $status,
        "joinScriptUrl" => null,
        "authenticationUrl" => null,
        "authenticationTicket" => null
    ], JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK));
}
?>
