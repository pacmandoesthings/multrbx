<?php
include($_SERVER['DOCUMENT_ROOT'] . '/UserInfo.php');
include($_SERVER['DOCUMENT_ROOT'] . '/config.php');
require_once '../content/functions.php';

?>
<link rel="stylesheet" href="https://mulrbx.com/content/css/CSSMain.css">
		<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="https://mulrbx.com/content/css/CSSMain23.css">
		<link rel="stylesheet" href="https://mulrbx.com/content/css/CSS1.css">
		<link rel="stylesheet" href="https://mulrbx.com/content/css/CSS10.css">
		<link rel="stylesheet" href="https://mulrbx.com/content/css/HomePage.css">
		<link rel="stylesheet" href="https://mulrbx.com/content/css/leanbasenew.css">
		<?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/ContextHeader.php');  ?>
    <div class="container-main">
            <script type="text/javascript">
                if (top.location != self.location) {
                    top.location = self.location.href;
                }
            </script>
        <noscript>&lt;div&gt;&lt;div class="alert-info" role="alert"&gt;Please enable Javascript to use all the features on this site.&lt;/div&gt;&lt;/div&gt;</noscript>
        <div class="content ">

                            <div id="Skyscraper-Adp-Left" class="abp abp-container left-abp"></div>

        <div id="HomeContainer" class="row home-container" data-update-status-url="/home/updatestatus">

    <div class="col-xs-12 home-header">
        <a href="../User?ID=" class="avatar avatar-headshot-lg">
            <img alt="avatar" src="../Tools/RenderedUsers/<?php echo $id; ?>.png" id="home-avatar-thumb" class="avatar-card-image">
        </a>

        <script type="text/javascript">
            $("img#home-avatar-thumb").on('load', function () {
                if (Roblox && Roblox.Performance) {
                    Roblox.Performance.setPerformanceMark("head_avatar");
                }
            });
        </script>
        <div class="home-header-content ">
            <h1>
                <a href="User.aspx?ID=<?php echo $id; ?>">Hello, <?php echo $name ?>!</a>
            </h1>
            <?php
            if($membership == 1){
            echo '<span class="icon-bc"></span>';
            }else if($membership == 2){
                echo '<span class="icon-tbc"></span>';
            }else if($membership == 3){
                echo '<span class="icon-obc"></span>';
            }
            ?>
        </div>
    </div>
	  <div class="col-xs-12 section home-friends">
            <div class="container-header">
                <h2>Friends (0)</h2>
                <a href="Friends.aspx" class="btn-secondary-xs btn-more btn-fixed-width">See All</a>
            </div>

            <div class="section-content">
                <span>nah.</span>
            </div>
        </div>

        <div id="recently-visited-places" class="col-xs-12 container-list home-games">
            <div class="container-header">
                <h2>Recently Played</h2>
<a href="" class="btn-secondary-xs btn-more btn-fixed-width">See All</a>            </div>

<ul class="hlist game-cards ">



<div id="my-favorties-games" class="col-xs-12 container-list home-games">
            <div class="container-header">
                <h2>My Favorites</h2>
<a href="" class="btn-secondary-xs btn-more btn-fixed-width">See All</a>            </div>

<div class="section-content">
<span>No Favorite Games.</span>
</div>
</div>

<div class="col-xs-12 col-sm-6 home-right-col">



   







</div>
<div id="Skyscraper-Adp-Right" class="abp abp-container right-abp"></div>

        </div>
            </div>