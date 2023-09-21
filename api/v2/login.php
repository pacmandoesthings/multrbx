<?php
header('content-type: application/json');
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');

// Assuming you have already connected to the database and have the $MainDB PDO variable.

// Function to check if the term type indicates the user is banned or terminated.


// Check if there is any input data in the request body.
$inputData = file_get_contents('php://input');
if (!empty($inputData)) {
    // Assuming the data is sent as JSON.
    $requestData = json_decode($inputData, true);

    // Check if the required fields are present in the JSON data.
    $username = $requestData["username"] ?? '';
    $password = $requestData["password"] ?? '';

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
                    // Create a PHP associative array with the data.
                    $jsonData = [
                        "membershipType" => 4,
                        "username" => $username,
                        "isUnder13" => false,
                        "countryCode" => "US",
                        "userId" => intval($result['id']),
                        "displayName" => $username
                    ];
$expiration_time = time() + (7 * 365 * 24 * 60 * 60);

// Set the cookies with the new expiration time
setcookie("ROBLOSECURITY", $result['token'], $expiration_time, "/", "mulrbx.com");
setcookie(".ROBLOSECURITY", $result['token'], $expiration_time, "/", "mulrbx.com");
                    // Encode the array into JSON format using C#-like syntax.
                    $jsonString = json_encode($jsonData);

                    // Output the JSON response.
                    echo $jsonString;
                } else {
                    echo json_encode([
                        "errors" => [
                            [
                                "code" => 1,
                                "message" => "Incorrect username or password. Please try again.",
                                "userFacingMessage" => "Something went wrong"
                            ]
                        ]
                    ]);
                }
            } else {
                echo json_encode([
                    "errors" => [
                        [
                            "code" => 1,
                            "message" => "User not found.",
                            "userFacingMessage" => "Something went wrong"
                        ]
                    ]
                ]);
            }
        } catch (PDOException $e) {
            echo json_encode([
                "errors" => [
                    [
                        "code" => 1,
                        "message" => "Database error: " . $e->getMessage(),
                        "userFacingMessage" => "Something went wrong"
                    ]
                ]
            ]);
        }
    } else {
        echo json_encode([
            "errors" => [
                [
                    "code" => 1,
                    "message" => "Missing username or password in the request body.",
                    "userFacingMessage" => "Something went wrong"
                ]
            ]
        ]);
    }
} else {
    echo json_encode(["error" => "No data found in the request body."]);
}
?>
