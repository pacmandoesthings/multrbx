<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
$BasicFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND genre = 'templatebasic' AND itemtype = 'place'");
$BasicFetch->execute();
$StrategyFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND genre = 'templatestrategy' AND itemtype = 'place'");
$StrategyFetch->execute();
$ActionFetch = $MainDB->prepare("SELECT * FROM asset WHERE approved = '1' AND public = '1' AND genre = 'templateaction' AND itemtype = 'place'");
$ActionFetch->execute();

switch(true){
  case ($RBXTICKET !== null):
    $UserPlaces = $MainDB->prepare("SELECT * FROM asset WHERE creatorid = :cid AND itemtype = 'place'");
    $UserPlaces->execute([':cid' => $id]);
    $UserRows = $UserPlaces->fetchAll();
    break;
}


if (isset($_GET['showlogin']) && $_GET['showlogin'] === 'True') {
    header("Location: http://mulrbx.com/login/");
    exit();
}

$BasicRows = $BasicFetch->fetchAll();
$StrategyRows = $StrategyFetch->fetchAll();
$ActionRows = $ActionFetch->fetchAll();
?>
<!DOCTYPE html>
<html>
   <head>
      <title>Welcome</title>
      <script type='text/javascript' src='//ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.2.min.js'></script>
      <script type='text/javascript'>window.jQuery || document.write("<script type='text/javascript' src='<?php echo $baseUrl; ?>/js/jquery/jquery-1.7.2.min.js'><\/script>")</script>
      <script type='text/javascript' src='//ajax.aspnetcdn.com/ajax/4.0/1/MicrosoftAjax.js'></script>
      <script type='text/javascript'>window.Sys || document.write("<script type='text/javascript' src='<?php echo $baseUrl; ?>/js/Microsoft/MicrosoftAjax.js'><\/script>")</script>
      <link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/Roblox.css' />
      <link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/iFrameLogin.css' />
      <link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/GenericModal.css' />
      <link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/UnifiedModal.css' />
      <link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/Profile.css' />
      <link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide.css' />
      <link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/IDE/Welcome.css' />
      <link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/IDE/BuildTemplates.css' />
      <link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/IDE/IDE.css' />
      <script type="text/javascript" src="<?php echo $baseUrl; ?>/js/roblox.js"></script>
      <script type="text/javascript" src="<?php echo $baseUrl; ?>/js/GoogleAnalytics/GoogleAnalyticsEvents.js"></script>
      <script type="text/javascript" src="<?php echo $baseUrl; ?>/js/PlaceLauncher.js"></script>
      <script type="text/javascript" src="<?php echo $baseUrl; ?>/js/ClientInstaller.js"></script>
      <script type="text/javascript" src="<?php echo $baseUrl; ?>/js/jquery.simplemodal-1.3.5.js"></script>
      <script type="text/javascript" src="<?php echo $baseUrl; ?>/js/GenericModal.js"></script>
      <script type="text/javascript" src="<?php echo $baseUrl; ?>/js/GenericConfirmation.js"></script>
      <script type="text/javascript" src="<?php echo $baseUrl; ?>/js/jquery.ba-postmessage.min.js"></script>
      <script type="text/javascript" src="<?php echo $baseUrl; ?>/js/parentFrameLogin.js"></script>
      <script type="text/javascript" src="<?php echo $baseUrl; ?>/js/IDE/Welcome.js"></script>
      <script type="text/javascript" src="<?php echo $baseUrl; ?>/js/IDE/BuildTemplates.js"></script>
      <script type="text/javascript" src="<?php echo $baseUrl; ?>/js/StringTruncator.js"></script>
      <script type="text/javascript">
         Roblox.config.externalResources = ['<?php echo $baseUrl; ?>/js/jquery/jquery-1.7.2.min.js','/js/json2.min.js'];
         Roblox.config.paths['jQuery'] = '<?php echo $baseUrl; ?>/js/rbxcdn/29cf397a226a92ca602cb139e9aae7d7.js';
         Roblox.config.paths['Pagelets.BestFriends'] = '<?php echo $baseUrl; ?>/js/rbxcdn/c8acaba4214074ed4ad6f8b4a9647038.js';
         Roblox.config.paths['Pages.Catalog'] = '<?php echo $baseUrl; ?>/js/rbxcdn/c8f61a230e6ad34193b40758f1499a3d.js';
         Roblox.config.paths['Pages.Messages'] = '<?php echo $baseUrl; ?>/js/rbxcdn/34e0d4ef92076cd06d46b61bd94bc8a2.js';
         Roblox.config.paths['Resources.Messages'] = '<?php echo $baseUrl; ?>/js/rbxcdn/fb9cb43a34372a004b06425a1c69c9c4.js';
         //Roblox.config.paths['Widgets.AvatarImage'] = '<?php echo $baseUrl; ?>/js/rbxcdn/a404577733d1b68e3056a8cd3f31614c.js';
         Roblox.config.paths['Widgets.AvatarImage'] = '<?php echo $baseUrl; ?>/js/Modules/Widgets/AvatarImage.js';
         Roblox.config.paths['Widgets.DropdownMenu'] = '<?php echo $baseUrl; ?>/js/rbxcdn/d83d02dd89808934b125fa21c362bcb9.js';
         //Roblox.config.paths['Widgets.GroupImage'] = '<?php echo $baseUrl; ?>/js/rbxcdn/3e692c7b60e1e28ce639184f793fdda9.js';
         Roblox.config.paths['Widgets.GroupImage'] = '<?php echo $baseUrl; ?>/js/Modules/Widgets/GroupImage.js';
         Roblox.config.paths['Widgets.HierarchicalDropdown'] = '<?php echo $baseUrl; ?>/js/rbxcdn/e8b579b8e31f8e7722a5d10900191fe7.js';
         //Roblox.config.paths['Widgets.ItemImage'] = '<?php echo $baseUrl; ?>/js/rbxcdn/6d374381f268432a466e8b8583414b49.js';
         Roblox.config.paths['Widgets.ItemImage'] = '<?php echo $baseUrl; ?>/js/Modules/Widgets/ItemImage.js';
         Roblox.config.paths['Widgets.PlaceImage'] = '<?php echo $baseUrl; ?>/js/rbxcdn/08e1942c5b0ef78773b03f02bffec494.js';
         Roblox.config.paths['Widgets.Suggestions'] = '<?php echo $baseUrl; ?>/js/rbxcdn/a63d457706dfbc230cf66a9674a1ca8b.js';
         Roblox.config.paths['Widgets.SurveyModal'] = '<?php echo $baseUrl; ?>/js/rbxcdn/d6e979598c460090eafb6d38231159f6.js';
      </script>
      <script type="text/javascript">
         function editTemplateInStudio(play_placeId) {
      RobloxLaunch._GoogleAnalyticsCallback = function() {
        var isInsideRobloxIDE = 'website';
        if (Roblox && Roblox.Client && Roblox.Client.isIDE && Roblox.Client.isIDE()) {
          isInsideRobloxIDE = 'Studio';
        };
      };
      Roblox.Client.WaitForRoblox(function() {
        RobloxLaunch.StartGame('<?php echo $baseUrl; ?>/Game/LoadPlaceFile.ashx?PlaceId=' + play_placeId, '<?php echo $baseUrl; ?>/Login/Negotiate.ashx', 'FETCH', true);
      });
    }
      </script>
   </head>
   <body id="StudioWelcomeBody">
      <div class="header">
<?php
  switch(true){
    case ($RBXTICKET):
      echo "
             <div id='header-login-wrapper' class='iframe-login-signup' data-display-opened=''>
              <span id='header-or'>Logged in as ". $name ."</span>
                <span class='studioiFrameLogin'>
                  <span id='login-span'>
                    <a href='". $baseUrl ."/Login/Logout.ashx?returnUrl=". $_SERVER['REQUEST_URI'] ."' class='btn-control btn-control-large'>Logout</a>
                  </span>
                </span>
              </div>
      ";
      break;
    default:
      echo 
      "
             <div id='header-login-wrapper' class='iframe-login-signup' data-display-opened=''>
              <a href='". $baseUrl ."/Login/NewAge.aspx' target='_blank' class='GrayButton translate' id='header-signup'><span>Sign Up</span></a>
              <span id='header-or'>or</span>
                <span class='studioiFrameLogin'>
                  <span id='login-span'>
                    <a id='header-login' class='btn-control btn-control-large'>Login <span class='grey-arrow'>&#9660;</span></a>
                  </span>
                  <div id='iFrameLogin' class='studioiFrameLogin' style='display: none'>
                  <iframe class='login-frame' src='". $baseUrl ."/Login/iFrameLogin.aspx?loginRedirect=true' scrolling='no' frameborder='0'></iframe>
                </span>
              </div>
             </div>
      ";
      break;
    
  }
?>
         <img src="<?php echo $baseUrl; ?>/images/IDE/img-studio_title.png" alt="Roblox Studio Title" />
      </div>
      <div class="container">
         <div class="navbar">
            <ul class="navlist">
               <li id="NewProject">
                  <p>New Project</p>
               </li>
               <li id="MyProjects">
                  <p>My Projects</p>
               </li>
            </ul>
         </div>
         <div class="main">
            <div id="TemplatesView" class="welcome-content-area">
               <h2 id="StudioGameTemplates">GAME TEMPLATES</h2>
               <div class="templatetypes">
                  <ul class="templatetypes">
                     <li js-data-templatetype="Basic"><a href="#Basic">Basic</a></li>
                     <li js-data-templatetype="Strategy"><a href="#Strategy">Strategy</a></li>
                     <li js-data-templatetype="Action"><a href="#Action">Action</a></li>
                  </ul>
               </div>
               <div class="templates" js-data-templatetype="Basic">
      <?php
      switch(true){
        case ($BasicRows):
          foreach($BasicRows as $GameInfo){
            echo "
              <div class='template' placeid='". $GameInfo['id'] ."'>
               <a href='' class='game-image'><img width='197' height='115' class='' src='". $baseUrl ."/Tools/Asset.ashx?id=". $GameInfo['id'] ."&request=place' /></a>
               <p>". $GameInfo['name'] ."</p>
              </div>
            ";
          }
          break;
        default:
          echo "<span>There are no templates.</span>";
          break;
      }
      ?>
               </div>
               <div class="templates" js-data-templatetype="Strategy">
      <?php
      switch(true){
        case ($StrategyRows):
          foreach($StrategyRows as $GameInfo){
            echo "
              <div class='template' placeid='". $GameInfo['id'] ."'>
               <a href='' class='game-image'><img width='197' height='115' class='' src='". $baseUrl ."/Tools/Asset.ashx?id=". $GameInfo['id'] ."&request=place' /></a>
               <p>". $GameInfo['name'] ."</p>
              </div>
            ";
          }
          break;
        default:
          echo "<span>There are no templates.</span>";
          break;
      }
      ?>
               </div>
               <div class="templates" js-data-templatetype="Action">
      <?php
      switch(true){
        case ($ActionRows):
          foreach($ActionRows as $GameInfo){
            echo "
              <div class='template' placeid='". $GameInfo['id'] ."'>
               <a href='' class='game-image'><img width='197' height='115' class='' src='". $baseUrl ."/Tools/Asset.ashx?id=". $GameInfo['id'] ."&request=place' /></a>
               <p>". $GameInfo['name'] ."</p>
              </div>
            ";
          }
          break;
        default:
          echo "<span>There are no templates.</span>";
          break;
      }
      ?>
               </div>
            </div>
            <div id="MyProjectsView" class="welcome-content-area" style="display: none">
               <h2>My Published Projects</h2>
               <div id="AssetList">
      <?php
      switch(true){
        case ($RBXTICKET):
          switch (true){
            case ($UserRows):
              foreach($UserRows as $GameInfo){
                echo "
                  <div class='template' placeid='". $GameInfo['id'] ."'>
                   <a href='' class='game-image'><img width='197' height='115' class='' src='". $baseUrl ."/Tools/Asset.ashx?id=". $GameInfo['id'] ."&request=place' /></a>
                   <p>". $GameInfo['name'] ."</p>
                  </div>
                ";
              }
              break;
            default:
              echo "
              <div>
               <span>You haven't made any places!</span>
              </div>";
              break;
          }
          break;
        default:
          echo "
                  <div>
                     <span>You must be logged in to view your published projects!</span>
                  </div>";
          break;
      }
      ?>
                  <script type="text/javascript">
                     $('#MyProjects').click(function() {
                         $('#header-login').addClass('active');
                         $('#iFrameLogin').css('display', 'block');
                     });
                  </script>
               </div>
            </div>
         </div>
      </div>
      <div class="GenericModal modalPopup unifiedModal smallModal" style="display:none;">
         <div class="Title"></div>
         <div class="GenericModalBody">
            <div>
               <div class="ImageContainer">
                  <img class="GenericModalImage" alt="generic image" />
               </div>
               <div class="Message"></div>
            </div>
            <div class="clear"></div>
            <div id="GenericModalButtonContainer" class="GenericModalButtonContainer">
               <a class="ImageButton btn-neutral btn-large roblox-ok">OK<span class="btn-text">OK</span></a>
            </div>
         </div>
      </div>
      <script type="text/javascript">
         $(function () {
         
             Roblox.Client.Resources = {
                 //<sl:translate>
                 here: "here",
                 youNeedTheLatest: "You need Our Plugin for this.  Get the latest version from ",
                 plugInInstallationFailed: "Plugin installation failed!",
                 errorUpdating: "Error updating: "
                 //</sl:translate>
             };
         
             if (typeof Roblox.IDEWelcome === "undefined")
                 Roblox.IDEWelcome = { };
         
             Roblox.IDEWelcome.Resources = {
                 //<sl:translate>
                 openProject: "Open Project",
                 openProjectText: "To open your project, open to this page in ",
                 robloxStudio: "ROBLOX Studio",
                 editPlace: "Edit Place",
                 toEdit: "To edit ",
                 openPage: ", open to this page in ",
                 buildPlace: "Build Place",
                 toBuild: "To build on ",
                 placeInactive: "Place Inactive",
                 activate: ", activate this place by going to File->My Published Projects.",
                 emailVerifiedTitle: "Verify Your Email",
                 emailVerifiedMessage: "You must verify your email before you can work on your place. You can verify your email on the <a href='/My/Account.aspx?confirmemail=1'>Account</a> page.",
                 verify: "Verify",
                 cancel: "Cancel"
                 //</sl:translate>
             };
         });
      </script>
      <div class="ConfirmationModal modalPopup unifiedModal smallModal" data-modal-handle="confirmation" style="display:none;">
         <a class="genericmodal-close ImageButton closeBtnCircle_20h"></a>
         <div class="Title"></div>
         <div class="GenericModalBody">
            <div class="TopBody">
               <div class="ImageContainer roblox-item-image" data-image-size="small" data-no-overlays data-no-click>
                  <img class="GenericModalImage" alt="generic image" />
               </div>
               <div class="Message"></div>
            </div>
            <div class="ConfirmationModalButtonContainer">
               <a href roblox-confirm-btn><span></span></a>
               <a href roblox-decline-btn><span></span></a>
            </div>
            <div class="ConfirmationModalFooter"></div>
         </div>
         <script type="text/javascript">
            //<sl:translate>
            Roblox.GenericConfirmation.Resources = { yes: "Yes", No: "No" }
            //</sl:translate>
         </script>
      </div>
   </body>
</html>