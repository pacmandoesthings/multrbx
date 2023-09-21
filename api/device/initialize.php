<?php
header("content-type: application/json; charset=utf-8");
header("server: envoy");
header("set-cookie: RBXAppDeviceIdentifier=AppDeviceIdentifier=null; domain=mulrbx.com; path=/");
header("strict-transport-security: max-age=3600");
header("x-envoy-upstream-service-time: 3");
header("x-roblox-region: us-central");
header("x-roblox-edge: sjc1");
header('report-to: {"group":"network-errors","max_age":604800,"endpoints":[{"url":"https://ncs.roblox.com/upload"}]}');
header('nel: {"report_to":"network-errors","max_age":604800,"success_fraction":0.001,"failure_fraction":1}');
?>
{"browserTrackerId":1234567890,"appDeviceIdentifier":null}