

<?php


// regular form processing here!
  include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
  include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
  
   function random_shit(
    int $length = 16,
    string $keyspace = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
  ): string {
    if ($length < 1) {
      throw new \RangeException("Length must be a positive integer");
    }
    $pieces = [];
    $max = mb_strlen($keyspace, '8bit') - 1;
    for ($i = 0; $i < $length; ++$i) {
      $pieces []= $keyspace[random_int(0, $max)];
    }
    return implode('', $pieces);
  };
  
  $used = 0;
  $ref = "MultRBXKey-" . random_shit();
 
 
 $sql = "INSERT INTO refkeys (creator, refkey, used) VALUES (?,?,?)";
$stmt= $MainDB->prepare($sql);
$stmt->execute([$id, $ref, $used]);
 
 $elkey = $ref;
 
  
  
  
  ?>


<!DOCTYPE html>
<html>
<body>


<input type="text" value="<?php echo $elkey; ?>" id="myInput">
<button onclick="myFunction()">Copy text</button>

<script>
  window.onload = function() {
  myFunction();
};
function myFunction() {
  // Get the text field
  var copyText = document.getElementById("myInput");

  // Select the text field
  copyText.select();
  copyText.setSelectionRange(0, 99999); // For mobile devices

  // Copy the text inside the text field
  navigator.clipboard.writeText(copyText.value);
  
  // Alert the copied text
  alert("Copied the text: " + copyText.value);
}
</script>

</body>
</html>




