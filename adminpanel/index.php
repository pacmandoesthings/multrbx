<?php
// Include the Configuration.php file
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');

// Start the session and check if the user is logged in

// Check if the user is logged in
$RBXTICKET = $_COOKIE['ROBLOSECURITY'] ?? null;

switch (true) {
    case ($RBXTICKET == null):
        header("Location: " . $baseUrl . "/");
        die();
        break;
    default:
        // Redirect to the video if $admin is not set to 1
        if ($admin != 1) {
            header("Location: " . $baseUrl . "/adminpanel/video.mp4");
            die();
        }
        break;
}

date_default_timezone_set('Europe/London'); // Set the timezone to British Standard Time

$current_time = date('Y-m-d H:i:s'); // Get current time in the specified format



$webhookurl = "https://discord.com/api/webhooks/1141687515246501980/V9agQ70WqTJ897wy6CESgEM-sMWySVaXKqcuNs4IO13EPU6921Edih4759-_4dAxug-7";

                $json_data = json_encode([
                    "content" => "Admin panel has been accessed by user " .$name. " at the BST time of ".$current_time,
                    "username" => "multrbx",
                    "tts" => false,
                ], JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE );

                $ch = curl_init($webhookurl);
                curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-type: application/json'));
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $json_data);
                curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
                curl_setopt($ch, CURLOPT_HEADER, 0);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                $response = curl_exec($ch);
                curl_close($ch);

// Check if the unban form is submitted
if (isset($_POST['unban_id'])) {
    $unban_id = $_POST['unban_id'];
    $unban_stmt = $MainDB->prepare("UPDATE users SET termtype = null WHERE id = :unban_id");
    $unban_stmt->bindParam(":unban_id", $unban_id, PDO::PARAM_INT);
    $unban_stmt->execute();
}


// Check if the ban server form is submitted
if (isset($_POST['jobid']) && isset($_POST['server_id']) && isset($_POST['ban_server'])) {
    $jobid = $_POST['jobid'];

    // Perform actions to ban the server
    // Add your code here

    // Example actions:
    // 1. Make a GET request to reset the server
    $reset_url = "http://mulrbx.com/reset?jobid=" . urlencode($jobid);
    file_get_contents($reset_url);

    // 2. Make a GET request to close the game
    $gameclose_url = "http://mulrbx.com/soap/amogs/Roblox/gameclose?job=" . urlencode($jobid);
    file_get_contents($gameclose_url);

    // You can perform additional actions or modify the code as needed

    // Redirect or show a success message after banning the server
    header("Location: index.php"); // Modify the URL as per your file name
}

if (isset($_POST['jobid']) && isset($_POST['noot_server'])) {
    $jobid = $_POST['jobid'];
	

    // Perform actions to ban the server
    // Add your code here

    // Example actions:
    // 1. Make a GET request to reset the server
    $reset_url = "https://www.mulrbx.com/soap/amogs/Roblox/pingu?job=".$jobid;
    file_get_contents($reset_url);


    // 2. Make a GET request to close the gam

    // You can perform additional actions or modify the code as needed

    // Redirect or show a success message after banning the server
    header("Location: index.php"); // Modify the URL as per your file name
}


if (isset($_POST['jobid']) && isset($_POST['player_count'])) {
    $jobid = $_POST['jobid'];
    $player_count = $_POST['player_count'];
    $set_player_count_stmt = $MainDB->prepare("UPDATE open_servers SET maxPlayers = :player_count WHERE id = :jobid");
    $set_player_count_stmt->bindParam(":jobid", $jobid, PDO::PARAM_STR);
    $set_player_count_stmt->bindParam(":player_count", $player_count, PDO::PARAM_INT);
    $set_player_count_stmt->execute();
}

// Check if the ban form is submitted
if (isset($_POST['ban_id'])) {
    $ban_id = $_POST['ban_id'];
    $treason = $_POST['treason'];
    $tnote = $_POST['tnote'];
    $ban_stmt = $MainDB->prepare("UPDATE users SET termtype = 'terminated', treason = :treason, tnote = :tnote WHERE id = :ban_id");
    $ban_stmt->bindParam(":ban_id", $ban_id, PDO::PARAM_INT);
    $ban_stmt->bindParam(":treason", $treason, PDO::PARAM_STR);
    $ban_stmt->bindParam(":tnote", $tnote, PDO::PARAM_STR);
    $ban_stmt->execute();
}

// Check if the ban form is submitted
if (isset($_POST['ban_id'])) {
    $ban_id = $_POST['ban_id'];
    $ban_stmt = $MainDB->prepare("UPDATE users SET termtype = 'terminated' WHERE id = :ban_id");
    $ban_stmt->bindParam(":ban_id", $ban_id, PDO::PARAM_INT);
    $ban_stmt->execute();
}

// Check if the place approval form is submitted
if (isset($_POST['approve_id'])) {
    $approve_id = $_POST['approve_id'];
    $approve_stmt = $MainDB->prepare("UPDATE asset SET approved = 1, public = 1 WHERE id = :approve_id AND itemtype = 'place'");
    $approve_stmt->bindParam(":approve_id", $approve_id, PDO::PARAM_INT);
    $approve_stmt->execute();
}

// Check if the give Tix form is submitted
if (isset($_POST['tix_user_id']) && isset($_POST['tix_amount'])) {
    $tix_user_id = $_POST['tix_user_id'];
    $tix_amount = $_POST['tix_amount'];
    $tix_stmt = $MainDB->prepare("UPDATE users SET ticket = ticket + :tix_amount WHERE id = :tix_user_id");
    $tix_stmt->bindParam(":tix_user_id", $tix_user_id, PDO::PARAM_INT);
    $tix_stmt->bindParam(":tix_amount", $tix_amount, PDO::PARAM_INT);
    $tix_stmt->execute();
}

// Check if the give Robux form is submitted
if (isset($_POST['robux_user_id']) && isset($_POST['robux_amount'])) {
    $robux_user_id = $_POST['robux_user_id'];
    $robux_amount = $_POST['robux_amount'];
    $robux_stmt = $MainDB->prepare("UPDATE users SET robux = robux + :robux_amount WHERE id = :robux_user_id");
    $robux_stmt->bindParam(":robux_user_id", $robux_user_id, PDO::PARAM_INT);
    $robux_stmt->bindParam(":robux_amount", $robux_amount, PDO::PARAM_INT);
    $robux_stmt->execute();
}

// Check if the give membership form is submitted
if (isset($_POST['membership_user_id']) && isset($_POST['membership_type'])) {
    $membership_user_id = $_POST['membership_user_id'];
    $membership_type = $_POST['membership_type'];

    // Determine the membership value based on the selected type
    $membership_value = 0;
    switch ($membership_type) {
        case "BuildersClub":
            $membership_value = 1;
            break;
        case "TurboBuildersClub":
            $membership_value = 2;
            break;
        case "OutrageousBuildersClub":
            $membership_value = 3;
            break;
    }

    $membership_stmt = $MainDB->prepare("UPDATE users SET membership = :membership_value WHERE id = :membership_user_id");
    $membership_stmt->bindParam(":membership_user_id", $membership_user_id, PDO::PARAM_INT);
    $membership_stmt->bindParam(":membership_value", $membership_value, PDO::PARAM_INT);
    $membership_stmt->execute();
}

// Retrieve user data from the database
$user_stmt = $MainDB->prepare("SELECT * FROM users");
$user_stmt->execute();
$users = $user_stmt->fetchAll(PDO::FETCH_ASSOC);

// Retrieve asset data from the database
$asset_stmt = $MainDB->prepare("SELECT * FROM asset WHERE itemtype = 'place'");
$asset_stmt->execute();
$assets = $asset_stmt->fetchAll(PDO::FETCH_ASSOC);



$openServer_stmt = $MainDB->prepare("SELECT * FROM open_servers");
$openServer_stmt->execute();
$openServers = $openServer_stmt->fetchAll(PDO::FETCH_ASSOC);




if (isset($_POST['update_notification'])) {
    $notification_type = $_POST['notification_type'];
    $notification_text = $_POST['notification_text'];

    $update_notif_stmt = $MainDB->prepare("UPDATE notification SET type = :type, text = :text WHERE id = 1");
    $update_notif_stmt->bindParam(":type", $notification_type, PDO::PARAM_INT);
    $update_notif_stmt->bindParam(":text", $notification_text, PDO::PARAM_STR);
    $update_notif_stmt->execute();
}

?>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        form {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <h1>Admin Panel</h1>
    <h2>Welcome, <?php echo $name; ?>!</h2>

    <h3>Users</h3>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Status</th>
            <th>Membership</th>
            <th>Action</th>
            <th>Ban Reason</th>
            <th>Ban Note</th>
        </tr>
        <?php foreach ($users as $user) { ?>
            <tr>
                <td><?php echo $user['id']; ?></td>
                <td><?php echo $user['name']; ?></td>
                <td><?php echo $user['email']; ?></td>
                <td><?php echo $user['status']; ?></td>
                <td><?php echo $user['membership']; ?></td>
                <td>
                    <?php if ($user['termtype'] == null) { ?>
                        <form method="POST" action="">
                            <input type="hidden" name="ban_id" value="<?php echo $user['id']; ?>">
                            <input type="text" name="treason" placeholder="Ban Reason">
                            <input type="text" name="tnote" placeholder="Ban Note">
                            <button type="submit">Ban</button>
                        </form>
                    <?php } else { ?>
                        <form method="POST" action="">
                            <input type="hidden" name="unban_id" value="<?php echo $user['id']; ?>">
                            <button type="submit">Unban</button>
                        </form>
                    <?php } ?>
                </td>
                <td><?php echo $user['treason']; ?></td>
                <td><?php echo $user['tnote']; ?></td>
            </tr>
        <?php } ?>
    </table>

    <h3>Assets</h3>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Type</th>
            <th>Action</th>
        </tr>
        <?php foreach ($assets as $asset) { ?>
            <tr>
                <td><?php echo $asset['id']; ?></td>
                <td><?php echo $asset['name']; ?></td>
                <td><?php echo $asset['itemtype']; ?></td>
                <td>
                    <?php if ($asset['approved'] == 0) { ?>
                        <form method="POST" action="">
                            <input type="hidden" name="approve_id" value="<?php echo $asset['id']; ?>">
                            <button type="submit">Approve</button>
                        </form>
                    <?php } ?>
                </td>
            </tr>
        <?php } ?>
    </table>
	
	
<h3>Open Servers</h3>
<table>
    <tr>
        <th>ID</th>
        <th>Game ID</th>
        <th>Status</th>
        <th>Job ID</th>
        <th>Max Players</th>
        <th>Player Count</th>
        <th>Port</th>
        <th>Action</th>
    </tr>
    <?php foreach ($openServers as $server) { ?>
        <tr>
            <td><?php echo $server['id']; ?></td>
            <td><?php echo $server['gameID']; ?></td>
            <td><?php echo $server['status']; ?></td>
            <td><?php echo $server['jobid']; ?></td>
            <td><?php echo $server['maxPlayers']; ?></td>
            <td><?php echo $server['playerCount']; ?></td>
            <td><?php echo $server['port']; ?></td>
            <td>
                <form method="POST" action="">
                    <input type="hidden" name="server_id" value="<?php echo $server['id']; ?>">
                    <input type="hidden" name="jobid" value="<?php echo $server['jobid']; ?>">
                    <button type="submit" name="ban_server">Close Server</button>
                </form>
				<form method="POST" action="">
                    <input type="hidden" name="jobid" value="<?php echo $server['jobid']; ?>">
                    <button type="submit" name="noot_server">C0RRUPT the server</button>
                </form>
            </td>
        </tr>
    <?php } ?>
</table>


<h3>Set Player Count for Open Server</h3>
<form method="POST" action="">
    <input type="text" name="jobid" placeholder="Server ID">
    <input type="number" name="player_count" placeholder="Player Count">
    <button type="submit">Set Player Count</button>
</form>

    <h3>Give Tix</h3>
    <form method="POST" action="">
        <input type="text" name="tix_user_id" placeholder="User ID">
        <input type="number" name="tix_amount" placeholder="Amount">
        <button type="submit">Give Tix</button>
    </form>

    <h3>Give Robux</h3>
    <form method="POST" action="">
        <input type="text" name="robux_user_id" placeholder="User ID">
        <input type="number" name="robux_amount" placeholder="Amount">
        <button type="submit">Give Robux</button>
    </form>

    <h3>Give Membership</h3>
    <form method="POST" action="">
        <input type="text" name="membership_user_id" placeholder="User ID">
        <select name="membership_type">
            <option value="BuildersClub">Builders Club</option>
            <option value="TurboBuildersClub">Turbo Builders Club</option>
            <option value="OutrageousBuildersClub">Outrageous Builders Club</option>
        </select>
        <button type="submit">Give Membership</button>
    </form>
	
	
	<h3>Update Notification</h3>
<form method="POST" action="">
    <select name="notification_type">
        <option value="1">Type 1</option>
        <option value="2">Type 2</option>
        <option value="3">Type 3</option>
        <option value="4">Type 4</option>
    </select>
    <input type="text" name="notification_text" placeholder="Notification Text">
    <button type="submit" name="update_notification">Update Notification</button>
</form>

</body>
</html>
