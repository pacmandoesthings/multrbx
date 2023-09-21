<?php
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
include($_SERVER['DOCUMENT_ROOT'] . '/UserInfo.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/ContextHeader.php');
switch (true) {
    case ($RBXTICKET == null):
        die(header("Location: " . $baseUrl . "/"));
        break;
}

// Create the body_colours table if it doesn't exist

// Function to generate color options
function generateColorOptions($selectedColor)
{
    $colorOptions = array(
        'Bright red' => 21,
        'Bright blue' => 23,
        'Bright yellow' => 24,
        'Bright green' => 37,
        'Bright orange' => 106,
        'Bright violet' => 104,
        'Bright pink' => 221,
        'Light reddish violet' => 103,
        'Light stone grey' => 208,
        'Medium stone grey' => 194,
        'Buttermilk' => 341,
        // Additional realistic colors
        'Black' => 26,
        'White' => 1,
        'Dark stone grey' => 199,
        'Medium stone grey' => 194,
        'Light stone grey' => 208,
        'Toothpaste' => 1019
        // Add more colors here if needed
    );

    foreach ($colorOptions as $optionLabel => $optionValue) {
        $selected = ($selectedColor == $optionValue) ? 'selected' : '';
        echo "<option value='$optionValue' $selected>$optionLabel</option>";
    }
}

// Handle form submission
if (isset($_POST['submit'])) {
    try {
        // Get selected color values
        $headColor = $_POST['head_color'];
        $torsoColor = $_POST['torso_color'];
        $leftArmColor = $_POST['left_arm_color'];
        $rightArmColor = $_POST['right_arm_color'];
        $leftLegColor = $_POST['left_leg_color'];
        $rightLegColor = $_POST['right_leg_color'];

        // Prepare and execute SQL statement to insert colors into the database
        $stmt = $MainDB->prepare("INSERT INTO body_colours (uid, h, t, la, ll, rl, ra) VALUES (?, ?, ?, ?, ?, ?, ?)
                                    ON DUPLICATE KEY UPDATE h = VALUES(h), t = VALUES(t), la = VALUES(la), 
                                    ll = VALUES(ll), rl = VALUES(rl), ra = VALUES(ra)");
        $stmt->execute([$id, $headColor, $torsoColor, $leftArmColor, $leftLegColor, $rightLegColor, $rightArmColor]);
        exit; // Add this line to stop execution after redirection
    } catch (PDOException $e) {
        echo "Error: " . $e->getMessage();
    }
}

// Retrieve saved body colors for the user
$stmt = $MainDB->prepare("SELECT * FROM body_colours WHERE uid = ?");
$stmt->execute([$id]);
$result = $stmt->fetch(PDO::FETCH_ASSOC);

// Set default values if no colors are saved
$headColor = $result ? $result['h'] : '808080';
$torsoColor = $result ? $result['t'] : '808080';
$leftArmColor = $result ? $result['la'] : '808080';
$rightArmColor = $result ? $result['ra'] : '808080';
$leftLegColor = $result ? $result['ll'] : '808080';
$rightLegColor = $result ? $result['rl'] : '808080';
?>
<!DOCTYPE html>
<html>
<head>
    <title>Shitty Ass Avatar</title>
    <style>
        h1 {
            text-align: center;
        }

        .color-selector {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 30px;
        }

        h2 {
            font-size: 18px;
            margin-bottom: 10px;
        }

        .color-box {
            width: 100px;
            height: 100px;
            margin-bottom: 10px;
            border: 1px solid #000;
            cursor: pointer;
        }

        #color-box-head {
            background-color: <?php echo '#' . $headColor; ?>;
        }

        #color-box-torso {
            background-color: <?php echo '#' . $torsoColor; ?>;
        }

        #color-box-leftArm {
            background-color: <?php echo '#' . $leftArmColor; ?>;
        }

        #color-box-rightArm {
            background-color: <?php echo '#' . $rightArmColor; ?>;
        }

        #color-box-leftLeg {
            background-color: <?php echo '#' . $leftLegColor; ?>;
        }

        #color-box-rightLeg {
            background-color: <?php echo '#' . $rightLegColor; ?>;
        }
    </style>
</head>
<body>
    <h1>Shitty Ass Body Colors</h1>
    <center><img title="<?php echo $name; ?>" alt="<?php echo $name; ?>" border="0" height="210" width="210" src="<?php echo "". $baseUrl ."/Tools/Asset.ashx?id=". $id ."&request=avatar"; ?>"><center>

    <div class="color-selector">
        <h2>Body Color</h2>
        <form method="POST" action="">
            <div>
                <label for="head_color">Head:</label>
                <select name="head_color" id="head_color">
                    <?php generateColorOptions($headColor); ?>
                </select>
            </div>
            <div>
                <label for="torso_color">Torso:</label>
                <select name="torso_color" id="torso_color">
                    <?php generateColorOptions($torsoColor); ?>
                </select>
            </div>
            <div>
                <label for="left_arm_color">Left Arm:</label>
                <select name="left_arm_color" id="left_arm_color">
                    <?php generateColorOptions($leftArmColor); ?>
                </select>
            </div>
            <div>
                <label for="right_arm_color">Right Arm:</label>
                <select name="right_arm_color" id="right_arm_color">
                    <?php generateColorOptions($rightArmColor); ?>
                </select>
            </div>
            <div>
                <label for="left_leg_color">Left Leg:</label>
                <select name="left_leg_color" id="left_leg_color">
                    <?php generateColorOptions($leftLegColor); ?>
                </select>
            </div>
            <div>
                <label for="right_leg_color">Right Leg:</label>
                <select name="right_leg_color" id="right_leg_color">
                    <?php generateColorOptions($rightLegColor); ?>
                </select>
            </div>
            <br>
            <input type="submit" name="submit" value="Apply">
        </form>
    </div>

    <script>
        // Apply the colors to the dummy
        document.getElementById('color-box-head').addEventListener('click', function() {
            document.getElementById('color-box-head').style.backgroundColor = '#' + document.getElementById('head_color').value;
        });
        document.getElementById('color-box-torso').addEventListener('click', function() {
            document.getElementById('color-box-torso').style.backgroundColor = '#' + document.getElementById('torso_color').value;
        });
        document.getElementById('color-box-leftArm').addEventListener('click', function() {
            document.getElementById('color-box-leftArm').style.backgroundColor = '#' + document.getElementById('left_arm_color').value;
        });
        document.getElementById('color-box-rightArm').addEventListener('click', function() {
            document.getElementById('color-box-rightArm').style.backgroundColor = '#' + document.getElementById('right_arm_color').value;
        });
        document.getElementById('color-box-leftLeg').addEventListener('click', function() {
            document.getElementById('color-box-leftLeg').style.backgroundColor = '#' + document.getElementById('left_leg_color').value;
        });
        document.getElementById('color-box-rightLeg').addEventListener('click', function() {
            document.getElementById('color-box-rightLeg').style.backgroundColor = '#' + document.getElementById('right_leg_color').value;
        });
    </script>
</body>
</html>
