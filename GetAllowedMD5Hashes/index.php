<?php
header("Content-Type: application/json");
$AllowedMD5 = array(
'907f41117e4873b2fbf737646a81c7a7',
'e6683d5c8cfff5cfa542522c6d86d884',
'2fb590211bbbd34ee87c7178aab42e66',
'5b22d3b714a417b22ae42d43284cc2e7',
'e6683d5c8cfff5cfa542522c6d86d884',
'fd936c6ac9121dadace26c1636ad8d67',
'0efa4e4e89bfd0b4b8fbdd05fbca53b6',
'741f6630b5d63b98921df14e5e77ceb8',
'5aeaa4f9015a864943af93df61963dda',
'12e778b85cdacfd1d3b73b109750fbe4',
'890f791310ea33a4a12e3c14e31bb81b',
'cbd8cd49b6e17afc9a5d11d39f719156'
);
$FullJson = ['data' => $AllowedMD5];
die(json_encode($FullJson));
?>