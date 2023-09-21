<?php
require ("core/header.php");
?>
<?php
require ("core/nav.php");
?>
<?php
// main login code

		?>
		<div id="RobloxAtAGlance">
			<h2><?=$sitename?> Virtual Playworld</h2>
			<h3><?=$sitename?> is Free!</h3>
			<ul id="ThingsToDo">
				<li id="Point1">
					<h3>Build your personal Place</h3>
					<div>Create buildings, vehicles, scenery, and traps with thousands of virtual bricks.</div>
				</li>
				<li id="Point2">
					<h3>Meet new friends online</h3>
					<div>Visit your friend's place, chat in 3D, and build together.</div>
				</li>
				<li id="Point3">
					<h3>Battle in the Brick Arenas</h3>
					<div>Play with the slingshot, rocket, or other brick battle tools.  Be careful not to get "bloxxed".</div>
				</li>
			</ul>
			<div id="Showcase">
				<!--embed style="width:400px; height:326px;" id="VideoPlayback" type="application/x-shockwave-flash" src="http://video.google.com/googleplayer.swf?docId=2296704981611021533&hl=en" flashvars="" /-->

			<iframe id="embedplayer" src="http://www.bitview.net/embed.php?v=W41yC8kq3Vt" width="400" height="326" allowfullscreen scrolling="off" frameborder="0"></iframe>

			</div>
			<div id="Install">
				<div id="CompatibilityNote"><div id="ctl00_cphRoblox_pCompatibilityNote">
	Works with your<br/>Windows PC!
</div></div>
				<div id="DownloadAndPlay"><a id="ctl00_cphRoblox_hlDownloadAndPlay" href="/install"><img src="images/DownloadAndPlay.png" alt="FREE - Download and Play!" border="0"/></a></div>
			</div>
			<div id="ctl00_cphRoblox_pForParents">
				<div id="ForParents">
					<a id="ctl00_cphRoblox_hlKidSafe" title="<?=$sitename?> is kid-safe!" href="Parents.html" style="display:inline-block;"><img title="<?=$sitename?> is kid-safe!" src="images/COPPASeal-150x150.png" border="0"/></a>
				</div>
</div>
		</div>
		<div id="UserPlacesPane">
			<div id="UserPlaces_Content">
				<table id="ctl00_cphRoblox_DataListCoolPlace" cellspacing="0" border="0" width="100%">
	<tr>
		<td class="UserPlace">
						<a id="ctl00_cphRoblox_DataListCoolPlace_ctl00_rbxContentImage" title="Crossroads" href="Place_id_1818.html" style="display:inline-block;cursor:pointer;"><img src="t5_subdomain/Place-120x70-4caebf1df59f3e62f6cff6741433fb81.Png" border="0" id="img" alt="Crossroads"/></a>
					</td><td class="UserPlace">
						<a id="ctl00_cphRoblox_DataListCoolPlace_ctl01_rbxContentImage" title="City Wall" href="Place_id_20538.html" style="display:inline-block;cursor:pointer;"><img src="t2_subdomain/Place-120x70-f4f5bb09442d66a8d225643e9f640831.Png" border="0" id="img" alt="City Wall"/></a>
					</td><td class="UserPlace">
						<a id="ctl00_cphRoblox_DataListCoolPlace_ctl02_rbxContentImage" title="✪Ultimate Paintball CTF" href="Place_id_47828.html" style="display:inline-block;cursor:pointer;"><img src="t1_subdomain/Place-120x70-2c8ee77fa67d614896ece97cc8931777.Png" border="0" id="img" alt="✪Ultimate Paintball CTF"/></a>
					</td><td class="UserPlace">
						<a id="ctl00_cphRoblox_DataListCoolPlace_ctl03_rbxContentImage" title="Roblox Soccer" href="Place_id_47930.html" style="display:inline-block;cursor:pointer;"><img src="t3_subdomain/Place-120x70-ffa3622dc9b700017d1ed3a73d6f95b5.Png" border="0" id="img" alt="Roblox Soccer"/></a>
					</td><td class="UserPlace">
						<a id="ctl00_cphRoblox_DataListCoolPlace_ctl04_rbxContentImage" title="Gold Digger! NEW CHARACTER CLASSES!" href="Place_id_179994.html" style="display:inline-block;cursor:pointer;"><img src="t7_subdomain/Place-120x70-f65e5cfc0ebc27a7725c7ca527435d9e.Png" border="0" id="img" alt="Gold Digger! NEW CHARACTER CLASSES!"/></a>
					</td>
	</tr>
</table>
			</div>
			<div id="UserPlaces_Header">
				<h3>Cool Places</h3>
				<p>Check out some of our favorite <?=$sitename?> places!</p>
			</div>
			<div id="ctl00_cphRoblox_ie6_peekaboo" style="clear: both"></div>
		</div>
	</div>
				</div>
				<?php
				require ("core/footer.php");
				?>
				</body>
</html>