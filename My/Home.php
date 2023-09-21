<?php
 $caca = false; 
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
include($_SERVER['DOCUMENT_ROOT'] . '/UserInfo.php');
include($_SERVER['DOCUMENT_ROOT'] . '/My/SettingsAPI/AccountUpdate.php');
appCheckRedirect("Profile");
switch(true){case ($RBXTICKET == null):die(header("Location: ". $baseUrl ."/"));break;}
$AssignFriends = " OR ";
$i = 0;

foreach($friends as $friendid){
  $i++;
  switch(true){
    case (empty($friends)):
      $AssignFriends = "";
      break;
    case ($i > 1):
      $AssignFriends = $AssignFriends . " OR `creatorid` = '". $friendid ."'";
      break;
    default:
      $AssignFriends = $AssignFriends . "`creatorid` = '". $friendid ."'";
      break;
  }
}

$FeedSearch = $MainDB->prepare("SELECT * FROM feed WHERE announcement = '0' ORDER BY id DESC LIMIT 69420");
$FeedSearch->execute();
$Results = $FeedSearch->fetchAll();

$FeedASearch = $MainDB->prepare("SELECT * FROM feed WHERE announcement = '1' ORDER BY id DESC LIMIT 15");
$FeedASearch->execute();
$AnnouncementResults = $FeedASearch->fetchAll();
if($caca) {
  die($id);
}

if ($reward < time()) {
  $rewardlol = "UPDATE users SET robux = robux + ?, nextrobuxgive = ? WHERE id= ?";
  $dailyreward = 80;
  $nextrew = time() + 86400;
  $robxgivlol = $MainDB->prepare($rewardlol);
  $robxgivlol->execute([$dailyreward, $nextrew, $id]);
} 
?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/js/IncludeJS.php'); ?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>MULTRBX - Welcome</title>

<style>
  /* Add your custom styles here */

  /* Improve overall layout */
  body {
    background-color: #f8f9fa;
    font-family: Arial, sans-serif;
  }

  /* Adjust margins and padding */
  .card-main {
    margin: 20px;
    padding: 30px;
  }

  .card-blurb {
    margin-top: 20px;
  }

  .card-feed {
    margin-top: 20px;
  }

  /* Update font size */
  .big {
    font-size: 36px;
  }

  /* Adjust avatar size */
  .feed-message-avatar {
    width: 48px;
    height: 48px; /* Add this line to make the avatar image square */
  }

  /* Improve feed container */
  .feed-container {
    border: 1px solid #ddd;
    padding: 10px;
    margin-bottom: 10px;
    background-color: #fff;
  }

  /* Style the share button */
  .share-button {
    background-color: #007bff;
    border-color: #007bff;
    color: #fff;
  }
  
   .user-avatar-container {
    width: 50px; /* Adjust the width as desired */
    height: 250px; /* Adjust the height as desired */
  }

  /* Style error message */
  .error-message {
    background-color: #f8d7da;
    border-color: #f5c6cb;
    color: #721c24;
    padding: 10px;
    margin-bottom: 10px;
  }
</style>

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
</head>
<body>
  <div id="Container">
    <?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/ContextHeader.php'); ?>
    <div class="card-main">
      <h1 class="big">Hello, <span class="notranslate"><?php echo $name; ?></span>!</h1>
      <div class="row">
        <div class="col-md-3">
          <div class="card">
            <div class="card-body">
              <div class="user-avatar-container">
                <div id="UserAvatar" class="thumbnail-holder" style="width:210px; height:210px;">
                  <div class="roblox-avatar-image image-medium" data-image-size="custom" data-image-size-x="210" data-image-size-y="210" data-no-click="true" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="MisteriousKapote">
                    <div style="position: relative;">
                      <center><img title="<?php echo $name; ?>" alt="<?php echo $name; ?>" border="0" height="290" width="290" src="<?php echo "". $baseUrl ."/Tools/Asset.ashx?id=". $id ."&request=avatar"; ?>"><center>
                    </div>
                  </div>
                </div>
                <div id="UserInfo" class="text">
                  <br clear="all">
                  <br class="rbx2hide">
                  <div></div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <form method="POST" action="<?php echo $CurrPage; ?>">
            <div id="statusUpdateBox" class="card status-update">
              <div class="card-body">
                <input name="txtStatusMessage" type="text" id="txtStatusMessage" maxlength="254" class="translate form-control status-textbox" placeholder="What are you up to?">
                <button type="submit" id="updatestatus" name="updatestatus" class="btn btn-primary share-button">Share</button>
              </div>
            </div>
          </form>
          <?php
          switch (true) {
            case ($AnnouncementResults):
              foreach ($AnnouncementResults as $FeedInfo) {
                $fcontent = $FeedInfo['content'];
                echo '
                <div id="FeedificationsContainer">
                  <h2>Updates from MULTRBX</h2>
                  <div class="card feedification">
                    <div class="card-body">
                      <div class="row">
                        <div class="col-md-2">
                          <img src="../smallest.png" alt="" width="28" height="48" class="feed-message-avatar">
                        </div>
                        <div class="col-md-10">
                          <h3>'. htmlspecialchars($FeedInfo['announcementtitle']) .'</h3>
                          <div>'. $fcontent .'</div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>';
              }
              break;
          }
          ?>
          <div id="FeedContainer" class="card feed-container">
            <h2>My Feed</h2>
            <div id="FeedPanel">
              <div id="AjaxFeed" class="card-body">
                <?php
                switch (true) {
                  case ($Results):
                    foreach ($Results as $FeedInfo) {
                      echo '
                      <div class="feed-container">
                        <div class="row">
                          <div class="col-md-2">
                            <a href="'. $baseUrl .'/User.php?id='. $FeedInfo['creatorid'] .'" class="feed-asset">
                              <img class="feed-asset-image" title="'. $FeedInfo['creatorname'] .'" alt="'. $FeedInfo['creatorname'] .'" border="0" height="48" width="48" src="'. $baseUrl .'/Tools/Asset.ashx?id='. $FeedInfo['creatorid'] .'&request=avatar">
                            </a>
                          </div>
                          <div class="col-md-10">
                            <span class="notranslate">
                              <a href="'. $baseUrl .'/User.php?id='. $FeedInfo['creatorid'] .'">'. $FeedInfo['creatorname'] .'</a><br>
                              <div class="Feedtext">"'. htmlspecialchars($FeedInfo['content']) .'"</div>
                            </span>
                            <span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">'. $FeedInfo['date'] .'</span>
                          </div>
                        </div>
                      </div>
                      ';
                    }
                    break;
                  default:
                    echo '<span id="AjaxFeedError" class="error-message">Your feed is empty.</span>';
                    break;
                }
                ?>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-3">
         
        </div>
      </div>
    </div>
    <?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/Footer.php'); ?>
  </div>
</body>
</html>
