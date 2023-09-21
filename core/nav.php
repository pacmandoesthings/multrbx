<?php
// extra function for admin panel
$adm = "";
// logged in function for admin panel
$sitename = "Zeria";

?>
<div class="Navigation">
						<span><a id="ctl00_hlMyRoblox" class="MenuItem" href="/my/home">My <?=$sitename?></a></span>
						<span class="Separator">&nbsp;|&nbsp;</span>
						<span><a id="ctl00_hlGames" class="MenuItem" href="/Games">Games</a></span>
						<span class="Separator">&nbsp;|&nbsp;</span>
						<span><a id="ctl00_hlCatalog" class="MenuItem" href="/Catalog">Catalog</a></span>
						<span class="Separator">&nbsp;|&nbsp;</span>
						<span><a id="ctl00_hlBrowse" class="MenuItem" href="/users">People</a></span>
						<span class="Separator">&nbsp;|&nbsp;</span>
						<span><a id="ctl00_hlForum" class="MenuItem" href="/Forum">Forum</a></span>
                        <span class="Separator">&nbsp;|&nbsp;</span>
                        <span><a id="ctl00_hlNews" class="MenuItem" href="blog_subdomain/index.html" target="_blank">News</a>&nbsp;<a id="ctl00_hlNewsFeed" href="blog_subdomain/index.html"><img src="/images/feed-icons/feed-icon-14x14.png" border="0"/></a></span>
                        <?php
                        // admin panel will be fixed soon
                        echo $adm;
                        ?>
 					</div>
				</div>
				<?php echo $alert ?>
                
                
                