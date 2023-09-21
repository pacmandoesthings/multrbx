<?php
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/FuncTypes.php');
include($_SERVER['DOCUMENT_ROOT'] . '/Login/LoggonAPI/UserInfo.php');
appCheckRedirect("Games");
?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/Assembly/ContextHeader.php'); ?>
<?php include($_SERVER['DOCUMENT_ROOT'] . '/js/IncludeJS.php'); ?>
<?php 
if ($theme !== 1) {
echo "<link rel='stylesheet' href='http://mulrbx.com/CSS/Base/CSS/Roblox.css' />";
}
?><link rel='stylesheet' href='<?php echo $baseUrl; ?>/CSS/Base/CSS/StyleGuide.css' />
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
                <div class="games-list-container overflow-hidden" id="GamesListContainer0" data-sortfilter="0">
                    <div class="games-list-header games-filter-changer">
                        <h2>All</h2>
                    </div>

                    <div class="games-list">
                        <div class="show-in-multiview-mode-only">
                            <div>
                                <?php
                                $ActionFetch = $MainDB->prepare("
                                    SELECT a.*, IFNULL(os.totalPlayerCount, 0) AS playersOnline
                                    FROM asset AS a
                                    LEFT JOIN (
                                        SELECT gameID, SUM(playerCount) AS totalPlayerCount
                                        FROM open_servers
                                        WHERE playerCount > 0
                                        GROUP BY gameID
                                    ) AS os ON a.id = os.gameID
                                    WHERE a.approved = '1' AND a.public = '1' AND a.itemtype = 'place'
                                    ORDER BY playersOnline DESC
                                ");
                                $ActionFetch->execute();
                                $ActionRows = $ActionFetch->fetchAll();

                                foreach ($ActionRows as $GameInfo) {
                                    $playersOnline = intval($GameInfo['playersOnline']);

                                    echo '
                                        <div class="games-list-column">
                                            <div class="game-item">
                                                <div class="always-shown">
                                                    <a class="game-item-anchor" rel="external" href="' . $baseUrl . '/Games/ViewGame.ashx?id=' . $GameInfo["id"] . '">
                                                        <span class=""><img class="game-item-image" src="' . $baseUrl . '/Tools/Asset.ashx?id=' . $GameInfo["id"] . '&request=place"></span>
                                                        <div class="game-name notranslate">
                                                            ' . $GameInfo["name"] . '  
                                                        </div>
                                                    </a>
                                                    <span class="player-count deemphasized notranslate">
                                                        ' . $playersOnline . ' players online
                                                    </span>
                                                    <span class="online-player roblox-player-text" style="float: left"></span>
                                                    <div class="show-on-hover-only deemphasized hidden">
                                                        <div class="creator-name notranslate">
                                                            by <a href="' . $baseUrl . '/User.php?id=' . $GameInfo["creatorid"] . '">' . $GameInfo["creatorname"] . '</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="hover-shown deemphasized ">
                                                    <div class="snap-bottom snap-left">
                                                        <div>
                                                            played <span class="roblox-plays-count notranslate">' . $playersOnline . '</span> times
                                                        </div>
                                                        <div class=" game-thumbs-up-down notranslate">
                                                            <span class="tiny-thumbs-up"></span>' . $GameInfo["liked"] . ' &nbsp;  |  &nbsp; ' . $GameInfo["disliked"] . '<span class="tiny-thumbs-down"></span>
                                                        </div>
                                                    </div>
                                                    <div class="snap-bottom snap-right">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>';
                                }

                                if (empty($ActionRows)) {
                                    echo "<span>No games.</span>";
                                }
                                ?>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>


</html>
