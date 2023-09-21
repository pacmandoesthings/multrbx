local this = {}

local Modules = game:GetService("CoreGui"):FindFirstChild("RobloxGui").Modules

local httpService = game:GetService('HttpService')
local marketplaceService = game:GetService('MarketplaceService')
local insertService = game:GetService('InsertService')

local assetTypeNames = require(Modules.LuaApp.Legacy.AvatarEditor.AssetTypeNames)
local categories = require(Modules.LuaApp.Legacy.AvatarEditor.Categories)
local AssetInfo = require(Modules.LuaApp.Legacy.AvatarEditor.AssetInfo)
local Strings = require(Modules.LuaApp.Legacy.AvatarEditor.LocalizedStrings)
local Urls = require(Modules.LuaApp.Legacy.AvatarEditor.Urls)
local Flags = require(Modules.LuaApp.Legacy.AvatarEditor.Flags)

local AppState = require(Modules.LuaApp.Legacy.AvatarEditor.AppState)

local SetOutfit = require(Modules.LuaApp.Actions.SetOutfit)
local SetBodyColors = require(Modules.LuaApp.Actions.SetBodyColors)
local SetScales = require(Modules.LuaApp.Actions.SetScales)
local SetAssets = require(Modules.LuaApp.Actions.SetAssets)
local SetAvatarType = require(Modules.LuaApp.Actions.SetAvatarType)

local TableUtilities = require(Modules.LuaApp.TableUtilities)

local function getModule(moduleName)
	return script.Parent:FindFirstChild(moduleName)
end

local utilities = require(getModule('Utilities'))
local ParticleScreen = require(getModule('ParticleScreen'))
local tweenPropertyController = require(getModule('TweenPropertyController'))
local tween = tweenPropertyController.tween
local easeFilters = require(getModule('EaseFilters'))

ParticleScreen.init()

this.bodyColorNameMap = {
	["HeadColor"] = 'headColorId',
	["LeftArmColor"] = 'leftArmColorId',
	["LeftLegColor"] = 'leftLegColorId',
	["RightArmColor"] = 'rightArmColorId',
	["RightLegColor"] = 'rightLegColorId',
	["TorsoColor"] = 'torsoColorId',
}

local defaultShirtModel = nil
local defaultPantsModel = nil

-- These sync up with chat username color order. The last clothing is a teal
-- color instead of a tan color like the usernames.
-- Username color list: "Bright red", "Bright blue", "Earth green", "Bright violet",
-- "Bright orange", "Bright yellow", "Light reddish violet", "Brick yellow"
local defaultShirtIds = {855776103, 855760101, 855766176, 855777286, 855768342, 855779323, 855773575, 855778084}
local defaultPantIds =  {855783877, 855780360, 855781078, 855782781, 855781508, 855785499, 855782253, 855784936}



local recentAssetLists = {}
local maxNumberOfRecentAssets = 200

local isInitialAssets = false


local function getRecentAssetList(name)
	return recentAssetLists[name]
end

local function createRecentAssetList(name)
	recentAssetLists[name] = {}
	return getRecentAssetList(name)
end

local function removeFromRecentAssetList(name, index)
	table.remove(this.getOrCreateRecentAssetList(name), index)
end

function this.addToRecentAssetList(name, item)
	local list = this.getOrCreateRecentAssetList(name)

	for i=#list, 1, -1 do
		if list[i] == item then
			removeFromRecentAssetList(name, i)
		end
	end

	table.insert(list, 1, item)
	while #list > maxNumberOfRecentAssets do
		removeFromRecentAssetList(name, maxNumberOfRecentAssets)
	end
end

function this.addAssetToRecentAssetList(assetId)
	-- add to the All list
	this.addToRecentAssetList('allAssets', assetId)

	-- add to specific lists
	utilities.fastSpawn(function()
		local assetInfo = AssetInfo.getAssetInfo(assetId)
		if assetInfo then
			local assetTypeName = assetTypeNames[assetInfo.AssetTypeId] or 'Failed Name'
			if string.find(assetTypeName, 'Accessory')
				or assetTypeName == 'Shirt'
				or assetTypeName == 'Pants'
				or assetTypeName == 'Gear'
				or assetTypeName == 'Hat'
				or assetTypeName == '' then
				this.addToRecentAssetList('clothing', assetId)
			elseif assetTypeName == 'Left Arm'
				or assetTypeName == 'Left Leg'
				or assetTypeName == 'Right Arm'
				or assetTypeName == 'Right Leg'
				or assetTypeName == 'Head'
				or assetTypeName == 'Torso'
				or assetTypeName == 'Face' then
				this.addToRecentAssetList('body', assetId)
			elseif string.find(assetTypeName, 'Animation') then
				this.addToRecentAssetList('animation', assetId)
			end
		end
	end)
end

function this.getOrCreateRecentAssetList(name)
	return getRecentAssetList(name) or createRecentAssetList(name)
end


local function getAllEquippedAssets()
	local result = {}
	local assets = AppState.Store:GetState().Character.Assets

	for _, assetList in pairs(assets) do
		for _, assetId in pairs(assetList) do
			table.insert(result, assetId)
		end
	end

	return result
end


local savedWearingAssets = {}
local savedAvatarType = nil
local savedScales = {
	Height = 1.00,
	Width = 1.00,
	Depth = 1.00,
	Head = 1.00,
}
local savedBodyColors = {
	["HeadColor"] = 194,
	["LeftArmColor"] = 194,
	["LeftLegColor"] = 194,
	["RightArmColor"] = 194,
	["RightLegColor"] = 194,
	["TorsoColor"] = 194,
}

local assetsLinkedContent = {}
local waitingForInitialLoad = true
local currentAnimationPreview = nil

local resumeAnimationEvent = Instance.new('BindableEvent')
local currentLookAroundAnimation = 0

local webServer = {
	get = function(url) return "" end;
	post = function(url, data) return true end;
}

local function getAvatarType()
	return AppState.Store:GetState().Character.AvatarType
end

local function getScales()
	return AppState.Store:GetState().Character.Scales
end

local function getBodyColors()
	return AppState.Store:GetState().Character.BodyColors
end

local function setSavedScales(scales)
	savedScales = utilities.copyTable(scales)
end

local function setSavedBodyColors(colors)
	savedBodyColors = utilities.copyTable(colors)
end

function this.syncSaved()
	savedWearingAssets = getAllEquippedAssets()
end


function this.isWearingAssetType(assetTypeName)
	for _, assetId in pairs(getAllEquippedAssets()) do
		if assetTypeNames[AssetInfo.getAssetInfo(assetId)] == assetTypeName then
			return true
		end
	end
	return false
end

function this.getCompleteAssetInfo(assetId)
	-- Ensures that certain fields are filled out.  The new web endpoint doesn't return descriptions
	-- so we need to get them as we need them.
	local assetInfo = AssetInfo.getAssetInfo(assetId)

	if assetInfo and not assetInfo.Description then
		local productInfo = marketplaceService:GetProductInfo(assetId)
		assetInfo.Description = productInfo.Description
	end

	return assetInfo
end

function this.findIfEquipped(assetId)
	for _,currentAssetId in pairs(getAllEquippedAssets()) do
		if currentAssetId == assetId then
			return true
		end
	end
	return false
end


function this.characterSave(doWait)
	if waitingForInitialLoad then
		warn("Did not save because initial character hasn't fully loaded")
		return
	end
	local bodyColorsFinished = false
	utilities.fastSpawn(function()
		local bodyColorsChanged = false
		local bodyColors = getBodyColors()
		for index, value in pairs(bodyColors) do
			if value ~= savedBodyColors[index] then
				bodyColorsChanged = true
				break
			end
		end
		if bodyColorsChanged then
			local sendingBodyColorsTable = {}
			for name,sendingName in pairs(this.bodyColorNameMap) do
				sendingBodyColorsTable[sendingName] = bodyColors[name]
			end
			local sendingBodyColorsData = httpService:JSONEncode(sendingBodyColorsTable)
			local successfulSave = webServer.post(Urls.avatarUrlPrefix.."/v1/avatar/set-body-colors", sendingBodyColorsData)
			if successfulSave then
				setSavedBodyColors(bodyColors)
			else
				warn('Failure Saving BodyColors')
			end
		end
		bodyColorsFinished = true
	end)

	local scalesFinished = false

	local function finishSavingScales()
		local scalesChanged = false
		local scales = getScales()
		for index, value in pairs(scales) do
			if value ~= savedScales[index] then
				scalesChanged = true
				break
			end
		end
		if scalesChanged then
			--local sendingScalesData = httpService:JSONEncode(scales)
			local sendingScalesData =
				'{"depth":'
				..string.format("%.4f", scales.Depth)
				..',"height":'
				..string.format("%.4f", scales.Height)
				..',"width":'
				..string.format("%.4f", scales.Width)
				..'}'

			local successfulSave = webServer.post(Urls.avatarUrlPrefix.."/v1/avatar/set-scales", sendingScalesData)
			if successfulSave then
				setSavedScales(scales)
			else
				warn('Failure Saving Scales')
			end
		end
		scalesFinished = true
	end

	utilities.fastSpawn(finishSavingScales)

	local avatarTypeFinished = false
	utilities.fastSpawn(function()
		local newAvatarType = getAvatarType()
		local avatarTypeChanged = savedAvatarType ~= newAvatarType
		if avatarTypeChanged then
			local successfulSave = webServer.post(Urls.avatarUrlPrefix.."/v1/avatar/set-player-avatar-type",
				'{"playerAvatarType":"'..newAvatarType..'"}')
			if successfulSave then
				savedAvatarType = newAvatarType
			else
				warn('Failure Saving AvatarType')
			end
		end
		avatarTypeFinished = true
	end)

	local assetsFinished = false
	utilities.fastSpawn(function()
		local assetsChanged = false
		local currentlyWearing = getAllEquippedAssets()
		for index, value in pairs(currentlyWearing) do
			if value ~= savedWearingAssets[index] then
				assetsChanged = true
				break
			end
		end
		for index, value in pairs(savedWearingAssets) do
			if value ~= currentlyWearing[index] then
				assetsChanged = true
				break
			end
		end
		if assetsChanged then

			local sendingAssetsData = httpService:JSONEncode({['assetIds']=currentlyWearing})
			local successfulSave =
				webServer.post(
					Urls.avatarUrlPrefix.."/v1/avatar/set-wearing-assets", sendingAssetsData)
			if successfulSave then
				savedWearingAssets = utilities.copyTable(currentlyWearing)
			else
				warn('Failure Saving WearingAssets')
			end
		end
		assetsFinished = true
	end)

	if doWait then
		while not (bodyColorsFinished
				and avatarTypeFinished
				and assetsFinished
				and scalesFinished) do
			wait()
		end
		return
	end
end


local templateCharacterR6
local templateCharacterR15
local character
local hrp
local humanoid

local partRestingOffsets = {}

function this.getRestingPartOffset(partName)
	return partRestingOffsets[partName] or CFrame.new()
end

function this.recalculateRestingPartOffsets()
	local root = character:FindFirstChild('HumanoidRootPart')

	local joints = {}
	for _, v in next, utilities.getDescendants(character) do
		if v:IsA('Motor6D') then
			if joints[v.Part0] == nil then
				joints[v.Part0] = {v}
			else
				table.insert(joints[v.Part0], v)
			end
			if joints[v.Part1] == nil then
				joints[v.Part1] = {v}
			else
				table.insert(joints[v.Part1], v)
			end
		end
	end

	if root then
		local open = {[root]=CFrame.new()}
		local closed = {[root]=CFrame.new()}

		while next(open) do
			local newOpen = {}
			for part, cframe in next, open do
				if joints[part] then
					for _, joint in next, joints[part] do
						local thisCFrame
						local other

						if joint.Part1 == part then
							other = joint.Part0
							thisCFrame = cframe * joint.C1 * joint.C0:inverse()
						else
							other = joint.Part1
							thisCFrame = cframe * joint.C0 * joint.C1:inverse()
						end

						if other and not closed[other] then
							newOpen[other] = thisCFrame
							closed[other] = thisCFrame
						end
					end
				end
			end
			open = newOpen
		end

		partRestingOffsets = {}
		for part, cframe in next, closed do
			partRestingOffsets[part.Name] = cframe
		end
	end
end

local characterNode = nil

local function getCharacterNode()
	if characterNode == nil then
		characterNode = Instance.new("Folder")
	end
	return characterNode
end


local function humanoidLoadAnimation(animation)
	local characterNodeParent = getCharacterNode().Parent
	getCharacterNode().Parent = game.Workspace
	local result = humanoid:LoadAnimation(animation)
	getCharacterNode().Parent = characterNodeParent
	return result
end

local toolHoldAnimationTrack = nil
local function holdToolPos(state)
	if toolHoldAnimationTrack then
		toolHoldAnimationTrack:Stop()
		toolHoldAnimationTrack = nil
	end
	if character and character.Parent and humanoid and humanoid:IsDescendantOf(game.Workspace) then
		if state == 'Up' then
			local animationsFolder = character:FindFirstChild('Animations')
			if animationsFolder then
				local toolHoldAnimationObject = animationsFolder:FindFirstChild('Tool')
				if toolHoldAnimationObject then
					toolHoldAnimationTrack = humanoidLoadAnimation(toolHoldAnimationObject)
					toolHoldAnimationTrack:Play(0)
				end
			end
		end
	end
end

local function findFirstMatchingAttachment(model, name)
	if model and name then
		for _, child in pairs(model:GetChildren()) do
			if child then
				if child:IsA('Attachment') and (not name or child.Name == name) then
					return child
				elseif child:IsA('Accoutrement') ~= true and child:IsA('Tool') ~= true then
					local foundAttachment = findFirstMatchingAttachment(child, name)
					if foundAttachment then
						return foundAttachment
					end
				end
			end
		end
	end
end

local function buildWeld(part0, part1, c0, c1, weldName)
	local weld = Instance.new('Weld')
	weld.C0 = c0
	weld.C1 = c1
	weld.Part0 = part0
	weld.Part1 = part1
	weld.Name = weldName
	weld.Parent = part0
	return weld
end


local function equipItemToCharacter(item)		-- Item should be an accessory or tool.
	if item and character then
		item.Parent = character
		local handle = item:FindFirstChild('Handle')
		if handle then
			handle.CanCollide = false

			local attachment = utilities.findFirstChildOfType(handle,'Attachment')
			local matchingAttachment = nil
			local matchingAttachmentPart = nil
			if attachment then
				matchingAttachment = findFirstMatchingAttachment(character, attachment.Name)
				if matchingAttachment then
					matchingAttachmentPart = matchingAttachment.Parent
				end
			end
			if matchingAttachmentPart then	-- This infers that both attachments were found
				buildWeld(
					handle,
					matchingAttachmentPart,
					attachment.CFrame,
					matchingAttachment.CFrame,
					"AccessoryWeld")
			else
				if item:IsA('Accoutrement') then
					local head = character:FindFirstChild('Head')
					if head then
						buildWeld(handle, head, item.AttachmentPoint, CFrame.new(0,.5,0), "AccessoryWeld")
					end
				elseif item:IsA('Tool') then
					local rightHand = character:FindFirstChild('RightHand')
					local rightArm = character:FindFirstChild('Right Arm')
					if rightHand then
						local gripCF = CFrame.new(0.0108650923, -0.168664441, -0.0154389441, 1, 0, -0, 0,
							6.12323426e-017, 1, 0, -1, 6.12323426e-017)
						buildWeld(handle, rightHand, item.Grip, gripCF, "RightGrip")
					elseif rightArm then
						local gripCF = CFrame.new(Vector3.new(0,-1,0))*CFrame.Angles(-math.pi*.5,0,0)
						buildWeld(handle, rightArm, item.Grip, gripCF, "RightGrip")
					end
				end

			end
		end
	end
end


local function sortAndEquipItemToCharacter(thing, assetInsertedContentList)
	if thing then
		if thing.className == 'ShirtGraphic' then
			return
		end

		utilities.recursiveDisable(thing)

		if thing:IsA("DataModelMesh") then				-- Head mesh
			local head = character:FindFirstChild('Head')
			if head then
				local replacedAsset = utilities.findFirstChildOfType(head, "DataModelMesh")
				if replacedAsset then
					replacedAsset:Destroy()
				end
				thing.Parent = head
				table.insert(assetInsertedContentList, thing)
			end

		elseif thing:IsA("Decal") then					-- Face
			local head = character:FindFirstChild('Head')
			if head then
				local replacedAsset = utilities.findFirstChildOfType(head, "Decal")
				if replacedAsset then
					replacedAsset:Destroy()
				end
				thing.Parent = head
				table.insert(assetInsertedContentList, thing)
			end

		elseif thing:IsA("CharacterAppearance") then	-- Thing, just parent it.
			thing.Parent = character
			table.insert(assetInsertedContentList, thing)

		elseif thing:IsA("Accoutrement") then			-- Hat
			equipItemToCharacter(thing)
			table.insert(assetInsertedContentList, thing)

		elseif thing:IsA("Tool") then					-- Gear
			equipItemToCharacter(thing)
			table.insert(assetInsertedContentList, thing)
			holdToolPos('Up')
		end
	end
end


local bodyColorMappedParts = {
	['Head']			 = 'HeadColor',

	['Torso']			 = 'TorsoColor',
	['UpperTorso']		 = 'TorsoColor',
	['LowerTorso']		 = 'TorsoColor',

	['Left Arm']		 = 'LeftArmColor',
	['LeftUpperArm']	 = 'LeftArmColor',
	['LeftLowerArm']	 = 'LeftArmColor',
	['LeftHand']		 = 'LeftArmColor',

	['Left Leg']		 = 'LeftLegColor',
	['LeftUpperLeg']	 = 'LeftLegColor',
	['LeftLowerLeg']	 = 'LeftLegColor',
	['LeftFoot']		 = 'LeftLegColor',

	['Right Arm']		 = 'RightArmColor',
	['RightUpperArm']	 = 'RightArmColor',
	['RightLowerArm']	 = 'RightArmColor',
	['RightHand']		 = 'RightArmColor',

	['Right Leg']		 = 'RightLegColor',
	['RightUpperLeg']	 = 'RightLegColor',
	['RightLowerLeg']	 = 'RightLegColor',
	['RightFoot']		 = 'RightLegColor',
}

local function updateCharacterBodyColors(bodyColors)
	bodyColors = bodyColors or getBodyColors()
	if character then
		for _,v in pairs(character:GetChildren()) do
			local foundLink = bodyColorMappedParts[v.Name]
			if v:IsA('BasePart') and foundLink then
				local bodyColorNumber = bodyColors[foundLink]
				if bodyColorNumber then
					v.BrickColor = BrickColor.new(bodyColorNumber)
				end
			end
		end
	end
end


local function replaceHead(newMesh)
	if character:FindFirstChild('Head') and character.Head:FindFirstChild('Mesh') then
		character.Head.Mesh:Destroy()
	end

	newMesh.Parent = character.Head
end


local function replaceFace(newFace)
	if character:FindFirstChild('Head') and character.Head:FindFirstChild('face') then
		character.Head.face:Destroy()
	end

	newFace.Parent = character.Head
end


local itemsOnR15 = {}


local function repositionR15Joints(joints)
	for _, v in next, joints or utilities.getDescendants(character) do
		if v:IsA('JointInstance') then
			local attachment0 = v.Part0:FindFirstChild(v.Name..'RigAttachment')
			local attachment1 = v.Part1:FindFirstChild(v.Name..'RigAttachment')

			if attachment0 and attachment1 then
				v.C0 = attachment0.CFrame
				v.C1 = attachment1.CFrame
			end
		end
	end
end


local function amendR15ForItemAddedAsModel(model)
	local info = {
		easyRemove = {},
		replacesR15Parts = {},
		replacesHead = false,
		replacesFace = false,
		hasTool = false
	}
	local bodyStuff = {}
	local otherStuff = {}

	-- Collect assets
	local stuff = {model}
	if stuff[1].ClassName == 'Model' then
		stuff = stuff[1]:GetChildren()
	end
	for _, thing in next, stuff do
		if thing.Name:lower() == 'r15' then
			for _, piece in next, thing:GetChildren() do
				table.insert(bodyStuff, piece)
			end
		elseif thing.Name:lower() ~= 'r6' then
			table.insert(otherStuff, thing)
		end
	end

	-- Replace body parts
	for _, thing in next, bodyStuff do
		if thing:IsA('MeshPart') then
			info.replacesR15Parts[thing.Name] = true

			if thing.Size.magnitude <= 0.002 then -- lua can't resize parts below 0.2, so just make them invisible
				thing.Transparency = 1
			end

			local oldThing = character:FindFirstChild(thing.Name)
			if oldThing then
				local thingClone = thing:Clone()
				thing.Parent = character

				local repositionTheseJoints = {}

				-- Reassign old joints, move important stuff to the new part
				for _, v in next, utilities.getDescendants(character) do
					if v:IsA('JointInstance') then
						if v.Part0 == oldThing then
							v.Part0 = thing
							table.insert(repositionTheseJoints, v)
						elseif v.Part1 == oldThing then
							v.Part1 = thing
							table.insert(repositionTheseJoints, v)
						end
						if v.Parent == oldThing then
							if thing:FindFirstChild(v.Name) then
								thing[v.Name]:Destroy()
							end
							v.Parent = thing
						end
					elseif v:IsA('Attachment') then
						if v.Parent == oldThing then
							if thing:FindFirstChild(v.Name) then
								thing[v.Name]:Destroy()
							end
							v.Parent = thing
						end
					end
				end

				oldThing:Destroy()

				for _, v in next, thing:GetChildren() do
					if v:IsA('Attachment') then
						if thingClone:FindFirstChild(v.Name) then
							v.CFrame = thingClone[v.Name].CFrame
							v.Axis = thingClone[v.Name].Axis
							v.SecondaryAxis = thingClone[v.Name].SecondaryAxis
						end
					end
				end

				repositionR15Joints(repositionTheseJoints)
			end
		else
			table.insert(otherStuff, thing)
		end
	end

	-- Equip tool
	for _, thing in next, otherStuff do
		if thing:IsA('DataModelMesh') then
			info.replacesHead = true
			replaceHead(thing)
		elseif thing:IsA('Decal') then
			info.replacesFace = true
			replaceFace(thing)
		elseif thing:IsA('CharacterAppearance') then
			thing.Parent = character
			table.insert(info.easyRemove, thing)

			-- have to refresh the character texture because clothes dont update
			character.Head.Transparency = character.Head.Transparency+1
			character.Head.Transparency = character.Head.Transparency-1
		elseif thing:IsA('Accoutrement') then
			equipItemToCharacter(thing)
			table.insert(info.easyRemove, thing)
		elseif thing:IsA('Tool') then
			equipItemToCharacter(thing)
			table.insert(info.easyRemove, thing)
			holdToolPos('Up')
			info.hasTool = true
		end
	end

	-- Rescale
	this.refreshCharacterScale()

	-- Update colors
	updateCharacterBodyColors()

	return info
end



local function amendR15ForItemRemoved(assetId)
	local info = itemsOnR15[assetId]
	itemsOnR15[assetId] = nil

	if info then
		if info.easyRemove then
			for _, v in next, info.easyRemove do
				v:Destroy()
			end
		end
		if info.replacesR15Parts then
			local replaceFolder = Instance.new'Folder'
			replaceFolder.Name = 'R15'

			for v in next, info.replacesR15Parts do
				if templateCharacterR15:FindFirstChild(v) then
					templateCharacterR15[v]:Clone().Parent = replaceFolder
				end
			end

			amendR15ForItemAddedAsModel(replaceFolder)
		end
		if info.replacesHead then
			replaceHead(templateCharacterR15.Head.Mesh:Clone())
		end
		if info.replacesFace then
			replaceFace(templateCharacterR15.Head.face:Clone())
		end
		if info.hasTool then
			holdToolPos('Down')
		end

		updateCharacterBodyColors()
	end
end


local function amendR15ForItemAdded(assetId)
-- insertService:LoadAsset() is a yeilding call and will break the store. So this needs to be spawned
	spawn(function()
		amendR15ForItemRemoved(assetId)

		local model = insertService:LoadAsset(assetId)
		utilities.recursiveDisable(model)

		local stillWearing = false
		local currentlyWearing = getAllEquippedAssets()
		for _, v in next, currentlyWearing do
			if v == assetId then
				stillWearing = true
				break
			end
		end

		if not stillWearing then return end

		local info = amendR15ForItemAddedAsModel(model)

		itemsOnR15[assetId] = info
	end)
end


local function scaleCharacter(newBodyScale, newHeadScale)
	if getAvatarType() == 'R6' then return end

	local bodyScaleVector = newBodyScale
	local headScaleVector = Vector3.new(newHeadScale, newHeadScale, newHeadScale)

	local jointInfo = {}
	local parts = {}
	local joints = {}

	for _, child in next, utilities.getDescendants(character) do
		if child:IsA('JointInstance') then
			jointInfo[child] = {Part0=child.Part0, Part1=child.Part1, Parent=child.Parent}
			table.insert(joints, child)
		end
	end

	for _, part in next, character:GetChildren() do
		if part:IsA('BasePart') and part.Name ~= 'HumanoidRootPart' then
			local defaultScale = part:FindFirstChild('DefaultScale')
				and part.DefaultScale.Value or Vector3.new(1, 1, 1)

			local originalSize = part:FindFirstChild('OriginalSize') and part.OriginalSize.Value
			if not originalSize then
				local value = Instance.new'Vector3Value'
				value.Name = 'OriginalSize'
				value.Value = part.Size
				value.Parent = part
				originalSize = value.Value
			end

			local newScaleVector3 = part.Name == 'Head' and headScaleVector or bodyScaleVector
			local currentScaleVector3 = part.Size/originalSize * defaultScale
			local relativeScaleVector3 = newScaleVector3/currentScaleVector3

			for _, child in next, part:GetChildren() do
				if child:IsA('Attachment') then
					local pivot = child.Position
					child.Position = pivot * relativeScaleVector3
				elseif child:IsA('SpecialMesh') then
					child.Scale = child.Scale * relativeScaleVector3
				end
			end

			part.Size = originalSize * newScaleVector3/defaultScale

			table.insert(parts, part)
		end
	end

	for joint, info in next, jointInfo do
		joint.Part0 = info.Part0
		joint.Part1 = info.Part1
		joint.Parent = info.Parent
	end

	for _, part in next, parts do
		part.Parent = character
	end

	repositionR15Joints(joints)

	humanoid.HipHeight = 1.5 * newBodyScale.y
end

function this.refreshCharacterScale(scales)
	scales = scales or getScales()
	scaleCharacter(Vector3.new(scales.Width, scales.Height, scales.Depth), scales.Head)
end


function this.hide()
	getCharacterNode().Parent = nil
end

function this.show()
	getCharacterNode().Parent = game.Workspace
end

local function replaceCharacter(newCharacter)
	character:Destroy()
	character.Parent = nil
	character = newCharacter
	newCharacter.Parent = getCharacterNode()

	for assetId,contentList in pairs(assetsLinkedContent) do
		for _,item in pairs(contentList) do
			if item then
				item:Destroy()
			end
		end
		assetsLinkedContent[assetId] = nil
	end

	hrp = newCharacter:WaitForChild('HumanoidRootPart')
	humanoid = newCharacter:WaitForChild('Humanoid')
	hrp.Anchored = true
end


local function adjustHeightToStandOnPlatform(character)
	local hrp = character:WaitForChild('HumanoidRootPart')
	local humanoid = character:WaitForChild('Humanoid')

	local heightBonus = 3
	if getAvatarType() == "R15" then
		heightBonus = hrp.Size.y * 0.5
	end

	heightBonus = heightBonus + humanoid.HipHeight

	local _,_,_, r0,r1,r2, r3,r4,r5, r6,r7,r8 = hrp.CFrame:components()

	hrp.CFrame = CFrame.new(
		15.2762, heightBonus + 0.7100, -16.8212,
		r0,r1,r2, r3,r4,r5, r6,r7,r8 )
end


local buildingCharacterLock = false
local queuedRebuild = ""

local createR15Rig = function() end
local createR6Rig = function() end


local function createRigFromQueue()
	if queuedRebuild == "R15" then
		queuedRebuild = ""
		createR15Rig()
	elseif queuedRebuild == "R6" then
		queuedRebuild = ""
		createR6Rig()
	else
		adjustHeightToStandOnPlatform(character)
	end
end

createR15Rig = function(callback)

	if buildingCharacterLock then
		queuedRebuild = "R15"
		return
	end
	buildingCharacterLock = true

	local newCharacter = templateCharacterR15:clone()
	newCharacter.Name = 'Character'

	replaceCharacter(newCharacter)

	local currentlyWearing = getAllEquippedAssets()
	for _, assetId in next, currentlyWearing do
		amendR15ForItemAdded(assetId)
	end

	this.refreshCharacterScale()

	updateCharacterBodyColors()

	buildingCharacterLock = false
	createRigFromQueue()
end


createR6Rig = function(callback)
	if buildingCharacterLock then
		queuedRebuild = "R6"
		return
	end
	buildingCharacterLock = true

	local newCharacter = templateCharacterR6:clone()
	newCharacter.Name = 'Character'
	hrp = newCharacter:WaitForChild('HumanoidRootPart')
	humanoid = newCharacter:WaitForChild('Humanoid')
	hrp.Anchored = true

	replaceCharacter(newCharacter)

	spawn(function()
		for _,assetId in pairs(getAllEquippedAssets()) do
			local assetModel = insertService:LoadAsset(assetId) --Get all waiting overwith early

			local insertedStuff = {}
			if not assetsLinkedContent[assetId] then
				assetsLinkedContent[assetId] = insertedStuff
			else
				insertedStuff = assetsLinkedContent[assetId]
			end

			local stuff = {assetModel}
			if stuff[1].className == 'Model' then
				stuff = assetModel:GetChildren()
			end

			for _,thing in pairs(stuff) do --Equip asset differently depending on what it is.
				if string.lower(thing.Name) == 'r6' then
					for _,r6SpecificThing in pairs(thing:GetChildren()) do
						sortAndEquipItemToCharacter(r6SpecificThing, insertedStuff)
					end
				elseif thing.className ~= 'Folder' then
					sortAndEquipItemToCharacter(thing, insertedStuff)
				end
			end
		end

		updateCharacterBodyColors()

		buildingCharacterLock = false
		createRigFromQueue()

	end)
end


local myDefaultShirtTemplate = nil
local myDefaultPantsTemplate = nil
local function initDefaultClothes(colorIndex)
	local myColorIndex = ((colorIndex-1) % #defaultShirtIds) + 1
	myDefaultShirtTemplate = insertService:LoadAsset(defaultShirtIds[myColorIndex]):GetChildren()[1]
	myDefaultShirtTemplate.Name = 'ShirtDefault'
	myDefaultPantsTemplate = insertService:LoadAsset(defaultPantIds[myColorIndex]):GetChildren()[1]
	myDefaultPantsTemplate.Name = 'PantsDefault'
end

local function prompRecomposite()
	if character then
		local head = character:FindFirstChild('Head')
		if head then
			head.Transparency = head.Transparency+1
			head.Transparency = head.Transparency-1
		end
	end
end

local displayWarning = function() end
local closeWarning = function() end
function this.setDisplayWarningCallbacks(inDisplayWarning, inCloseWarning)
	displayWarning = inDisplayWarning
	closeWarning = inCloseWarning
end

local minDeltaEBodyColorDifference = 0
function this.setMinDeltaEBodyColorDifference(minimumDeltaEBodyColorDifference)
	minDeltaEBodyColorDifference = minimumDeltaEBodyColorDifference
end

local AvatarEditorDefaultClothingV2 = Flags:GetFlag("AvatarEditorDefaultClothingV2")


local function updateDefaultShirtAndPants()
	if character == nil then return end

	-- These two if-checks are for cases where the character might be destroyed.
	if defaultShirtModel and not character:IsAncestorOf(defaultShirtModel) then
		defaultShirtModel:Destroy()
		defaultShirtModel = nil
	end
	if defaultPantsModel and not character:IsAncestorOf(defaultPantsModel) then
		defaultPantsModel:Destroy()
		defaultPantsModel = nil
	end

	local hasShirt = false
	local hasPants = false
	for _, assetId in pairs(getAllEquippedAssets()) do
		local assetTypeName = assetTypeNames[AssetInfo.getAssetInfo(assetId).AssetTypeId]
		if assetTypeName == "Shirt" then
			hasShirt = true
		elseif assetTypeName == "Pants" then
			hasPants = true
		end
	end

	local characterShouldHaveDefaultShirt = not hasShirt and not hasPants
	local characterShouldHaveDefaultPants = not hasPants

	if characterShouldHaveDefaultShirt or characterShouldHaveDefaultPants then
		if AvatarEditorDefaultClothingV2 then
			local rightLegColor = Color3.new(0, 0, 0)
			local leftLegColor = Color3.new(0, 0, 0)
			local torsoColor = Color3.new(0, 0, 0)
			local bodyColors = getBodyColors()
			for index, value in pairs(bodyColors) do
				if index == "RightLegColor" then
					rightLegColor = BrickColor.new(value).Color
				elseif index == "LeftLegColor" then
					leftLegColor = BrickColor.new(value).Color
				elseif index == "TorsoColor" then
					torsoColor = BrickColor.new(value).Color
				end
			end
			local minDeltaE = math.min(
				utilities.delta_CIEDE2000(rightLegColor, torsoColor),
				utilities.delta_CIEDE2000(leftLegColor, torsoColor))

			characterShouldHaveDefaultShirt =
				minDeltaE <= minDeltaEBodyColorDifference and characterShouldHaveDefaultShirt
			characterShouldHaveDefaultPants =
				minDeltaE <= minDeltaEBodyColorDifference and characterShouldHaveDefaultPants
		else
			local waistBodyColors = {}
			local numberOfWaistBodyColors = 0
			local bodyColors = getBodyColors()
			for index, value in pairs(bodyColors) do
				-- These are the three body areas that define the waist
				if index == "RightLegColor" or index == "LeftLegColor" or index == "TorsoColor" then
					if not waistBodyColors[value] then
						waistBodyColors[value] = true
						numberOfWaistBodyColors = numberOfWaistBodyColors + 1
					end
				end
			end

			characterShouldHaveDefaultShirt = numberOfWaistBodyColors <= 1 and characterShouldHaveDefaultShirt
			characterShouldHaveDefaultPants = numberOfWaistBodyColors <= 1 and characterShouldHaveDefaultPants
		end
	end


	local addedDefaultClothes = false
	local destroyedDefaultClothes = false

	if characterShouldHaveDefaultShirt and not defaultShirtModel then
		defaultShirtModel = myDefaultShirtTemplate:clone()
		defaultShirtModel.Parent = character
		addedDefaultClothes = true
	elseif not characterShouldHaveDefaultShirt and defaultShirtModel then
		defaultShirtModel:Destroy()
		defaultShirtModel = nil
		destroyedDefaultClothes = true
	end

	if characterShouldHaveDefaultPants and not defaultPantsModel then
		defaultPantsModel = myDefaultPantsTemplate:clone()
		defaultPantsModel.Parent = character
		addedDefaultClothes = true
	elseif not characterShouldHaveDefaultPants and defaultPantsModel then
		defaultPantsModel:Destroy()
		defaultPantsModel = nil
		destroyedDefaultClothes = true
	end

	if not waitingForInitialLoad then
		local warningText = Strings:LocalizedString("DefaultClothingAppliedPhrase")
		if addedDefaultClothes then
			displayWarning(warningText, 5)
		elseif destroyedDefaultClothes then
			closeWarning()
		end
	end

	prompRecomposite()
end


local defaultAnimation = 'IdleAnimation'
local function setDefaultAnimation(animation)
	defaultAnimation = animation
end


local function unequipAsset(assetId)
	local assetInfo = AssetInfo.getAssetInfo(assetId)
	local assetTypeName = nil
	if assetInfo then
		assetTypeName = assetTypeNames[assetInfo.AssetTypeId]
	end

	utilities.fastSpawn(function()
		if assetTypeName and assetTypeName:find'Animation' then
			this.startEquippedAnimationPreview(defaultAnimation)
		else
			if getAvatarType() == 'R15' then
				amendR15ForItemRemoved(assetId)
			else
				--Destroy rendered content
				local currentAssetContent = assetsLinkedContent[assetId]
				if currentAssetContent then
					for _,thing in pairs(currentAssetContent) do
						if thing and thing.Parent then
							thing:Destroy()
						end
					end
					assetsLinkedContent[assetId] = nil
				end

				--Special cases where we need to replace removed asset with a default
				if assetTypeName == 'Head' then
					if character and character.Parent then
						local head = character:FindFirstChild('Head')
						if head then
							local defaultHeadMesh = Instance.new('SpecialMesh')
							defaultHeadMesh.MeshType = 'Head'
							defaultHeadMesh.Scale = Vector3.new(1.2,1.2,1.2)
							defaultHeadMesh.Parent = head
						end
					end
				elseif assetTypeName == 'Face' then
					if character and character.Parent then
						local head = character:FindFirstChild('Head')
						if head then
							local currentFace = utilities.findFirstChildOfType(head,'Decal')
							if not currentFace then
								local face = Instance.new('Decal')
								face.Name = 'face'
								face.Texture = "rbxasset://textures/face.png"
								face.Parent = head
							end
						end
					end
				elseif assetTypeName == 'Gear' then
					holdToolPos('Down')
				end
			end

		end
	end)

end

local rootAnimationRotation = {x=0, y=0, z=0}

local function setAnimationRotation(x, y, z)
	local t = 0.5
	tween(rootAnimationRotation, 'x', 'Number', nil, x, t, easeFilters.quad, easeFilters.easeInOut)
	tween(rootAnimationRotation, 'y', 'Number', nil, y, t, easeFilters.quad, easeFilters.easeInOut)
	tween(rootAnimationRotation, 'z', 'Number', nil, z, t, easeFilters.quad, easeFilters.easeInOut)
end


local animationIsPaused = false

local function pauseAnimation()
	animationIsPaused = true
end


local function resumeAnimation()
	if animationIsPaused then
		resumeAnimationEvent:Fire()
		animationIsPaused = false
	end
end


local function stopAllAnimationTracks()
	for _, v in next, humanoid:GetPlayingAnimationTracks() do
		if v ~= toolHoldAnimationTrack then
			v:Stop()
		end
	end
end


local function getDefaultAnimationAssets(assetTypeName)
	local anims = {}

	if getAvatarType() == 'R15' then
		if assetTypeName == 'ClimbAnimation' then
			table.insert(anims, templateCharacterR15.Animations.climb)
		elseif assetTypeName == 'FallAnimation' then
			table.insert(anims, templateCharacterR15.Animations.fall)
		elseif assetTypeName == 'IdleAnimation' then
			table.insert(anims, templateCharacterR15.Animations.idle)
		elseif assetTypeName == 'JumpAnimation' then
			table.insert(anims, templateCharacterR15.Animations.jump)
		elseif assetTypeName == 'RunAnimation' then
			table.insert(anims, templateCharacterR15.Animations.run)
		elseif assetTypeName == 'WalkAnimation' then
			table.insert(anims, templateCharacterR15.Animations.walk)
		elseif assetTypeName == 'SwimAnimation' then
			table.insert(anims, templateCharacterR15.Animations.swim)
			table.insert(anims, templateCharacterR15.Animations.swimidle)
		else
			error('Tried to get bad default animation for R15 '..tostring(assetTypeName))
		end
	elseif getAvatarType() == 'R6' then
		if assetTypeName == 'ClimbAnimation' then
			table.insert(anims, templateCharacterR6.Animations.climb)
		elseif assetTypeName == 'FallAnimation' then
			table.insert(anims, templateCharacterR6.Animations.fall)
		elseif assetTypeName == 'IdleAnimation' then
			table.insert(anims, templateCharacterR6.Animations.idle)
		elseif assetTypeName == 'JumpAnimation' then
			table.insert(anims, templateCharacterR6.Animations.jump)
		elseif assetTypeName == 'RunAnimation' then
			table.insert(anims, templateCharacterR6.Animations.run)
		elseif assetTypeName == 'WalkAnimation' then
			table.insert(anims, templateCharacterR6.Animations.walk)
		elseif assetTypeName == 'SwimAnimation' then
			local swimAnim = templateCharacterR6.Animations.run:Clone()
			swimAnim.Name = 'swim'

			table.insert(anims, swimAnim)
		else
			error('Tried to get bad default animation for R6 '..tostring(assetTypeName))
		end
	end

	return anims
end


local function getAnimationAssets(assetId)
	local asset = insertService:LoadAsset(assetId)
	local animAssets = asset.R15Anim:GetChildren()

	return animAssets
end


local function getEquippedAnimationAssets(assetTypeName)
	local assetTypeId = assetTypeNames[assetTypeName]
	local assetId

	local currentlyWearing = getAllEquippedAssets()
	if getAvatarType() == 'R15' then
		for _, asset in next, currentlyWearing do
			local info = AssetInfo.getAssetInfo(asset)
			if info and info.AssetTypeId == assetTypeId then
				assetId = asset
				break
			end
		end
	end

	if assetId then
		return getAnimationAssets(assetId)
	else
		return getDefaultAnimationAssets(assetTypeName)
	end
end


local function getWeightedAnimations(possible)
	local options, totalWeight = {}, 0

	for _, v in next, possible do
		local weight = v:FindFirstChild('Weight') and v.Weight.Value or 1
		options[v] = weight
		totalWeight = totalWeight + weight
	end

	return options, totalWeight
end


function this.playLookAround()
	pauseAnimation()
	stopAllAnimationTracks()

	local thisLookAroundAnimation = currentLookAroundAnimation + 1
	currentLookAroundAnimation = thisLookAroundAnimation

	local assets = getEquippedAnimationAssets('IdleAnimation')

	local options, _ = getWeightedAnimations(assets[1]:GetChildren())

	local lightest, lightestWeight
	for v, weight in next, options do
		if lightest == nil or weight < lightestWeight then
			lightest, lightestWeight = v, weight
		end
	end

	if lightest then
		if character and character.Parent and humanoid and humanoid:IsDescendantOf(game.Workspace) then
			local track = humanoidLoadAnimation(lightest)
			track:Play(0)
			wait(track.Length)
			track:Stop()
			track:Destroy()
		end
	end

	if thisLookAroundAnimation == currentLookAroundAnimation then
		resumeAnimation()
	end
end


local function stopAnimationPreview()
	if currentAnimationPreview ~= nil then
		currentAnimationPreview.Stop()
	end
	currentAnimationPreview = nil
	setAnimationRotation(0, 0, 0)
end


local function startAnimationPreviewFromAssets(animAssets) -- Array of StringValues containing Animation objects
	if this.Destroyed then
		return
	end
	if animationIsPaused then
		resumeAnimation()
	end
	if currentAnimationPreview ~= nil then
		stopAnimationPreview()
	end

	local thisAnimationPreview = {}
	currentAnimationPreview = thisAnimationPreview

	if thisAnimationPreview ~= currentAnimationPreview then return end

	local stop = false
	local stopCurrentLoop = false
	local pauseMainLoop = false
	local switch = false
	local currentAnim
	local currentTrack
	local isMultipleAnims = #animAssets > 1
	local currentAnimIndex = 1
	local forceHeaviestAnim = true
	local resumeMainLoopEvent = Instance.new('BindableEvent')

	thisAnimationPreview.Stop = function()
		stop = true
		if currentTrack and currentTrack.IsPlaying then
			currentTrack:Stop()
		end
	end

	if isMultipleAnims then -- alternate between the animations when there's more than one
		for i, v in next, animAssets do
			if v.Name == 'swimidle' then
				currentAnimIndex = i
				break
			end
		end

		utilities.fastSpawn(function()
			while not stop do
				switch = true
				while switch do
					utilities.renderWait()
				end
				wait(4)
			end
		end)
	end

	local loopAnimation = function()
		stopCurrentLoop = false

		if switch then
			currentAnimIndex = currentAnimIndex%#animAssets + 1
			switch = false
		end

		-- weighted random
		local newAnim
		local possibleAnims = animAssets[currentAnimIndex]:GetChildren()
		local options, totalWeight = getWeightedAnimations(possibleAnims)

		if forceHeaviestAnim then
			local heaviest, heaviestWeight

			for v, weight in next, options do
				if heaviest == nil or weight > heaviestWeight then
					heaviest, heaviestWeight = v, weight
				end
			end

			newAnim = heaviest
			forceHeaviestAnim = false
		else
			local chosenValue = math.random()*totalWeight
			for v, weight in next, options do
				if chosenValue <= weight then
					newAnim = v
					break
				else
					chosenValue = chosenValue - weight
				end
			end
		end

		-- stop the old track, play the new one
		if currentAnim == newAnim then
			if not currentTrack.IsPlaying then
				currentTrack:Play()
			end
		else
			local fadeInTime = 0.1

			if currentTrack ~= nil then
				if currentTrack.IsPlaying then
					currentTrack:Stop(0.5)
					fadeInTime = 0.5
				end
				currentTrack = nil
			end

			currentTrack = humanoidLoadAnimation(newAnim)
			currentTrack:Play(fadeInTime)

			if newAnim.Parent.Name == 'swim' then
				setAnimationRotation(-math.rad(60), 0, 0)
			else
				setAnimationRotation(0, 0, 0)
			end
		end
		currentAnim = newAnim

		-- wait for the animation to end, or for the switcher to switch, or for the whole thing to be stopped
		local animEnded = false
		local animEndedCon = currentTrack.Stopped:connect(function()
			animEnded = true
		end)

		local lastTimePosition = 0 -- keep track of this so we know when it loops

		while true and not this.Destroyed do
			if animEnded then
				break
			elseif stop then
				break
			elseif stopCurrentLoop then
				break
			else
				if currentTrack.TimePosition < lastTimePosition then
					break
				end
				lastTimePosition = currentTrack.TimePosition
				utilities.renderWait()
			end
		end

		animEndedCon:disconnect()

		stopCurrentLoop = false
	end

	local animationResumedConnection = resumeAnimationEvent.Event:connect(function()
		stopCurrentLoop = true
		pauseMainLoop = true
		loopAnimation()
		pauseMainLoop = false
		forceHeaviestAnim = true
		resumeMainLoopEvent:Fire()
	end)

	utilities.fastSpawn(function()
		while not stop and not this.Destroyed do
			loopAnimation()

			if pauseMainLoop then
				resumeMainLoopEvent.Event:wait()
			end
		end

		if currentTrack then
			if currentTrack.IsPlaying then
				currentTrack:Stop()
			end
			currentTrack:Destroy()
			currentTrack = nil
		end
		if currentAnim then
			currentAnim = nil
		end

		animationResumedConnection:disconnect()
	end)
end


function this.startEquippedAnimationPreview(assetTypeName)
	startAnimationPreviewFromAssets(getEquippedAnimationAssets(assetTypeName))
end


local function startAnimationPreview(assetId)
	startAnimationPreviewFromAssets(getAnimationAssets(assetId))
end

local function equipAsset(assetId)
	spawn(function()
		this.addAssetToRecentAssetList(assetId)

		local assetInfo = AssetInfo.getAssetInfo(assetId)

		if assetInfo then
			local assetTypeName = assetTypeNames[assetInfo.AssetTypeId]

			local assetModel = insertService:LoadAsset(assetId)

			-- If the new asset is not an animation then we need to update the render of the character
			-- Also, after loading model, check to make sure it is still equipped before dressing character
			if not string.find(assetTypeName, 'Animation') then
				-- Render changes
				if getAvatarType() == 'R6' then
					local insertedStuff = {}
					if not assetsLinkedContent[assetId] then
						assetsLinkedContent[assetId] = insertedStuff
					else
						insertedStuff = assetsLinkedContent[assetId]
					end
					local stuff = {assetModel}
					if stuff[1].className == 'Model' then
						stuff = assetModel:GetChildren()
					end
					for _,thing in pairs(stuff) do -- Equip asset differently depending on what it is.
						if string.lower(thing.Name) == 'r6' then
							for _,r6SpecificThing in pairs(thing:GetChildren()) do
								sortAndEquipItemToCharacter(r6SpecificThing, insertedStuff)
							end
						elseif thing.className ~= 'Folder' then
							sortAndEquipItemToCharacter(thing, insertedStuff)
						end
					end
				else
					amendR15ForItemAdded(assetId)
				end
			end

			-- If the new asset is a bodypart, then we need to update the colors
			if assetInfo.AssetTypeId >= 25 and assetInfo.AssetTypeId <= 31 then
				updateCharacterBodyColors()
			end
		end
	end)
end


local function addAssetToList(assets, assetId)
	local assetType = AssetInfo.getAssetType(assetId)
	assets[assetType] = assets[assetType] or {}
	table.insert(assets[assetType], assetId)
end


local wearOutfitRequestCount = 0
function this.wearOutfit(outfitId)
	-- This code is used for cutting off the process of previous
	-- outfit equip calls. Not a debounce per-se, but a.. bounce?
	wearOutfitRequestCount = wearOutfitRequestCount + 1
	local thisWearOutfitRequestCount = wearOutfitRequestCount
	local stillValidCheckFunction = function()
		return wearOutfitRequestCount == thisWearOutfitRequestCount
	end

	local outfitData = webServer.get(Urls.avatarUrlPrefix.."/v1/outfits/"..outfitId.."/details")
	if outfitData and stillValidCheckFunction() and not this.Destroyed then

		local assets = {}

		-- Equip outfit assets
		local outfitData = utilities.decodeJSON(outfitData)
		if outfitData then
			local outfitAssets = outfitData['assets']
			if outfitAssets then
				for _, assetInfo in pairs(outfitAssets) do
					addAssetToList(assets, assetInfo.id)
				end
			end
		end

		local bodyColors = {
			HeadColor = 194;
			LeftArmColor = 194;
			LeftLegColor = 194;
			RightArmColor = 194;
			RightLegColor = 194;
			TorsoColor = 194;
		}

		local outfitBodyColors = outfitData['bodyColors']
		if outfitBodyColors then
			for name, mapName in pairs(this.bodyColorNameMap) do
				local color = outfitBodyColors[mapName]
				if color then
					bodyColors[name] = color
				end
			end
		end

		AppState.Store:Dispatch(SetOutfit(assets, bodyColors))
		this.refreshCharacterScale()

	end
end


function this.setRotation(rotation)
	-- rotate a smidge extra to face the character to the middle fo the screen
	hrp.CFrame = CFrame.new(hrp.CFrame.p)
		* CFrame.Angles(0, 0.6981 + rotation, 0)
		* CFrame.Angles(rootAnimationRotation.x, rootAnimationRotation.y, rootAnimationRotation.z)
end


function this.updateAvatarType()
	if getAvatarType() == 'R15' then
		createR15Rig()
	else
		createR6Rig()
	end
	character.Parent = getCharacterNode()
end


function this.initFromServer()
	local avatarFetchRequest = utilities.httpGet(Urls.avatarUrlPrefix.."/v1/avatar")
	avatarFetchRequest = utilities.decodeJSON(avatarFetchRequest)
	if avatarFetchRequest and not this.Destroyed then
		local bodyColorsRequest = avatarFetchRequest['bodyColors']
		local bodyColors = {}
		for name, mapName in pairs(this.bodyColorNameMap) do
			local color = bodyColorsRequest[mapName]
			if color then
				bodyColors[name] = color
			end
		end
		setSavedBodyColors(bodyColors)
		AppState.Store:Dispatch(SetBodyColors(bodyColors))

		local requestedAvatarType = avatarFetchRequest['playerAvatarType']
		if requestedAvatarType then
			AppState.Store:Dispatch(SetAvatarType(requestedAvatarType))
		end

		local scalesRequest = avatarFetchRequest['scales']
		if scalesRequest then
			local scales = {}
			local height = scalesRequest['height']
			if height then
				scales.Height = height
			end
			local width = scalesRequest['width']
			if width then
				scales.Width = width
			end
			local depth = scalesRequest['depth']
			if depth then
				scales.Depth = depth
			end
			local head = scalesRequest['head']
			if head then
				scales.Head = head
			end
			setSavedScales(scales)
			AppState.Store:Dispatch(SetScales(scales))
		end

		local requestedAssetsData = avatarFetchRequest['assets']
		if requestedAssetsData then
			local waitingAssets = {}
			local numCompletedAssets = 0

			local assets = {}

			for _,assetData in pairs(requestedAssetsData) do
				local assetId = assetData['id']

				addAssetToList(assets, assetId)

				if assetId and type(assetId) == 'number' then
					waitingAssets[assetId] = false
					utilities.fastSpawn(function()
						waitingAssets[assetId] = true
						this.addAssetToRecentAssetList(assetId)
						numCompletedAssets = numCompletedAssets + 1

						if numCompletedAssets >= #requestedAssetsData then
							this.recalculateRestingPartOffsets()
							this.refreshCharacterScale()
						end
					end)
				end
			end

			AppState.Store:Dispatch(SetAssets(assets))

			-- After all fetched assets are equipped, we can update the savedWearingAssets table.
			waitingForInitialLoad = true
			utilities.fastSpawn(function()
				local startTime = tick()
				while true and not this.Destroyed do
					local allAssetsLoaded = true
					for _, handled in pairs(waitingAssets) do
						if not handled then
							allAssetsLoaded = false
							break
						end
					end
					if allAssetsLoaded then
						savedWearingAssets = getAllEquippedAssets()
						break
					end
					if tick()-startTime > 30 then
						print('Took too long to load character.')
						break
					end
					wait()
				end
				waitingForInitialLoad = false

				this.startEquippedAnimationPreview('IdleAnimation')
			end)
		end
	end
end


function this.getFocusPoint(partNames)
	local focusPointRelative = Vector3.new()

	for _, partName in next, partNames do
		focusPointRelative = focusPointRelative + this.getRestingPartOffset(partName).p / #partNames
	end

	return humanoid.Torso.CFrame * focusPointRelative
end

local function stateChanged(newState, oldState)
	local didUpdate = false
	local didEquip = false

	if newState.Character.AvatarType ~= oldState.Character.AvatarType then
		this.updateAvatarType()
		didUpdate = true
	end

	local currentCategoryIndex = newState.Category.CategoryIndex
	local currentCategoryName = currentCategoryIndex and categories[currentCategoryIndex].name or ""
	local canPlayAnimation = string.find(currentCategoryName, 'Animation') or string.find(currentCategoryName, 'Recent')

	-- Set default animation in animation category
	if string.find(currentCategoryName, 'Animation') then
		local tabInfo = newState.Category.TabsInfo[currentCategoryIndex]
		local tabIndex = tabInfo and tabInfo.TabIndex or 1
		local pageName = categories[currentCategoryIndex].pages[tabIndex].typeName
		setDefaultAnimation(string.gsub(pageName, ' ', ''))
	else
		setDefaultAnimation('IdleAnimation')
	end

	local animationId = nil

	if newState.Character.Assets ~= oldState.Character.Assets then
		--Remove assets which only exist in oldState
		for assetType, assetList in pairs(oldState.Character.Assets) do
			if not newState.Character.Assets[assetType] and assetList then
				for _, assetId in pairs(assetList) do
					unequipAsset(assetId)
				end
			end
		end

		for assetType, _ in pairs(newState.Character.Assets) do
			if newState.Character.Assets[assetType] ~= oldState.Character.Assets[assetType] then
				local addTheseAssets = TableUtilities.ListDifference(
						newState.Character.Assets[assetType] or {},
						oldState.Character.Assets[assetType] or {})
				local removeTheseAssets =
					TableUtilities.ListDifference(oldState.Character.Assets[assetType] or {},
					newState.Character.Assets[assetType] or {})

				for _, assetId in pairs(addTheseAssets) do
					equipAsset(assetId)
					didUpdate = true
					didEquip = true

					if string.find(assetType, 'Animation') then
						animationId = assetId
					end
				end

				for _, assetId in pairs(removeTheseAssets) do
					unequipAsset(assetId)
				end

			end
		end

		if isInitialAssets and oldState.Character.Assets and next(oldState.Character.Assets) == nil then
			isInitialAssets = false
			canPlayAnimation = false
		end
	end

	if newState.Character.BodyColors ~= oldState.Character.BodyColors then
		local differentBodyColors =
			TableUtilities.TableDifference(newState.Character.BodyColors, oldState.Character.BodyColors)

		if next(differentBodyColors) ~= nil then
			updateCharacterBodyColors(newState.Character.BodyColors)
			didUpdate = true
		end
	end

	if newState.Character.Scales ~= oldState.Character.Scales then
		local differentScales =
			TableUtilities.TableDifference(newState.Character.Scales, oldState.Character.Scales)
		if next(differentScales) ~= nil then
			this.refreshCharacterScale(newState.Character.Scales)
			adjustHeightToStandOnPlatform(character)
		end
	end

	if didUpdate then
		ParticleScreen.runParticleEmitter()
	end

	-- Play animations
	utilities.fastSpawn(function()
		if animationId and newState.Character.AvatarType == "R6" then
			displayWarning(Strings:LocalizedString("AnimationsForR15Phrase"), 5)
		end
		if animationId and canPlayAnimation and newState.Character.AvatarType == "R15" then
			startAnimationPreview(animationId)
		else
			if didEquip then
				this.startEquippedAnimationPreview(defaultAnimation)
				this.playLookAround()
			elseif newState.Category.CategoryIndex ~= oldState.Category.CategoryIndex or
				newState.Category.TabsInfo ~= oldState.Category.TabsInfo or
				newState.Character.AvatarType ~= oldState.Character.AvatarType or
				(animationId and not canPlayAnimation) then
				this.startEquippedAnimationPreview(defaultAnimation)
			end
		end
	end)

	if newState.Character ~= oldState.Character then
		updateDefaultShirtAndPants()
	end
end


return function(inWebServer, characterTemplates, defaultClothesIndex)
	isInitialAssets = true
	local storeChangedCn = AppState.Store.Changed:Connect(stateChanged)

	webServer = inWebServer
	waitingForInitialLoad = true

	templateCharacterR6 = characterTemplates['CharacterR6']
	templateCharacterR15 = characterTemplates['CharacterR15']

	character = templateCharacterR15:clone()
	hrp = character:WaitForChild('HumanoidRootPart')
	humanoid = character:WaitForChild('Humanoid')

	initDefaultClothes(defaultClothesIndex)

	this.recalculateRestingPartOffsets()

	function this.destroy()
		storeChangedCn = utilities.disconnectEvent(storeChangedCn)
		if characterNode then
			this.Destroyed = true
			characterNode:Destroy()
			characterNode = nil
		end
	end

	return this
end
