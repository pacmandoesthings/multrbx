<?php
header('content-type: application/json');
header('Content-Length: 86');
header('Keep-Alive: timeout=5, max=100');
header('Connection: Keep-Alive');
include($_SERVER['DOCUMENT_ROOT'] . '../config.php');
// Assuming you have already connected to the database and have the $MainDB PDO variable.

// Function to check if the term type indicates the user is banned or terminated.
function isBanned($termType)
{
    return ($termType === 'banned' || $termType === 'terminated');
}

// Check if the request is a POST request.
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Assuming the request body contains x-www-form-urlencoded data with the fields "username" and "password".
    $username = $_POST["username"] ?? '';
    $password = $_POST["password"] ?? '';

    // Check if the required fields are present.
    if (!empty($username) && !empty($password)) {
        try {
            // Assuming the table name is 'users' and the username and password are stored securely in the database.
            $query = "SELECT id, token, termtype, status, password 
                      FROM users 
                      WHERE name = :username";
            $stmt = $MainDB->prepare($query);
            $stmt->bindParam(':username', $username);
            $stmt->execute();
            $result = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($result) {
                // Verify the provided password with the hashed password from the database.
                if (password_verify($password, $result['password'])) {
                    // Mapping the database values to the JSON structure.
                    $jsonArray = [
                        "userId" => intval($result['id']),
                        "name" => $username,
                        "displayName" => $username,
                        "twoStepVerificationData" => [
                            "mediaType" => 0,
                            "ticket" => $result['token']
                        ],
                        "identityVerificationLoginTicket" => $result['token'],
                        "isBanned" => isBanned($result['termtype']),
                        "accountBlob" => $result['status']
                    ];
                    // Calculate the expiration time for 7 years
$expiration_time = time() + (7 * 365 * 24 * 60 * 60);

// Set the cookies with the new expiration time
setcookie("ROBLOSECURITY", $result['token'], $expiration_time, "/", "mulrbx.com");
setcookie(".ROBLOSECURITY", $result['token'], $expiration_time, "/", "mulrbx.com");



                    // Encode the array into JSON format.
                    $jsonData = json_encode($jsonArray, JSON_PRETTY_PRINT);

                    // Output the JSON data.
                    echo $jsonData;

                } else {
                    echo json_encode(["error" => "Incorrect password."]);
                }
            } else {
                echo json_encode(["error" => "User not found."]);
            }
        } catch (PDOException $e) {
            echo "Error: " . $e->getMessage();
        }
    } else {
        echo json_encode(["error" => "Invalid request. Please provide 'username' and 'password' parameters."]);
    }
} else {
    echo json_encode(["error" => "Invalid request method. This endpoint only accepts POST requests."]);
}
?>
