
function start(placeId, portus, url)
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

	game:GetService("BadgeService"):SetPlaceId(placeId)

	game:GetService("BadgeService"):SetIsBadgeLegalUrl("")
	game:GetService("InsertService"):SetBaseSetsUrl(url .. "/Game/Tools/InsertAsset.ashx?nsets=10&type=base")
	game:GetService("InsertService"):SetUserSetsUrl(url .. "/Game/Tools/InsertAsset.ashx?nsets=20&type=user&userid=%d")
	game:GetService("InsertService"):SetCollectionUrl(url .. "/Game/Tools/InsertAsset.ashx?sid=%d")
	game:GetService("InsertService"):SetAssetUrl(url .. "/asset/?id=%d")
	game:GetService("InsertService"):SetAssetVersionUrl(url .. "/asset/?assetversionid=%d")
        game:GetService("SocialService"):SetGroupUrl(url .. "/Game/LuaWebService/HandleSocialRequest.ashx?method=IsInGroup&playerid=%d&groupid=%d")
        game:GetService("SocialService"):SetGroupRankUrl(url .. "/Game/LuaWebService/HandleSocialRequest.ashx?method=GetGroupRank&playerid=%d&groupid=%d")
        game:GetService("SocialService"):SetGroupRoleUrl(url .. "/Game/LuaWebService/HandleSocialRequest.ashx?method=GetGroupRole&playerid=%d&groupid=%d")
	pcall(function() loadfile(url .. "/Game/LoadPlaceInfo.ashx?PlaceId=" .. placeId)() end)
	
	-- pcall(function() 
	--			if access then
	--				loadfile(url .. "/Game/PlaceSpecificScript.ashx?PlaceId=" .. placeId .. "&" .. access)()
	--			end
	--		end)
end

pcall(function() game:GetService("NetworkServer"):SetIsPlayerAuthenticationRequired(false) end)
settings().Diagnostics.LuaRamLimit = 0
--settings().Network:SetThroughputSensitivity(0.08, 0.01)
--settings().Network.SendRate = 35
--settings().Network.PhysicsSend = 0  -- 1==RoundRobin





game:GetService("Players").PlayerAdded:connect(function(player)
    print("Player " .. player.userId .. " added")
	local num = #game.Players:GetPlayers()
    	game:HttpGet("http://www.mulrbx.com/game/playerslistconnect.php?id="..placeId.."&players="..num,true)


end)


game:GetService("Players").PlayerRemoving:connect(function(player)
	print("Player " .. player.userId .. " leaving")

	local num = #game.Players:GetPlayers()
    	game:HttpGet("http://www.mulrbx.com/game/playerslistconnect.php?id="..placeId.."&players="..num,true)
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
end

-- Now start the connection
if placeId == 2 then
portus = 53642
elseif placeId == 4 then
portus = 53643
elseif placeId == 5 then
portus = 53644
elseif placeId == 6 then
portus = 53645
elseif placeId == 7 then
portus = 53646
elseif placeId == 8 then
portus = 53647
elseif placeId == 9 then
portus = 53648
elseif placeId == 10 then
portus = 53649
elseif placeId == 11 then
portus = 53650
elseif placeId == 12 then
portus = 53651
elseif placeId == 13 then
portus = 53652
elseif placeId == 14 then
portus = 53653
elseif placeId == 15 then
portus = 53654
elseif placeId == 16 then
portus = 53655
elseif placeId == 17 then
portus = 53656
elseif placeId == 18 then
portus = 53657
elseif placeId == 19 then
portus = 53658
elseif placeId == 20 then
portus = 53659
elseif placeId == 21 then
portus = 53660
elseif placeId == 22 then
portus = 53661
elseif placeId == 23 then
portus = 53662
elseif placeId == 24 then
portus = 53663
elseif placeId == 25 then
portus = 53664
elseif placeId == 26 then
portus = 53665
elseif placeId == 27 then
portus = 53666
elseif placeId == 28 then
portus = 53667
elseif placeId == 29 then
portus = 53668
elseif placeId == 30 then
portus = 53669
elseif placeId == 31 then
portus = 53670
elseif placeId == 32 then
portus = 53671
elseif placeId == 33 then
portus = 53672
elseif placeId == 34 then
portus = 53673
elseif placeId == 35 then
portus = 53674
elseif placeId == 36 then
portus = 53675
elseif placeId == 37 then
portus = 53676
elseif placeId == 38 then
portus = 53677
elseif placeId == 39 then
portus = 53678
elseif placeId == 40 then
portus = 53679
elseif placeId == 41 then
portus = 53680
elseif placeId == 42 then
portus = 53681
elseif placeId == 43 then
portus = 53682
elseif placeId == 44 then
portus = 53683
elseif placeId == 45 then
portus = 53684
elseif placeId == 46 then
portus = 53685
elseif placeId == 47 then
portus = 53686
elseif placeId == 48 then
portus = 53687
elseif placeId == 49 then
portus = 53688
elseif placeId == 50 then
portus = 53689
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

         game:HttpGet("http://mulrbx.com/reset?id=".. placeId)
         
       print("bye game id : " .. placeId)  

pcall(function() game:HttpGet("http://mulrbx.com/soap/amogs/Roblox/gameclose?job=".. game.JobId) end)



    end
end
end)


end



