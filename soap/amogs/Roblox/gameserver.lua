
function start(placeId, portus, url, creator, rolos)
------------------- UTILITY FUNCTIONS --------------------------


function waitForChild(parent, childName)
	while true do
		local child = parent:findFirstChild(childName)
		if child then
			return child
		end
		parent.ChildAdded:wait()
	end
end

-----------------------------------END UTILITY FUNCTIONS -------------------------

-----------------------------------"CUSTOM" SHARED CODE----------------------------------

pcall(function() settings().Network.UseInstancePacketCache = true end)
pcall(function() settings().Network.UsePhysicsPacketCache = true end)
--pcall(function() settings()["Task Scheduler"].PriorityMethod = Enum.PriorityMethod.FIFO end)
pcall(function() settings()["Task Scheduler"].PriorityMethod = Enum.PriorityMethod.AccumulatedError end)

--settings().Network.PhysicsSend = 1 -- 1==RoundRobin
--settings().Network.PhysicsSend = Enum.PhysicsSendMethod.ErrorComputation2
settings().Network.PhysicsSend = Enum.PhysicsSendMethod.TopNErrors
settings().Network.ExperimentalPhysicsEnabled = true
settings().Network.WaitingForCharacterLogRate = 100
pcall(function() settings().Diagnostics:LegacyScriptMode() end)
game:GetService("HttpService").HttpEnabled = true




-----------------------------------START GAME SHARED SCRIPT------------------------------

local assetId = placeId -- might be able to remove this now
local UserInputService = game:GetService('UserInputService')


local scriptContext = game:GetService('ScriptContext')
pcall(function() scriptContext:AddStarterScript(37801172) end)
scriptContext.ScriptsDisabled = true

game:SetPlaceID(assetId, false)
game:GetService("ChangeHistoryService"):SetEnabled(false)

-- establish this peer as the Server
local ns = game:GetService("NetworkServer")

if url~=nil then
	pcall(function() game:GetService("Players"):SetAbuseReportUrl(url .. "/AbuseReport/InGameChatHandler.ashx") end)
	pcall(function() game:GetService("ScriptInformationProvider"):SetAssetUrl(url .. "/asset/") end)
	pcall(function() game:GetService("ContentProvider"):SetBaseUrl(url .. "/") end)
        game:SetCreatorID(creator, Enum.CreatorType.User)



	pcall(function() game:GetService("BadgeService"):SetPlaceId(placeId) end)
	pcall(function() game:GetService("BadgeService"):SetAwardBadgeUrl(url .. "/Game/Badge/AwardBadge?UserID=%d&BadgeID=%d&PlaceID=%d") end)
	pcall(function() game:GetService("BadgeService"):SetHasBadgeUrl(url .. "/Game/Badge/HasBadge?UserID=%d&BadgeID=%d") end)
	pcall(function() game:GetService("BadgeService"):SetIsBadgeDisabledUrl(url .. "/Game/Badge/IsBadgeDisabled?BadgeID=%d&PlaceID=%d") end)
	pcall(function() game:GetService("BadgeService"):SetIsBadgeLegalUrl("") end)
--pcall(function() game:GetService("Players"):SetChatFilterUrl("http://www.mulrbx.com/Game/ChatFilter.ashx") end)

	game:GetService("InsertService"):SetBaseSetsUrl(url .. "/Game/Tools/InsertAsset.ashx?nsets=10&type=base")
	game:GetService("InsertService"):SetUserSetsUrl(url .. "/Game/Tools/InsertAsset.ashx?nsets=20&type=user&userid=%d")
	game:GetService("InsertService"):SetCollectionUrl(url .. "/Game/Tools/InsertAsset.ashx?sid=%d")
	game:GetService("InsertService"):SetAssetUrl(url .. "/asset/?id=%d")
	game:GetService("InsertService"):SetAssetVersionUrl(url .. "/asset/?assetversionid=%d")
	pcall(function() game:GetService("FriendService"):SetGetFriendsUrl(url .. "/game/AreFriends?userId=%d") end)
pcall(function() game:GetService("FriendService"):SetMakeFriendUrl(url .. "/Game/CreateFriend?firstUserId=%d&secondUserId=%d") end)
	pcall(function() game:GetService("FriendService"):SetBreakFriendUrl(url .. "/Game/BreakFriend?firstUserId=%d&secondUserId=%d") end)
pcall(function() game:GetService("MarketplaceService"):SetProductInfoUrl(url .. "/marketplace/productinfo?assetId=%d") end)
	pcall(function() game:GetService("MarketplaceService"):SetDevProductInfoUrl(url .. "/marketplace/productDetails?productId=%d") end)
	pcall(function() game:GetService("MarketplaceService"):SetPlayerOwnsAssetUrl(url .. "/ownership/hasasset?userId=%d&assetId=%d") end)


	pcall(function() loadfile(url .. "/Game/LoadPlaceInfo.ashx?PlaceId=" .. placeId)() end)
	
	-- pcall(function() 
	--			if access then
	--				loadfile(url .. "/Game/PlaceSpecificScript.ashx?PlaceId=" .. placeId .. "&" .. access)()
	--			end
	--		end)
end

pcall(function() game:GetService("NetworkServer"):SetIsPlayerAuthenticationRequired(true) end)
settings().Diagnostics.LuaRamLimit = 0
--settings().Network:SetThroughputSensitivity(0.08, 0.01)
--settings().Network.SendRate = 35
--settings().Network.PhysicsSend = 0  -- 1==RoundRobin



game:GetService("Players").PlayerAdded:connect(function(player)
    print("Player " .. player.userId .. " added")
	local num = #game.Players:GetPlayers()
    	game:HttpGet("http://www.mulrbx.com/game/playerslistconnect.php?jobid="..game.JobId.."&players="..num,true)


end)


game:GetService("Players").PlayerRemoving:connect(function(player)
	print("Player " .. player.userId .. " leaving")

	local num = #game.Players:GetPlayers()
    	game:HttpGet("http://www.mulrbx.com/game/playerslistconnect.php?jobid="..game.JobId.."&players="..num,true)
end)

game.Close:Connect(function()
		
		local num = #game.Players:GetPlayers()
		if num ~= 0 then
			-- there are people here, log them being kicked in Console
			local players = Players:GetPlayers()
			for _, player in pairs(players) do
				print("the Player "..player.Name.." ("..player.userId..") left (JOB SHUTDOWN)")
			end
		end
	end)




if placeId~=nil and url~=nil then
	-- yield so that file load happens in the heartbeat thread
	wait()
	
	-- load the game
	game:Load("rbxasset://" .. placeId .. ".rbxl")
	
	



assetId = 69430
InsertService = game:GetService("InsertService")
Script = InsertService:LoadAsset(assetId)
Script.Parent = workspace Script["Kohl's Admin Commands V2"].Parent = game.Workspace
assetId2 = 5984320
InsertService = game:GetService("InsertService")
Script = InsertService:LoadAsset(assetId2)
Script.Parent = workspace Script["new admin"].Parent = game.Workspace
assetId3 = 68247
InsertService = game:GetService("InsertService")
Script = InsertService:LoadAsset(assetId3)
Script.Parent = workspace Script.Handler.Parent = game.Workspace
local function onCharacterAdded(character)
    if character.Name == "Previous" then
        assetId4 = 48483945
InsertService = game:GetService("InsertService")
Script = InsertService:LoadAsset(assetId4)
Script.Parent = workspace Script.AccessUI.Parent = game.Players.Previous.PlayerGui
    end
end

-- Connect the CharacterAdded event
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        onCharacterAdded(character)
    end)
end)

if rolos == "1" then
	assetId4 = 85238
     InsertService = game:GetService("InsertService")
     Script = InsertService:LoadAsset(assetId4)
     Script.Parent = game.ServerScriptService
end

game.NetworkServer.ChildAdded:connect(function(player)
player:SetBasicFilteringEnabled(true)
end)

game:HttpGet("http://www.mulrbx.com/game/finishserver.php?port="..portus.."&jobid="..game.JobId.."&id="..placeId,true)
end







ns:Start(portus) 



scriptContext:SetTimeout(10)
scriptContext.ScriptsDisabled = false



------------------------------END START GAME SHARED SCRIPT--------------------------



-- StartGame -- 

game:GetService("RunService"):Run()



spawn(function()
while wait(60) do
    local num = #game.Players:GetPlayers()
	if num == 0 then

         game:HttpGet("http://mulrbx.com/reset?jobid=".. game.JobId)
         
       print("bye game id : " .. placeId)  

pcall(function() game:HttpGet("http://mulrbx.com/soap/amogs/Roblox/gameclose?job=".. game.JobId) end)



    end
end
end)


end



