<?Php 
header("content-type:text/plain");
$v1 = 1;
$opts = array(
  'http'=>array(
    'method'=>"GET",
    'header'=>"Accept-language: en\r\n" .
              "Cookie: PHPSESSID=ccd0ce4d566c36e2881063d3cded4e13"
  )
);
$context = stream_context_create($opts);
while(true){$v1 = $v1 + 1; if($v1 > 50000){break;}; echo "Got GRINCHBLOX Auth Ticket->"; echo file_get_contents("https://gchblox.tk/data/makeauthticket.php",false,$context);};
?>
