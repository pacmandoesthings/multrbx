<?php
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');

// patching teds shitty ass code

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    // signup request made aka posted
    $user_name = $_POST['user_name'];
    $password = $_POST['password'];

    if (!empty($user_name) && !empty($password) && !is_numeric($user_name)) {
        // read from database
        try {

include($_SERVER['DOCUMENT_ROOT'] . '/config.php');

            $query = "SELECT * FROM users WHERE name = :user_name LIMIT 1";
            $statement = $MainDB->prepare($query);
            $statement->bindParam(':user_name', $user_name);
            $statement->execute();

            $result = $statement->fetch(PDO::FETCH_ASSOC);

            if ($result) {
                if (password_verify($password, $result['password'])) {
                    // credentials are okay
                    $data = array('status' => 203, 'message' => 'Success');
                    header("HTTP/1.0 203 Success");
                    echo json_encode($data);
                    return;
                }
            }
        } catch (PDOException $e) {
            echo "Connection failed: " . $e->getMessage();
        }
    }
}
?>
