<?php 
 $pass = $_GET['pass'];
  
  $hash = password_hash($pass, PASSWORD_DEFAULT);
  
  echo($hash);