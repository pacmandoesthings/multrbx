<?php
$robloxplayerbeta_data = file_get_contents('php://input');
//olduseragent User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36
$ch = curl_init();
    
curl_setopt($ch, CURLOPT_URL, 'https://gamejoin.roblox.com/v1/join-game-instance');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_HEADER, false);
curl_setopt($ch, CURLOPT_POSTFIELDS, ''.$robloxplayerbeta_data.''
);

$headers = array();
$headers[] = 'Content-Type: application/json';
$headers[] = 'Accept: application/json';
 $headers[] = 'User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like GeckoRoblox/WinInetRobloxApp/0.548.0.5480523 (GlobalDist; RobloxDirectDownload)';
$headers[] =  'Referer: https://www.roblox.com/';
$headers[] = 'Origin: https://www.roblox.com';
$headers[] = 'Cookie: GuestData=UserID=-1754627726; _gcl_au=1.1.80586835.1665177852; RBXSource=rbx_acquisition_time=10/7/2022 4:24:12 PM&rbx_acquisition_referrer=https://www.roblox.com/&rbx_medium=Direct&rbx_source=www.roblox.com&rbx_campaign=&rbx_adgroup=&rbx_keyword=&rbx_matchtype=&rbx_send_info=1; RBXEventTrackerV2=CreateDate=10/7/2022 4:24:15 PM&rbxid=3560121339&browserid=148161733788; .ROBLOSECURITY=_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-to-steal-your-ROBUX-and-items.|_06132410D7B8E575D4B6EA383E4D8D1FBACD36A0CF01FF4F9155D56DAB3D206D1D766C0582D447B5A3352CC2ECEA68297F6EA51F0180132A20EAE714558E107FE000107370B1CAFFCB087C7A625E06A8691DBFF9B2978BA880D2D454278029CF0B344A435E2C946F42106B4B427585F68DDA1D48EA9ED870B3E49C0C8A46A4A7C0D6C2C4DB75B947144F10E0F200AB9F42CB9ED54348C495AB953DCDE28D82E112FD55998968B85761244F898517CFA057FEDEEA1BDDEE62DA13C22A0BA8437B9C7D7EC60C1DEFE3776587DB808E01433714968087FDFD9F5CD18ACB389ED38891A83BCE02C0005CF4E5D52F18F6FADD41A27D7F5D4FF84E3C0183F2D2204C6F99D13A6788EED1B3DB0F853C35E8CD89069F7BB4E7ED857D3D074BC615F1B6FCDF4F7897A54DEBD2D090298E66E01D5AB81F5B06A9B025DA518D61EFBED736055CF5508B1302A30D2568E9395BC5635E78362BAEB1701F58FA4D181131263892AB3F517273D4CD73CD71650B6299E2CBAB2888CC9A830A78F92E98E07644C578B2AC794CC25444702D69B60D650A2F57C6F0B02F; RBXSessionTracker=sessionid=bf87568d-cd6b-40ce-8719-e4d1ffc5764f'; 
$headers[] = 'x-csrf-token: NT6MKzR4p7LA';  
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
$result = curl_exec($ch);
echo $result;
?>