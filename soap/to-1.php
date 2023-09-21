<?php
/*
  * Server
  */
class TestSoapServer
{
    public function getMessage()
    {
        return 'print("hi")';
    }
}
$options = ['uri' => 'http://181.215.226.46:53640/'];
$server = new SoapServer(null, $options);
$server->setClass('TestSoapServer');
$server->handle();

?>

