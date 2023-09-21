<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/ContextHeader.php');  

// Assuming you have a PDO database connection object named $MainDB

// Query to retrieve the XML data from the user_reports table
$query = "SELECT report FROM user_reports";

// Prepare and execute the query
$stmt = $MainDB->prepare($query);
$stmt->execute();

// Initialize an empty variable to store the HTML tables
$tables = '';

// Iterate through the result rows
while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    // Get the XML data from the current row
    $xmlString = $row['report'];

    // Check if the XML data is not empty
    if (!empty($xmlString)) {
        // Load the XML string
        $xml = simplexml_load_string($xmlString);

        // Extract the necessary data from the XML
        $userID = (string)$xml['userID'];
        $placeID = (string)$xml['placeID'];
        $gameJobID = (string)$xml['gameJobID'];

        // Extract the comment content
        $comment = (string)$xml->comment;

        // Extract additional information from the XML
        preg_match('/AbuserID:([0-9]+)/', $comment, $abuserIDMatches);
        $abuserID = isset($abuserIDMatches[1]) ? trim($abuserIDMatches[1]) : '';

        preg_match('/Swearing;([^;]+)/', $comment, $swearingMatches);
        $swearing = isset($swearingMatches[1]) ? trim($swearingMatches[1]) : '';

        // Create an HTML table to display the extracted data for the current row
        $table = '<table border="1">
                    <tr>
                        <th>userID</th>
                        <th>placeID</th>
                        <th>gameJobID</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Comment</th>
                        <th>AbuserID</th>
                        <th>Swearing</th>
                    </tr>
                    <tr>
                        <td>'.$userID.'</td>
                        <td>'.$placeID.'</td>
                        <td>'.$gameJobID.'</td>
                        <td>'.$title.'</td>
                        <td>'.$description.'</td>
                        <td>'.$comment.'</td>
                        <td>'.$abuserID.'</td>
                        <td>'.$swearing.'</td>
                    </tr>
                </table>';

        // Append the table to the overall tables string
        $tables .= $table;
    }
}

// Check if any tables were generated
if (!empty($tables)) {
    // Output the tables
    echo $tables;
} else {
    echo "No XML data found in the user_reports table.";
}
?>
