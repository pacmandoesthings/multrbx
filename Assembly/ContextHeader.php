<?php
// Initialize the session
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
include($_SERVER['DOCUMENT_ROOT'] . '/UserInfo.php');

$GetPlayerInfo = $MainDB->prepare("SELECT * FROM users WHERE id = :id");
$GetPlayerInfo->execute([':id' => $id]);
$PlayerInfo = $GetPlayerInfo->fetch(PDO::FETCH_ASSOC);


$GetNotif = $MainDB->prepare("SELECT * FROM notification WHERE id = 1");
$GetNotif->execute();
$Notification = $GetNotif->fetch(PDO::FETCH_ASSOC);

$notificationType = "";
if ($Notification['type'] == 1) {
    $notificationType = "rgb(89, 167, 255)"; // blue
} elseif ($Notification['type'] == 2) {
    $notificationType = "rgb(255, 174, 41)"; // yellow
} elseif ($Notification['type'] == 3) {
    $notificationType = "rgb(255, 20, 20)"; // red
} else {
    $notificationType = "rgb(168, 168, 168)"; // grey
}

?>

<!DOCTYPE html>
<html>
<head>
  <title>MULTRBX</title>
</head>
<body>
<?php
switch (true) {
  case ($RBXTICKET):
    // Existing code for navigation menu
   

    // New check for $theme inside the $RBXTICKET case
    switch ($theme) {
      case 1:
        echo('<link rel="stylesheet" href="https://mulrbx.com/content/css/CSSMain.css">
		<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="https://mulrbx.com/content/css/CSSMain23.css">
		<link rel="stylesheet" href="https://mulrbx.com/content/css/CSS10.css">
		<div id="header"
           class="navbar-fixed-top rbx-header"
           role="navigation">
          <div class="container-fluid">
              <div class="rbx-navbar-header">
                  <div data-behavior="nav-notification" class="rbx-nav-collapse" onselectstart="return false;">
                          <span class="icon-nav-menu"></span>

                  </div>
                  <div class="navbar-header">
                      <a class="navbar-brand" href="/">
                          <span class="icon-logo"></span>
                          <span class="icon-logo-r"></span>
                      </a>
                  </div>
              </div>

            <ul class="nav rbx-navbar hidden-xs hidden-sm col-md-4 col-lg-3">
                  <li>
                      <a class="nav-menu-title" href="/games">Games</a>
                  </li>
                  <li>
                      <a class="nav-menu-title" href="/catalog">Catalog</a>
                  </li>
                  <li>
                      <a class="nav-menu-title" href="/develop">Develop</a>
                  </li>


              </ul><!--rbx-navbar-->
              <div id="navbar-universal-search" class="navbar-left rbx-navbar-search col-xs-5 col-sm-6 col-md-3" data-behavior="univeral-search" role="search">
                  <div class="input-group">

                      <input id="navbar-search-input" class="form-control input-field" type="text" placeholder="Search" maxlength="120" />
                      <div class="input-group-btn">
                          <button id="navbar-search-btn" class="input-addon-btn" type="submit">
                              <span class="icon-nav-search"></span>
                          </button>
                      </div>
                  </div>
                  <ul data-toggle="dropdown-menu" class="dropdown-menu" role="menu">
                      <li class="rbx-navbar-search-option selected" data-searchurl="/search/users?keyword=">
                          <span class="rbx-navbar-search-text">Search <span class="rbx-navbar-search-string"></span> in People</span>
                      </li>
                              <li class="rbx-navbar-search-option" data-searchurl="/search/games/?Keyword=">
                                  <span class="rbx-navbar-search-text">Search <span class="rbx-navbar-search-string"></span> in Games</span>
                              </li>
                              <li class="rbx-navbar-search-option" data-searchurl="/catalog?Keyword=">
                                  <span class="rbx-navbar-search-text">Search <span class="rbx-navbar-search-string"></span> in Catalog</span>
                              </li>
                              <li class="rbx-navbar-search-option" data-searchurl="/search/groups/search.aspx?val=">
                                  <span class="rbx-navbar-search-text">Search <span class="rbx-navbar-search-string"></span> in Groups</span>
                              </li>
                              <li class="rbx-navbar-search-option" data-searchurl="/search/develop/library?CatalogContext=2&amp;Category=6&amp;Keyword=">
                                  <span class="rbx-navbar-search-text">Search <span class="rbx-navbar-search-string"></span> in Library</span>
                              </li>
                  </ul>
              </div><!--rbx-navbar-search-->
              <div class="navbar-right rbx-navbar-right col-xs-4 col-sm-3">

      <ul class="nav navbar-right rbx-navbar-icon-group">
          <li id="navbar-setting" class="navbar-icon-item">

       <a class="rbx-menu-item" data-toggle="popover" data-bind="popover-setting" data-viewport="#header">
                  <span class="icon-nav-settings" id="nav-settings"></span>
                  <span class="xsmall nav-setting-highlight hidden">0</span>
              </a>
              <div class="rbx-popover-content" data-toggle="popover-setting">
                  <ul class="dropdown-menu" role="menu">
                      <li>
                          <a class="rbx-menu-item" href="account">
                              Settings
                              <span class="xsmall nav-setting-highlight hidden">0</span>
                          </a>
                      </li>
                      <li><a class="rbx-menu-item" href="" target="_blank">Help</a></li>
                      <li><a class="rbx-menu-item" data-behavior="logout" data-bind="/Logout.ashx">Logout</a></li>
                  </ul>
              </div>
          </li>

          <li id="navbar-tix" class="navbar-icon-item">
               <a id="nav-tix-icon" class="rbx-menu-item" data-toggle="popover" data-bind="popover-tix">
                   <span class="icon-nav-tix" id="nav-tix"></span>
                   <span class="rbx-text-navbar-right" id="nav-tix-amount">'.$ticket.'</span>
               </a>
               <div class="rbx-popover-content" data-toggle="popover-tix">
                   <ul class="dropdown-menu" role="menu">
                       <li><a href="/money" id="nav-tix-balance" class="rbx-menu-item">'.$ticket.' Tickets</a></li>
                       <li><a href="../upgrade" class="rbx-menu-item">Get Tickets</a></li>
                   </ul>
               </div>
           </li>
           <li id="navbar-robux" class="navbar-icon-item">
                <a id="nav-robux-icon" class="rbx-menu-item" data-toggle="popover" data-bind="popover-robux">
                    <span class="icon-nav-robux" id="nav-robux"></span>
                    <span class="rbx-text-navbar-right" id="nav-robux-amount">'.$robux.'</span>
                </a>
                <div class="rbx-popover-content" data-toggle="popover-robux">
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="/money" id="nav-robux-balance" class="rbx-menu-item">'.$robux.' Robux</a></li>
                        <li><a href="../upgrade" class="rbx-menu-item">Get Robux</a></li>
                    </ul>
                </div>
            </li>

           <li id="navbar-notifications" class="navbar-icon-item">
               <a id="nav-notifications-icon" class="rbx-menu-item" data-toggle="popover" data-bind="popover-notifications">
                   <span class="icon-notifications" id="nav-notifications"></span>
               </a>
               <div class="rbx-popover-content" data-toggle="popover-notifications">
                   <ul class="dropdown-menu" role="menu">
                       <li><a href="/notifications" class="rbx-menu-item">No Notifications</a></li>
                   </ul>
               </div>
           </li>

          <li class="rbx-navbar-right-search" data-toggle="toggle-search">
              <a class="rbx-menu-icon rbx-menu-item">
                  <span class="icon-nav-search-white"></span>
              </a>
          </li>
      </ul>        </div><!-- navbar right-->
              <ul class="nav rbx-navbar hidden-md hidden-lg col-xs-12">
                  <li>
                      <a class="nav-menu-title" href="/games">Games</a>
                  </li>
                  <li>
                      <a class="nav-menu-title" href="/catalog">Catalog</a>
                  </li>
                  <li>
                      <a class="nav-menu-title" href="/develop">Develop</a>
                  </li>
                  <li>
                      <a class="buy-robux nav-menu-title" href="/upgrade">Upgrade</a>
                  </li>
              </ul><!--rbx-navbar-->
          </div>
      </div>

      <!-- LEFT NAV MENU -->
          <div id="navigation" class="rbx-left-col" data-behavior="left-col">
              <ul>
                  <li class="text-lead">
                      <a class="text-overflow" href="/User?id='.$id.'">'.$name.'</a>
                  </li>
                  <li class="rbx-divider"></li>
              </ul>

              <div class="rbx-scrollbar" data-toggle="scrollbar" onselectstart="return false;">
                  <ul>
                      <li><a href="/my/home" id="nav-home"><span class="icon-nav-home"></span><span>Home</span></a></li>
                      <li><a href="/User?id='.$id.'" id="nav-profile"><span class="icon-nav-profile"></span><span>Profile</span></a></li>
                      <li>
                          <a href="/my/messages/#!/inbox" id="nav-message" data-count="0">
                              <span class="icon-nav-message"></span><span>Messages</span>
                              <span class="notification-blue " title="0">0</span>
                          </a>
                      </li>
                      <li>
                          <a href="/Friends.aspx" id="nav-friends" data-count="0">
                              <span class="icon-nav-friends"></span><span>Friends</span>
                              <span class="notification-blue " title="0">0</span>
                          </a>
                      </li>
                      <li>
                          <a href="/my/character.aspx" id="nav-character">
                              <span class="icon-nav-charactercustomizer"></span><span>Avatar</span>
                          </a>
                      </li>
                      <li>
                          <a href="/inventory" id="nav-inventory">
                              <span class="icon-nav-inventory"></span><span>Inventory</span>
                          </a>
                      </li>
                      <li>
                          <a href="/trade" id="nav-trade">
                              <span class="icon-nav-trade"></span><span>Trade</span>
                          </a>
                      </li>
                      <li>
                          <a href="/groups" id="nav-group">
                              <span class="icon-nav-group"></span><span>Groups</span>
                          </a>
                      </li>
                      <li>
                          <a href="/forum/" id="nav-forum">
                              <span class="icon-nav-forum"></span><span>Forum</span>
                          </a>
                      </li>
                      <li>
                          <a href="/blog/" id="nav-blog">
                              <span class="icon-nav-blog"></span><span>Blog</span>
                          </a>
                      </li>
                          <li>
                              <a id="nav-shop" class="roblox-shop-interstitial">
                                  <span class="icon-nav-shop"></span><span>Shop</span>
                              </a>
                          </li>
                      <li class="rbx-upgrade-now">
                          <a href="/upgrade" class="btn-secondary-md" id="upgrade-now-button">Upgrade Now</a>
                      </li>
                          <li class="font-bold small">
                              Events
                          </li>
                          <li class="rbx-nav-sponsor" ng-non-bindable>
                                  <span class="menu-item">No events.</span>
                          </li>');
                              //<li class="rbx-nav-sponsor" ng-non-bindable>
                              //    <a class="menu-item" href="https://www.roblox.com/sponsored/TrickOrTreatCountdown" title="TrickOrTreatCountdown">
                              //            <img src="https://images.rbxcdn.com/afb2cf5cfcf786eaf8af131529fc64f6" />
                              //      </a>
                              //  </li>
                  echo('</ul>
              </div>
          </div>');
        break;
	   case 2:
	    echo "
		<link rel='stylesheet' href='http://mulrbx.com/CSS/Base/CSS/Roblox.css' />
<link rel='stylesheet' href='http://mulrbx.com/CSS/Pages/Accounts/AccountMVC.css' />
<link rel='stylesheet' href='http://mulrbx.com/CSS/Base/CSS/StyleGuide.css' />
<link rel='stylesheet' href='http://mulrbx.com/CSS/Base/CSS/UnifiedModal.css' />
<link rel='stylesheet' href='http://mulrbx.com/CSS/Base/CSS/GenericModal.css' />
    <div id='Container'>
       <style type='text/css'>
        div.mySubmenuFixed {
        top: 36px;
        background-color: #191919;
        height: 25px;
        *top: 0px;
        }
       </style>
       <div id='Banner' class='BannerRedesign'>
        <div id='NavigationRedesignBannerContainer' class='BannerCenterContainer'>
         <a href='". $baseUrl ."/' id='navbar-logo' class='btn-logo' data-se='nav-logo'></a>
         <div id='NavRedesign' class='NavigationRedesign'>
          <ul id='ctl00_cphBanner_ctl00_MenuUL'>
             <li><a href='". $baseUrl ."/My/Home' ref='nav-myroblox' data-se='nav-myhome'>Home</a></li>
             <li class='gamesLink'><a id='hlGames' data-se='nav-games' href='". $baseUrl ."/Games' title='Games' ref='nav-games'>Games</a> </li>
             <li class='catalogLink'><a id='hlCatalog' data-se='nav-catalog' href='". $baseUrl ."/Catalog' title='Catalog' ref='nav-catalog'>Catalog</a></li>
             <li><a id='BuildLink' data-se='nav-build' href='". $baseUrl ."/Develop' title='Develop' ref='nav-build'>Develop</a></li>
             <li class='forumLink'><a id='hlForum' data-se='nav-forum' href='". $baseUrl ."/Forum/' title='Forum' ref='nav-buildersclub'>Forum</a></li>
             <li class='upgradeLink'><a id='hlBuildersClub' data-se='nav-upgrade' href='". $baseUrl ."/Upgrade' title='Upgrade' ref='nav-buildersclub'>Upgrade</a></li>
          </ul>
         </div>
         <div id='SiteWideHeaderLogin'>
          <div id='AlertSpace'>
             <div class='AlertItem' style='max-width: 50px;text-align:center;' id='logoutonclick'>
              <a id='lsLoginStatus' data-se='nav-logout' class='logoutButton' href='". $baseUrl ."/Login/Logout.ashx?returnUrl=". $CurrPage ."'>
              Logout
              </a>
             </div>
             <div class='HeaderDivider'></div>
             <a data-se='nav-Tickets' href='". $baseUrl ."/My/Money.aspx?tab=MyTransactions'>
              <div id='TicketsWrapper' class='TicketsAlert AlertItem tooltip-bottom' original-title='Tickets'>
               <div class='icons tickets_icon'></div>
               <div id='TicketsAlertCaption' class='AlertCaption'>
                ". $ticket ."
               </div>
              </div>
             </a>
             <a data-se='nav-robux' href='". $baseUrl ."/My/Money.aspx?tab=MyTransactions'>
              <div id='RobuxWrapper' class='RobuxAlert AlertItem tooltip-bottom' original-title='ROBUX'>
               <div class='icons robux_icon'></div>
               <div id='RobuxAlertCaption' class='AlertCaption'>
                ". $robux ."
               </div>
              </div>
             </a>
             <div class='HeaderDivider'></div>
             <a data-se='nav-friends' href='". $baseUrl ."/friends.aspx#FriendRequestsTab'>
              <span id='FriendsTextWrapper' class='FriendsAlert AlertItem tooltip-bottom' original-title='Friend Requests'>
               <div id='FriendsBubble' class='AlertTextWrapper' runat='server'>
                <div class='AlertBox Left' style='display: none;'></div>
                <div class='AlertBox' style='background-position:right; padding-right:3px; display: none;'>
                   <div id='czxvijhoidshfiosdhfsdo' class='AlertText'>
                    FriendRequestsAmount
                   </div>
                </div>
               </div>
               <div class='icons friends_icon' style='float:none;'></div>
              </span>
             </a>
             <a data-se='nav-messages' href='". $baseUrl ."/My/Messages.aspx'>
              <span id='MessagesTextWrapper' class='MessageAlert AlertItem tooltip-bottom' original-title='Messages'>
               <div class='icons message_icon' style='float:none;'></div>
               <div id='MessageBubble' class='AlertTextWrapper' runat='server' style='display: none;'>
                <div class='AlertBox Left'></div>
                <div class='AlertBox Right' style='background-position: right; padding-right:3px;'>
                   <div class='AlertText'>
                    MessageAmount
                   </div>
                </div>
               </div>
              </span>
             </a>
             <div id='AuthenticatedUserNameWrapper'>
              <div id='AuthenticatedUserName'>
               <span class='login-span notranslate' style='top:0px'>
               <img id='over13icon' src='". $baseUrl ."/Images/Icons/img-13.png' alt='13+' style='vertical-align:middle;padding-right: 1px;padding-left:0px;' original-title='This is a 13+ account.'>
               <a class='text-nav text-overflow font-header-2' href='". $baseUrl ."/User.php?id=". $id ."'>". $name ."</a>
               </span>
              </div>
             </div>
          </div>
         </div>
        </div>
       </div>
       <div class='mySubmenuFixed Redesign'>
        <div id='ctl00_cphSubmenu_UserSubmenu1_subMenu' class='subMenu'>
         <ul>
          <li>
             <a data-se='subnav-profile' href='". $baseUrl ."/User.php?id=". $id ."'>
             Profile
             </a>
          </li>
          <li>
             <a data-se='subnav-character' href='". $baseUrl ."/My/Character.aspx'>
             Character
             </a>
          </li>
          <li>
             <a data-se='subnav-friends' href='". $baseUrl ."/My/EditFriends.aspx'>
             Friends
             </a>
          </li>
          <li>
          </li>
          <li>
             <a data-se='subnav-inventory' href='". $baseUrl ."/My/Stuff.aspx'>
             Inventory
             </a>
          </li>
          <li>
          </li>
          <li>
             <a data-se='subnav-trade' href='". $baseUrl ."/My/Money.aspx?tab=TradeItems'>
             Trade
             </a>
          </li>
          <li>
             <a data-se='subnav-money' href='". $baseUrl ."/My/Money.aspx?tab=MyTransactions'>
             Money
             </a>
          </li>
          <li>
          </li>
          <li>
             <a data-se='subnav-account' href='". $baseUrl ."/My/Account.aspx'>
             Account
             </a>
          </li>
      <li>
             <a data-se='subnav-download' href='http://launcherapi.vrblxxd.ga/VRBLXInstaller.exe'>
             Download
             </a>
          </li>
      <li>
             <a data-se='subnav-download' href='http://launcherapi.vrblxxd.ga/setupinfo/VRBLXStudio.zip'>
             Download Studio
             </a>
          </li>
         </ul>
        </div>
       </div>
       <div class='forceSpace'>&nbsp;</div>
      
      ";
	  default:
	  echo '<style>
.nav-bar {
  position: fixed;
  background-color: rgb(0, 116, 189);
  height: 40px;
  width: 100%;
  z-index: 10; /* Corrected z-index value */
  margin-bottom: 15px;
  top: 0px;
  display: block;
  padding-top: 5px;
}


.nav-bar-div {
  position: absolute;
  height: 30px;
  width: 100%;
  top: 0px;
  margin-top: 5px;
  display: list-item;
}

.nav-button {
  background-color: rgb(0, 116, 189);
  border: none;
  height: 100%;
  color: white;
  font-size: 15px;
  border-radius: 5px;
  transition: background-color 200ms;
  line-height: 0px;
}

.float-end {
  margin-right: 5px;
  float: right;
}

.nav-button:hover {
  background-color: rgb(0, 96, 156);
}

.nav-button-end:hover {
  background-color: rgb(0, 96, 156);
}

.multrbx-nav-logo {
  margin-left: 5px;
  height: 100%;
  margin-bottom: 0%;
  position: relative;
}

.robuxs-text {
  color: white;
  margin-top: 10 px;
  display: inline;
  height: 100%;
  float: left;
  margin-bottom: 0;
  line-height: 30px;
  cursor: default;
}

#robux_svg {
  filter: invert(100%);
  overflow: visible;
}

#robux_svg_element {
  float: right;
}

.robuxs-amount-div {
  position: relative;
  border: none;
  height: 100%;
  float: right;
  margin-right: 5px;
}

#tix_svg {
  filter: invert(100%);
  overflow: visible;
}

#tix_svg_element {
  float: right;
}

.tixs-amount-div {
  position: relative;
  border: none;
  height: 100%;
  float: right;
  margin-right: 5px;
}

.nav-dropdown {
  display: inline-block;
  position: relative;
  height: 30px;
  top: -1px;
}

.nav-dropdown-content {
  display: none;
  position: absolute;
  width: 250px;
  right: -25px;
  overflow: auto;
  box-shadow: 5px 5px 16px black;
}

.nav-dropdown-content-nohover {
  display: none;
  position: absolute;
  width: 250px;
  right: -25px;
  overflow: auto;
  box-shadow: 5px 5px 16px black;
}

.nav-dropdown-content a {
  display: block;
  color: white;
  padding: 5px;
  text-decoration: none;
  transition: background-color 200ms;
}

.nav-dropdown-content-nohover a {
  display: block;
  color: white;
  padding: 5px;
  text-decoration: none;
  transition: background-color 200ms;
  cursor: default;
}

.nav-dropdown:hover .nav-dropdown-content {
  display: block;
  background-color: rgb(0, 116, 189);
  border-radius: 5px;
}

.nav-dropdown:hover .nav-dropdown-content-nohover {
  display: block;
  background-color: rgb(0, 116, 189);
  border-radius: 5px;
}

.nav-dropdown-content a:hover {
  color: #ffffff;
  background-color: rgb(0, 96, 156);
}

.nav-text {
  color: white;
  margin-top: 10 px;
  display: inline;
  height: 100%;
  margin-bottom: 0;
  line-height: 30px;
  cursor: default;
}

.verticalLine {
  border-color: rgb(0, 96, 156);
  border-style: none solid none none;
  display: inline;
  height: 100%;
  position: relative;
  z-index: 1px;
  margin-left: 5px;
  margin-right: 5px;
  display: inline;
}

#money-dropdown {
  visibility: hidden;
  position: fixed;
  top: -100px;
}

.menu-dropdown {
  visibility: hidden;
  position: fixed;
  top: -100px;
}

#div-notification {
  background-color: '.$notificationType.';
  position: fixed;
  width: 100%;
  height: 30px;
   top: 40px;
  color: white;
  text-align: center;
  line-height: 30px;
  font-size: 18px;
    z-index: 50px;

}


@media only screen and (max-width: 1270px) {
  #money-dropdown {
    visibility: visible;
    position: relative;
    top: 0;
  }

  .robuxs-amount-div {
    visibility: hidden;
    position: fixed;
    top: -1000px;
  }
  .tixs-amount-div {
    visibility: hidden;
    position: fixed;
    top: -1000px;
  }

  .nav-player-name {
    visibility: hidden;
    position: fixed;
    top: -1000px;
  }
}

@media only screen and (max-width: 820px) {
  .hide-at-sm {
    visibility: hidden;
    position: fixed;
    top: -1000px;
  }
  .menu-dropdown {
    visibility: visible;
    position: relative;
    top: 0;
  }
}
</style>
	  <html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
    />
    <link rel="stylesheet" href="navbar.css" />
  </head>
  <body>
    <nav class="nav-bar" id="nav-bar">
      <div class="nav-bar-div">
        <a href="/">
          <img
            src="../funnylogo.png"
            alt=""
            class="multrbx-nav-logo"
          />
        </a>

        <div class="verticalLine"></div>

        <a href="/games">
          <button class="nav-button hide-at-sm">Games</button>
        </a>

        <a href="/catalog">
          <button class="nav-button hide-at-sm">Catalog</button>
        </a>

        <a href="/develop">
          <button class="nav-button hide-at-sm">Develop</button>
        </a>

        <a href="/My/Character.aspx">
          <button class="nav-button hide-at-sm">Avatar</button>
        </a>

        <div class="nav-dropdown menu-dropdown">
          <button class="nav-button">
            <img
              src="../Images/dropdown2.png"
              alt=""
              width="10"
              height="10"
            />

            Menu
          </button>
          <div class="nav-dropdown-content">
            <a rel="noopener" href="/games">Games</a>
            <a rel="noopener" href="/catalog">Catalog</a>
            <a rel="noopener" href="/develop">Develop</a>
            <a rel="noopener" href="/My/Character.aspx">Avatar</a>
            <a rel="noopener" href="">Robux: '.$PlayerInfo['robux'].'</a>
            <a rel="noopener" href="">Tix: '.$PlayerInfo['ticket'].'</a>
            <a
              rel="noopener"
              href="/Login/Logout.ashx?returnUrl=/index"
              style="color: red; font-weight: bold"
              >Logout</a
            >
          </div>
        </div>

        <div class="nav-dropdown hide-at-sm">
          <button class="nav-button">
            <img
              src="..//images/dropdown2.png"
              alt=""
              width="10"
              height="10"
            />

            Download
          </button>
          <div class="nav-dropdown-content hide-at-sm">
            <a rel="noopener" href="/multrbxinstall.exe">Download Launcher</a>
            <a rel="noopener" href="/studio.zip">Download Studio</a>
          </div>
        </div>

        <a href="/Login/Logout.ashx?returnUrl=/index" class="hide-at-sm">
          <button
            class="nav-button float-end"
            style="color: rgb(255, 74, 74); font-weight: bold"
          >
            Logout
          </button>
        </a>

        <div class="verticalLine float-end hide-at-sm"></div>

        <div class="tixs-amount-div">
          <svg id="tix_svg_element" viewBox="0 53 30 30" width="30" height="30">
            <g xmlns="http://www.w3.org/2000/svg" id="tix_svg">
              <g>
                <path
                  class="st4"
                  d="M12,82c-0.3,0-0.5-0.1-0.7-0.3l-3-3C8.1,78.5,8,78.3,8,78v-1.6L7.6,76H6c-0.3,0-0.5-0.1-0.7-0.3l-3-3    c-0.4-0.4-0.4-1,0-1.4l13-13c0.4-0.4,1-0.4,1.4,0l3,3c0.2,0.2,0.3,0.4,0.3,0.7v1.6l0.4,0.4H22c0.3,0,0.5,0.1,0.7,0.3l3,3    c0.4,0.4,0.4,1,0,1.4l-13,13C12.5,81.9,12.3,82,12,82z M10,77.6l2,2L23.6,68l-2-2H20c-0.3,0-0.5-0.1-0.7-0.3l-1-1    C18.1,64.5,18,64.3,18,64v-1.6l-2-2L4.4,72l2,2H8c0.3,0,0.5,0.1,0.7,0.3l1,1C9.9,75.5,10,75.7,10,76V77.6z"
                />
              </g>
              <g>
                <path
                  class="st4"
                  d="M10,71c-0.3,0-0.5-0.1-0.7-0.3c-0.4-0.4-0.4-1,0-1.4l4-4c0.4-0.4,1-0.4,1.4,0s0.4,1,0,1.4l-4,4    C10.5,70.9,10.3,71,10,71z"
                />
              </g>
              <g>
                <path
                  class="st4"
                  d="M16,73c-0.3,0-0.5-0.1-0.7-0.3l-4-4c-0.4-0.4-0.4-1,0-1.4s1-0.4,1.4,0l4,4c0.4,0.4,0.4,1,0,1.4    C16.5,72.9,16.3,73,16,73z"
                />
              </g>
            </g>
          </svg>
          <p class="robuxs-text">'.$PlayerInfo['ticket'].'</p>
        </div>

        <div class="robuxs-amount-div">
          <svg
            id="robux_svg_element"
            viewBox="0 26 30 30"
            width="30"
            height="30"
            src="../../files/images/robux.svg"
          >
            <g xmlns="http://www.w3.org/2000/svg" id="robux_svg">
              <g>
                <path
                  class="st4"
                  d="M14,54C7.4,54,2,48.6,2,42s5.4-12,12-12s12,5.4,12,12S20.6,54,14,54z M14,32C8.5,32,4,36.5,4,42s4.5,10,10,10    s10-4.5,10-10S19.5,32,14,32z"
                />
              </g>
              <g>
                <g>
                  <path
                    class="st4"
                    d="M19,47h-5c-0.2,0-0.4-0.1-0.6-0.2L9,43.3V46c0,0.6-0.4,1-1,1s-1-0.4-1-1v-8c0-0.6,0.4-1,1-1h4     c1.1,0,1.7,1.1,1.7,3c0,0.6-0.1,1.2-0.2,1.7C13.1,42.9,12.3,43,12,43h-0.1l2.5,2H19c0.3,0,0.5-0.5,0.5-1c0-0.4-0.1-1-0.5-1h-2     c-1.4,0-2.5-1.3-2.5-3c0-0.7,0.2-1.4,0.5-1.9c0.5-0.7,1.2-1.1,2-1.1h3c0.6,0,1,0.4,1,1s-0.4,1-1,1h-3c-0.1,0-0.2,0-0.3,0.2     c-0.1,0.2-0.2,0.5-0.2,0.8c0,0.4,0.2,1,0.5,1h2c1.4,0,2.5,1.3,2.5,3S20.4,47,19,47z M9,41h2.6c0.1-0.5,0.1-1.5,0-2H9V41z"
                  />
                </g>
                <g>
                  <path
                    class="st4"
                    d="M18,38c-0.6,0-1-0.4-1-1v-1c0-0.6,0.4-1,1-1s1,0.4,1,1v1C19,37.6,18.6,38,18,38z"
                  />
                </g>
                <g>
                  <path
                    class="st4"
                    d="M18,49c-0.6,0-1-0.4-1-1v-1c0-0.6,0.4-1,1-1s1,0.4,1,1v1C19,48.6,18.6,49,18,49z"
                  />
                </g>
              </g>
            </g>
          </svg>
          <p class="robuxs-text">'.$PlayerInfo['robux'].'</p>
        </div>

        <div class="nav-dropdown float-end hide-at-sm" id="money-dropdown">
          <button class="nav-button hide-at-sm">
            <img
              src="../images/dropdown2.png"
              alt=""
              width="10"
              height="10"
            />

            Robux & Tix
          </button>
          <div class="nav-dropdown-content-nohover">
            <a rel="noopener" href="">Robux: '.$PlayerInfo['robux'].'</a>
            <a rel="noopener" href="">Tix: '.$PlayerInfo['ticket'].'</a>
          </div>
        </div>

        <div class="verticalLine float-end hide-at-sm"></div>

        <p class="nav-text float-end nav-player-name">
          <a href="/user/?id='.$id.'">
          <button class="nav-button hide-at-sm float-end">
            '.$PlayerInfo['name'].'
          </button>
        </a>
        </p>
      </div>
    </nav>

    <div id="div-banner">
      <div id="div-notification">
        '.$Notification['text'].'
      </div>

    </div>

    <br id="nav-bar-seperator-1" /><br id="nav-bar-seperator-2" />

    <script>
      var check = null;
      const navBar = document.getElementById("nav-bar");
      const navBarBr1 = document.getElementById("nav-bar-seperator-1");
      const navBarBr2 = document.getElementById("nav-bar-seperator-2");

      window.mobileCheck = function () {
        let check = false;
        (function (a) {
          if (
            /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(
              a
            ) ||
            /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(
              a.substr(0, 4)
            )
          )
            check = true;
        })(navigator.userAgent || navigator.vendor || window.opera);
        return check;
      };
      if (mobileCheck(check)) {
        navBar.remove();
        navBarBr1.remove();
        navBarBr2.remove();
      }


      // NOTIFICATION BANNER

          const notificationBanner = document.getElementById("div-notification");
    const notification = '.$Notification['text'].';
    const showNotification = true;


      //semantic colours

      const infoColour = "#59a7ff"; //blue
      const warningColour = "#ffae29"; //yellow
      const dangerColour = "#ff1414"; //red
      const positiveColour = "#97ff6b"; //green
      const otherColour = "#a8a8a8"; //grey

      const notificationType = warningColour;

      if (!showNotification) {
        notificationBanner.remove();
      }

      notificationBanner.textContent = notification.toString();
      notificationBanner.style.backgroundColor = '.$notificationType.';
      notificationBanner.style.opacity = 1;

    </script>
  </body>
</html>';
	  break;
      case 3:
        echo '
		  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
              <a href="../index.php"><img src="../logo.png" class="logo" width="105" height="85"></a>
              <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
              </button>
              <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                  <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/">Home</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/games">Games</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link active" href="/multrbxinstall.exe">Download</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link active" href="/studio.zip">Download Studio</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link active" href="/Catalog">Catalog</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link active" href="/develop">Develop</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link active" href="/My/Character.aspx">Change Avatar</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="#">Robux: '.$PlayerInfo['robux'].'</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="#">Tix: '.$PlayerInfo['ticket'].'</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link active" href="/Login/Logout.ashx?returnUrl=/index">Logout</a>
                  </li>
                </ul>
              </div>
            </div>
          </nav>';
        break;
    }
	
    break;

  default:
echo '
  <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
    />
 <style>
	.nav-bar {
  position: fixed;
  background-color: rgb(0, 116, 189);
  height: 40px;
  width: 100%;
  z-index: 10; /* Corrected z-index value */
  margin-bottom: 15px;
  top: 0px;
  display: block;
  padding-top: 5px;
}


.nav-bar-div {
  position: absolute;
  height: 30px;
  width: 100%;
  top: 0px;
  margin-top: 5px;
  display: list-item;
}

.nav-button {
  background-color: rgb(0, 116, 189);
  border: none;
  height: 100%;
  color: white;
  font-size: 15px;
  border-radius: 5px;
  transition: background-color 200ms;
  line-height: 0px;
}

.float-end {
  margin-right: 5px;
  float: right;
}

.nav-button:hover {
  background-color: rgb(0, 96, 156);
}

.nav-button-end:hover {
  background-color: rgb(0, 96, 156);
}

.multrbx-nav-logo {
  margin-left: 5px;
  height: 100%;
  margin-bottom: 0%;
  position: relative;
}

.robuxs-text {
  color: white;
  margin-top: 10 px;
  display: inline;
  height: 100%;
  float: left;
  margin-bottom: 0;
  line-height: 30px;
  cursor: default;
}

#robux_svg {
  filter: invert(100%);
  overflow: visible;
}

#robux_svg_element {
  float: right;
}

.robuxs-amount-div {
  position: relative;
  border: none;
  height: 100%;
  float: right;
  margin-right: 5px;
}

#tix_svg {
  filter: invert(100%);
  overflow: visible;
}

#tix_svg_element {
  float: right;
}

.tixs-amount-div {
  position: relative;
  border: none;
  height: 100%;
  float: right;
  margin-right: 5px;
}

.nav-dropdown {
  display: inline-block;
  position: relative;
  height: 30px;
  top: -1px;
}

.nav-dropdown-content {
  display: none;
  position: absolute;
  width: 250px;
  right: -25px;
  overflow: auto;
  box-shadow: 5px 5px 16px black;
}

.nav-dropdown-content-nohover {
  display: none;
  position: absolute;
  width: 250px;
  right: -25px;
  overflow: auto;
  box-shadow: 5px 5px 16px black;
}

.nav-dropdown-content a {
  display: block;
  color: white;
  padding: 5px;
  text-decoration: none;
  transition: background-color 200ms;
}

.nav-dropdown-content-nohover a {
  display: block;
  color: white;
  padding: 5px;
  text-decoration: none;
  transition: background-color 200ms;
  cursor: default;
}

.nav-dropdown:hover .nav-dropdown-content {
  display: block;
  background-color: rgb(0, 116, 189);
  border-radius: 5px;
}

.nav-dropdown:hover .nav-dropdown-content-nohover {
  display: block;
  background-color: rgb(0, 116, 189);
  border-radius: 5px;
}

.nav-dropdown-content a:hover {
  color: #ffffff;
  background-color: rgb(0, 96, 156);
}

.nav-text {
  color: white;
  margin-top: 10 px;
  display: inline;
  height: 100%;
  margin-bottom: 0;
  line-height: 30px;
  cursor: default;
}

.verticalLine {
  border-color: rgb(0, 96, 156);
  border-style: none solid none none;
  display: inline;
  height: 100%;
  position: relative;
  z-index: 1px;
  margin-left: 5px;
  margin-right: 5px;
  display: inline;
}

#money-dropdown {
  visibility: hidden;
  position: fixed;
  top: -100px;
}

.menu-dropdown {
  visibility: hidden;
  position: fixed;
  top: -100px;
}

#div-notification {
  background-color: '.$notificationType.';
  position: fixed;
  width: 100%;
  height: 30px;
  top: 40px;
  color: white;
  text-align: center;
  line-height: 30px;
  font-size: 18px;
    z-index: 15px;
}

@media only screen and (max-width: 1270px) {
  #money-dropdown {
    visibility: visible;
    position: relative;
    top: 0;
  }

  .robuxs-amount-div {
    visibility: hidden;
    position: fixed;
    top: -1000px;
  }
  .tixs-amount-div {
    visibility: hidden;
    position: fixed;
    top: -1000px;
  }

  .nav-player-name {
    visibility: hidden;
    position: fixed;
    top: -1000px;
  }
}

@media only screen and (max-width: 820px) {
  .hide-at-sm {
    visibility: hidden;
    position: fixed;
    top: -1000px;
  }
  .menu-dropdown {
    visibility: visible;
    position: relative;
    top: 0;
  }
}
</style>
	  <html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  
  </head>
  <body>
    <nav class="nav-bar" id="nav-bar">
      <div class="nav-bar-div">
        <a href="/">
          <img
            src="../funnylogo.png"
            alt=""
            class="multrbx-nav-logo"
          />
        </a>

        <div class="verticalLine"></div>

        <a href="/games">
          <button class="nav-button hide-at-sm">Games</button>
        </a>

        <a href="/catalog">
          <button class="nav-button hide-at-sm">Catalog</button>
        </a>

        <a href="/develop">
          <button class="nav-button hide-at-sm">Develop</button>
        </a>






        

      


    <div id="div-banner">
      <div id="div-notification">
  <!-- JavaScript will insert the notification here -->
      </div>
    </div>

    <br id="nav-bar-seperator-1" /><br id="nav-bar-seperator-2" />

    <script>
      var check = null;
      const navBar = document.getElementById("nav-bar");
      const navBarBr1 = document.getElementById("nav-bar-seperator-1");
      const navBarBr2 = document.getElementById("nav-bar-seperator-2");

      window.mobileCheck = function () {
        let check = false;
        (function (a) {
          if (
            /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(
              a
            ) ||
            /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(
              a.substr(0, 4)
            )
          )
            check = true;
        })(navigator.userAgent || navigator.vendor || window.opera);
        return check;
      };
      if (mobileCheck(check)) {
        navBar.remove();
        navBarBr1.remove();
        navBarBr2.remove();
      }


           // NOTIFICATION BANNER

          const notificationBanner = document.getElementById("div-notification");
    const notification = '.$Notification['text'].';
    const showNotification = true;


      //semantic colours

      const infoColour = "#59a7ff"; //blue
      const warningColour = "#ffae29"; //yellow
      const dangerColour = "#ff1414"; //red
      const positiveColour = "#97ff6b"; //green
      const otherColour = "#a8a8a8"; //grey

      const notificationType = warningColour;

      if (!showNotification) {
        notificationBanner.remove();
      }

      notificationBanner.textContent = notification.toString();
      notificationBanner.style.backgroundColor = '.$notificationType.';
          notificationBanner.style.opacity = 1;
    </script>
  </body>
</html>';
        break;
    break;
}
?>


</body>
</html>
