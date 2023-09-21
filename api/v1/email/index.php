<?php
require ("/new/xampp/htdocs/corescripts/settings.php");
header("content-type:text/plain");
?>
{"emailAddress":"<?php echo $email ?>","verified":true,"canBypassPasswordForEmailUpdate":true}