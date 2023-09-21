<?php  
  function sign($data) {
    include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
    $PrivKey = file_get_contents($_SERVER['DOCUMENT_ROOT'] . "/game/howthefuckcananyonefindthis.pem");
    openssl_sign($data, $signature, $PrivKey, OPENSSL_ALGO_SHA1);
    switch($SignType){
      case "2":
        echo sprintf("%%%s%%%s", base64_encode($signature), $data);
        break;
      default:
        echo sprintf("--rbxsig%%%s%%%s", base64_encode($signature), $data);
        break;
    }
  }
  
 
  
  function random_tkn(
    int $length = 64,
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
  }
  
  function getGameBar($num1, $num2){
    $PlusTotal = $num1 + $num2;
    switch(true){case($PlusTotal == 0):return 0;break;}
    $TotalGraph = 100 * $num1 / $PlusTotal;
    return $TotalGraph;
  }
  
  function appCheckRedirect($State){
    include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
    switch(true){
      case (in_array($_SERVER['HTTP_USER_AGENT'], $rbxUserAgent)):
        switch($State){
          case "Games":
            die(header("Location: ". $baseUrl ."/MobileView/Games.aspx"));
            break;
          case "Catalog":
            die(header("Location: ". $baseUrl ."/MobileView/Catalog/"));
            break;
          case "Profile":
            die(header("Location: ". $baseUrl ."/MobileView/My/Home.aspx"));
            break;
          default:
            die(header("Location: ". $baseUrl ."/MobileView/My/Home.aspx"));
            break;
        }
        break;
    }
  }
?>
