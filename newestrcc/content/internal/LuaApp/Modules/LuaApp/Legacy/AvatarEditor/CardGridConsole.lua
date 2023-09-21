local Modules = game:GetService("CoreGui"):FindFirstChild("RobloxGui").Modules

local AppState = require(Modules.LuaApp.Legacy.AvatarEditor.AppState)
local LayoutInfo = require(Modules.LuaApp.Legacy.AvatarEditor.LayoutInfoConsole)
local Utilities = require(Modules.LuaApp.Legacy.AvatarEditor.Utilities)
local TableUtilities = require(Modules.LuaApp.TableUtilities)

--Constants
local BUTTONS_PER_ROW = LayoutInfo.ButtonsPerRow
local GRID_PADDING = LayoutInfo.GridPadding
local BUTTONS_SIZE = LayoutInfo.ButtonSize
local SELECTOR_BOTTOM_MIN_DISTANCE = LayoutInfo.SelectorBottomMinDistance

--Mutables
local equippedFrameTemplate = nil
local scrollingFrame = nil
local getAssetList = function() return {} end
local recycledAssetCardStack = {}
local assetCardConnections = {}
local activeAssetCards = {}
local activeAssetCardsByIndex = {}
local assetCardVersionKeys = {}
local lastSuccessfulAssetCardUpdateAtY = 0
local renderAssetCard = function() end
local currentAssetRegion = {}
local awaitingInvalidation = {}
local storeChangedCn = nil

local this = {}

local buttonSelector = Utilities.create'ImageLabel'
	{
		Name = 'CardSelector';
		Image = "rbxasset://textures/ui/Shell/AvatarEditor/graphic/gr-item selector-16px corner.png";
		Position = UDim2.new(0, -7, 0, -7);
		Size = UDim2.new(1, 14, 1, 14);
		BackgroundTransparency = 1;
		ScaleType = Enum.ScaleType.Slice;
		SliceCenter = Rect.new(51, 51, 103, 103);
	}

local function popRecycledAssetCard()
	local n = #recycledAssetCardStack

	if n > 0 then
		local card = recycledAssetCardStack[n]
		recycledAssetCardStack[n] = nil
		return card
	end
end


local function recycleAssetCard(card)
	if not card then return end

	card.Parent = nil

	assetCardVersionKeys[card] = assetCardVersionKeys[card] + 1

	if activeAssetCards[card] then
		activeAssetCardsByIndex[activeAssetCards[card]] = nil
		activeAssetCards[card] = nil
	end

	if assetCardConnections[card] then
		for _, con in next, assetCardConnections[card] do
			con:disconnect()
		end
		assetCardConnections[card] = nil
	end

	if card:FindFirstChild'EquippedFrame' then
		card.EquippedFrame:Destroy()
	end

	table.insert(recycledAssetCardStack, card)
end


function this:invalidateAllAssetCards()
	for _, card in pairs(activeAssetCardsByIndex) do
		if typeof(card) == 'Instance' then
			recycleAssetCard(card)
		end
	end
	scrollingFrame:ClearAllChildren()
	lastSuccessfulAssetCardUpdateAtY = 0
	currentAssetRegion = {0, 0}
end

-- Check if scrollingFrame need to scroll up/down
local function checkScroll(card)
	if activeAssetCards[card] then
		local bottonYBottom = (card.Position + card.Size).Y.Offset
		local scrollingFrameYBottom = scrollingFrame.AbsoluteWindowSize.Y + scrollingFrame.CanvasPosition.Y
		local bottomDistance = scrollingFrameYBottom - bottonYBottom
		local topDistance = card.Position.Y.Offset - scrollingFrame.CanvasPosition.Y

		local newCanvasPositionY = scrollingFrame.CanvasPosition.Y
		if bottomDistance < SELECTOR_BOTTOM_MIN_DISTANCE then
			newCanvasPositionY =  newCanvasPositionY + SELECTOR_BOTTOM_MIN_DISTANCE - bottomDistance
		elseif topDistance < 0 then
			newCanvasPositionY = newCanvasPositionY + topDistance - GRID_PADDING - 20
		end

		newCanvasPositionY = math.max(0, math.min(newCanvasPositionY, scrollingFrame.CanvasSize.Y.Offset - scrollingFrame.AbsoluteWindowSize.Y))
		scrollingFrame.CanvasPosition = Vector2.new(scrollingFrame.CanvasPosition.X, newCanvasPositionY)
	end
end

local function makeNewAssetCard(cardName, image)
	local assetButton = Instance.new('ImageButton')

	assetButton.AutoButtonColor = false
	assetButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
	assetButton.BorderColor3 = Color3.fromRGB(208,208,208)
	assetButton.BackgroundTransparency = 1
	assetButton.ZIndex = LayoutInfo.BasicLayer
	assetButton.SelectionImageObject = buttonSelector

	local assetButtonBackgroud = Instance.new('ImageLabel', assetButton)
	assetButtonBackgroud.Name = 'AssetButtonBackground'
	assetButtonBackgroud.BackgroundTransparency = 1
	assetButtonBackgroud.ScaleType = Enum.ScaleType.Slice
	assetButtonBackgroud.SliceCenter = Rect.new(6,6,7,7)
	assetButtonBackgroud.ZIndex = LayoutInfo.BasicLayer
	assetButtonBackgroud.Size = UDim2.new(1, 6, 1, 6)
	assetButtonBackgroud.Position = UDim2.new(0, -3, 0, -3)
	assetButtonBackgroud.Image = ""
	assetButtonBackgroud.SliceCenter = Rect.new(16, 16, 17, 17)
	assetButtonBackgroud.Size = UDim2.new(1, 0, 1, 0)
	assetButtonBackgroud.Position = UDim2.new(0, 0, 0, 0)

	assetButton.SelectionGained:connect(function()
		checkScroll(assetButton)
	end)

	local assetImageLabel = Instance.new('ImageLabel')
	assetImageLabel.BackgroundTransparency = 1
	assetImageLabel.BorderSizePixel = 0
	assetImageLabel.Size = UDim2.new(1, -6, 1, -6)
	assetImageLabel.Position = UDim2.new(0,3, 0,3)
	assetImageLabel.ZIndex = LayoutInfo.AssetImageLayer
	assetImageLabel.Parent = assetButton
	return assetButton
end


local function popAwaitingInvalidationCard()
	local card = awaitingInvalidation[#awaitingInvalidation]
	if card then
		awaitingInvalidation[#awaitingInvalidation] = nil
		return card
	end
end


function this:makeAssetCard(i, cardName, image, clickFunction, isSelected, unAvailable, YOffset)
	local card = popAwaitingInvalidationCard() or popRecycledAssetCard() or makeNewAssetCard(cardName, image)
	YOffset = YOffset or 0

	local column = ((i-1) % BUTTONS_PER_ROW) + 1
	local row = math.ceil(i / BUTTONS_PER_ROW)
	card.Name = 'AssetButton'..cardName
	card.Size = UDim2.new(0, BUTTONS_SIZE, 0, BUTTONS_SIZE)
	card.Position = UDim2.new(
		0,
		(column-1) * (BUTTONS_SIZE + GRID_PADDING),
		0,
		(row - 1) * (BUTTONS_SIZE + GRID_PADDING) + YOffset
	)

	assetCardConnections[card] = {}
	activeAssetCardsByIndex[i] = card
	activeAssetCards[card] = i

	--card.debugwtf.Text = i

	local myVersionKey = (assetCardVersionKeys[card] or 0) + 1
	assetCardVersionKeys[card] = myVersionKey

	if clickFunction then
		table.insert(assetCardConnections[card], card.MouseButton1Click:connect(clickFunction))
	end
	if isSelected then
		local equippedFrame = equippedFrameTemplate:clone()
		equippedFrame.Name = 'EquippedFrame'
		equippedFrame.ZIndex = LayoutInfo.EquippedFrameLayer
		equippedFrame.Visible = true
		equippedFrame.Parent = card
	end

	if type(image) == 'function' then
		Utilities.fastSpawn(function()
			local image = image()
			if myVersionKey == assetCardVersionKeys[card] then
				card.ImageLabel.Image = image
			end
		end)
	else
		card.ImageLabel.Image = image
	end

	if unAvailable then
		card.AssetButtonBackground.Image = "rbxasset://textures/ui/Shell/AvatarEditor/card/item card-unavailable.png"
	else
		card.AssetButtonBackground.Image = "rbxasset://textures/ui/Shell/AvatarEditor/card/item card-available.png"
	end

	return card
end

function this:getFirstCard()
	if activeAssetCardsByIndex[1] then
		return activeAssetCardsByIndex[1]
	end

	return nil
end


local function getVisibleAssetRegion()
	local assetList = getAssetList()
	return {1, #assetList}
end


local function renderAssetCardRegion(a, b)
	for i = a, b do
		renderAssetCard(i)
	end
end


local function updateVisibleAssetCards()
	local visibleRegion = getVisibleAssetRegion()

	if visibleRegion[1] == currentAssetRegion[1] and visibleRegion[2] == currentAssetRegion[2] then
		return
	end

	if currentAssetRegion[1] then
		renderAssetCardRegion(currentAssetRegion[2]+1, visibleRegion[2])
	else
		renderAssetCardRegion(1, visibleRegion[2])
		currentAssetRegion[1] = 1
	end

	currentAssetRegion[2] = visibleRegion[2]
end


function this:freshUpdateVisibleAssetCards()
	currentAssetRegion = {}
	updateVisibleAssetCards()
end


function this:tryUpdateVisibleAssetCards()
	local y = scrollingFrame.CanvasPosition.y

	if math.abs(y - lastSuccessfulAssetCardUpdateAtY) > 0 then --scrollingFrame.AbsoluteSize.x/4 then
		updateVisibleAssetCards()

		lastSuccessfulAssetCardUpdateAtY = y
	end
end


function this:setRenderAssetCardCallback(callback)
	renderAssetCard = callback
end


local function equipAsset(assetId)
	-- Create selection frames
	local assetButtonName = 'AssetButton'..tostring(assetId)
	for _, assetButton in pairs(scrollingFrame:GetChildren()) do
		if assetButton.Name == assetButtonName then
			local equippedFrame = assetButton:FindFirstChild('EquippedFrame')
			if not equippedFrame then
				local equippedFrame = equippedFrameTemplate:clone()
				equippedFrame.Name = 'EquippedFrame'
				equippedFrame.ZIndex = LayoutInfo.EquippedFrameLayer
				equippedFrame.Visible = true
				equippedFrame.Parent = assetButton
			end
		end
	end
end

local function unequipAsset(assetId)
	--Remove selectionBoxes
	local assetButtonName = 'AssetButton'..tostring(assetId)
	for _,assetButton in pairs(scrollingFrame:GetChildren()) do
		if assetButton.Name == assetButtonName then
			local equippedFrame = assetButton:FindFirstChild('EquippedFrame')
			if equippedFrame then
				equippedFrame:Destroy()
			end
		end
	end
end


local function stateChanged(newState, oldState)
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
				local addTheseAssets =
					TableUtilities.ListDifference(
						newState.Character.Assets[assetType] or {},
						oldState.Character.Assets[assetType] or {})

				local removeTheseAssets = TableUtilities.ListDifference(
					oldState.Character.Assets[assetType] or {},
					newState.Character.Assets[assetType] or {})

				for _, assetId in pairs(addTheseAssets) do
					equipAsset(assetId)
				end

				for _, assetId in pairs(removeTheseAssets) do
					unequipAsset(assetId)
				end
			end
		end
	end
end

return function(inEquippedFrameTemplate, inScrollingFrame, inGetAssetList)
	--Reset all mutables when recreate the new card grid
	equippedFrameTemplate = nil
	scrollingFrame = nil
	getAssetList = function() return {} end
	recycledAssetCardStack = {}
	assetCardConnections = {}
	activeAssetCards = {}
	activeAssetCardsByIndex = {}
	assetCardVersionKeys = {}
	lastSuccessfulAssetCardUpdateAtY = 0
	renderAssetCard = function() end
	currentAssetRegion = {}
	awaitingInvalidation = {}

	--Set up
	equippedFrameTemplate = inEquippedFrameTemplate
	scrollingFrame = inScrollingFrame
	getAssetList = inGetAssetList

	function this:Focus()
		storeChangedCn = AppState.Store.Changed:Connect(stateChanged)
	end

	function this:RemoveFocus()
		storeChangedCn = Utilities.disconnectEvent(storeChangedCn)
	end

	return this
end
