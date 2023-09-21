<?php include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
//TO NOTE: studio's browser dosen't seem to unset the cookie properly.
//if we try to get rid of the cookie, it simply changes the value to "deleted".
//we have to check for this value and turn it into null so the entirety of the site dosent go apeshit.
switch(true){
  case (isset($_COOKIE['ROBLOSECURITY'])):
    $RBXTICKET = $_COOKIE['ROBLOSECURITY'];
    switch ($RBXTICKET){case "deleted":$RBXTICKET = null;break;case (strpos($RBXTICKET, " ")):$RBXTICKET = null;break;}
    break;
  default:
    $RBXTICKET = null;
    break;
}

switch(true){
  case ($RBXTICKET !== null):
    $GetInfo = $MainDB->prepare("SELECT id, name, ticket, robux, nextrobuxgive, termtype, treason, tnote, tdate, email, emailverified, membership, friends, creationdate, admin, theme FROM users WHERE token = :token");
    $GetInfo->execute([':token' => $RBXTICKET]);
    $Info = $GetInfo->fetch(PDO::FETCH_ASSOC);
    $id = ($Info['id'] ?? null);
    $name = ($Info['name'] ?? null);
    $ticket = ($Info['ticket'] ?? null);
    $robux = ($Info['robux'] ?? null);
    $termtype = ($Info['termtype'] ?? null);
    $termreason = ($Info['treason'] ?? null);
    $termnote = ($Info['tnote'] ?? null);
    $termdate = ($Info['tdate'] ?? null);
    $email = ($Info['email'] ?? null);
    $reward = ($Info['nextrobuxgive'] ?? null);
    $verified = ($Info['emailverified'] ?? null);
    $membership = ($Info['membership'] ?? null);
    $friendapi = ($Info['friends'] ?? null);
    $birthdate = ($Info['creationdate'] ?? null);
	$admin = ($Info['admin'] ?? null);
	$theme = ($Info['theme'] ?? null);
    switch(true){case($friendapi !== null):$friends = explode(';', $Info['friends']);break;default:$friends = array();break;}
    switch(true){case ($name == null):header('Location: '. $baseUrl .'/Login/Logout.ashx?returnUrl=/');break;}
    switch (true){case ($termtype !== null):switch ($CurrPage){case ($CurrPage !== "/IDE/NotApproved.aspx"):header("Location: ". $baseUrl . "/IDE/NotApproved.aspx");die();break;}break;}
    break;
  default:
    $id = null;
    $name = null;
    $robux = null;
    $reward = null;
    $ticket = null;
    $termtype = null;
    $termreason = null;
    $termnote = null;
    $termdate = null;
    $email = null;
    $verified = null;
    $membership = null;
    $friends = null;
    $birthdate = null;
	$admin = null;
	$theme = null;
    break;
}
?>
