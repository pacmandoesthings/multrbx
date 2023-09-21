<?php header("Content-Type: application/json");
$token = $_GET['token']; ?>
{"jobId":"Test","status":2,"joinScriptUrl":"http://mulrbx.com/game/joinsalsa.ashx?TokenPlay=<?php echo $token; ?>&placeId=2&jobid=test&joinType=json","authenticationUrl":"http://mulrbx.com/Login/Negotiate.ashx","authenticationTicket":"SomeTicketThatDosentCrash","message":""}