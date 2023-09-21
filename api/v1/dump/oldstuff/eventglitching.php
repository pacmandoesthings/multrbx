<?Php
$placeid = addslashes($_GET["placeid"]);
echo "it appears you are trying to eventglitch once again, well, here's your places!";
$test = file_get_contents("http://api.sitetest4.robloxlabs.com/universes/get-universe-containing-place/?placeid=$placeid");
echo $test['UniverseId'];
?>