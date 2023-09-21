<?php 
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/FuncTypes.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
appCheckRedirect("Games");
?>

<!DOCTYPE html>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/ContextHeader.php'); ?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/js/IncludeJS.php'); ?>
<?php switch(true){case ($admin == 0):die(header("Location: mulrbx.com/games"));break;} ?>


<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/Roblox.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/UnifiedModal.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/GenericModal.css' />
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Games/Games.css' />
<script type="text/javascript" src="<?php echo $baseUrl; ?>/js/Games/GamesDisplayShared.js"></script>
<script type="text/javascript" src="<?php echo $baseUrl; ?>/js/Games/GamesListBehavior.js"></script>
<script type="text/javascript" src="<?php echo $baseUrl; ?>/js/Games/GamesPageContainerBehavior.js"></script>
<link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Pages/Games/Games.css' />
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<div id="GamesPageLeftColumn">
               <div id="GamesPageHeader">
                <h1><span class="games-filter-resetter">Games</span></h1>
               </div>
               
         <div id="RepositionBody">
          <div id="Body" style="width:auto; min-width:970px;">
<div id="GamesListsContainer">
                <div class="games-list-container overflow-hidden" id="GamesListContainer0" data-sortfilter="0" >
                 <div class="games-list-header games-filter-changer">
                  <h2>All</h2>
                 </div>
                 
                 <div class="games-list">
                  <div class="show-in-multiview-mode-only">
                     <div>
<?php
                    $ActionFetch = $MainDB->prepare("SELECT * FROM asset WHERE itemtype = 'place' ORDER BY played DESC");
                    $ActionFetch->execute();
                    $ActionRows = $ActionFetch->fetchAll();
                    switch(true){
                      case ($ActionRows):
                        foreach($ActionRows as $GameInfo){
                          echo '
                            <div class="games-list-column">
                             <div class="game-item">
                              <div class="always-shown">
                                 <a class="game-item-anchor" rel="external" href="'. $baseUrl .'/Games/ViewGameadmin.ashx?id='. $GameInfo["id"] .'">
                                  <span class=""><img class="game-item-image" src="'. $baseUrl .'/Tools/Asset.ashx?id='. $GameInfo["id"] .'&request=place"></span>
                                  <div class="game-name notranslate">
                                   '. $GameInfo["name"] .'  
                                  </div>
                                 </a>
                                 <span class="player-count deemphasized notranslate">
                                 ' . $GameInfo["played"] . ' players online
                                 </span>
                                 <span class="online-player roblox-player-text" style="float: left"></span>
                                 <div class="show-on-hover-only deemphasized hidden">
                                  <div class="creator-name notranslate">
                                   by <a href="'. $baseUrl .'/User.php?id='. $GameInfo["creatorid"] .'">'. $GameInfo["creatorname"] .'</a>
                                  </div>
                                 </div>
                              </div>
                              <div class="hover-shown deemphasized ">
                                 <div class="snap-bottom snap-left">
                                  <div>
                                   played <span class="roblox-plays-count notranslate">'. $GameInfo["played"] .'</span> times
                                  </div>
                                  <div class=" game-thumbs-up-down notranslate">
                                   <span class="tiny-thumbs-up"></span>'. $GameInfo["liked"] .' &nbsp;  |  &nbsp; '. $GameInfo["disliked"] .'<span class="tiny-thumbs-down"></span>
                                  </div>
                                 </div>
                                 <div class="snap-bottom snap-right">
                                 </div>
                              </div>
                             </div>
                            </div>';
                        }
                        break;
                      default:
                        echo "<span>No games.</span>";
                        break;
                    }
                    ?>
					</div>
                  </div>
                 </div>
                </div>
				
			 </div>
           </div>
		    </div>
           </div></div>
					
					  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
  <style>
    .big {
      font-size: 60px;
    }

    .card-main {
      margin: 100px;
    }

    .card-blurb {
      display: flex;
      margin-left: 100px;
      margin-top: 400px;
    }

    .card-feed {
      margin-left: 450px;
      margin-top: -687px;
    }

    .feed-message-avatar {
      width: 80px;
    }
  </style>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
  
  </html>