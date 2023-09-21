local Modules = game:GetService("CoreGui"):FindFirstChild("RobloxGui").Modules

local AppState = require(Modules.LuaApp.Legacy.AvatarEditor.AppState)
local SelectCategoryTab = require(Modules.LuaApp.Actions.SelectCategoryTab)

local LayoutInfo = require(Modules.LuaApp.Legacy.AvatarEditor.LayoutInfo)
local spriteManager = require(Modules.LuaApp.Legacy.AvatarEditor.SpriteSheetManager)
local categories = require(Modules.LuaApp.Legacy.AvatarEditor.Categories)
local tween = require(Modules.LuaApp.Legacy.AvatarEditor.TweenInstanceController)
local Strings = require(Modules.LuaApp.Legacy.AvatarEditor.LocalizedStrings)

--Constants
local TAB_WIDTH = LayoutInfo.TabWidth
local TAB_HEIGHT = LayoutInfo.TabHeight
local FIRST_TAB_BONUS_WIDTH = LayoutInfo.FirstTabBonusWidth

--Mutables
local this = {}
local tabList = nil
local tabListContainer = nil
local tabButtons = {}
local currentTabButton = nil
local currentPage = nil

local function initTabList()
	if LayoutInfo.isLandscape then
		tabListContainer.Visible = true

		if spriteManager.getScale() >= 2 then
			tabListContainer.TabListBackground.Size = UDim2.new(1, 12, 1, 0)
			tabListContainer.TabListBackground.Position = UDim2.new(0, -6, 0, 0)
			tabListContainer.ScrollButtonDown.BackgroundClipper.Background.Size = UDim2.new(1, 12, 2, 0)
			tabListContainer.ScrollButtonDown.BackgroundClipper.Background.Position = UDim2.new(0, -6, -1, 0)
		else
			tabListContainer.TabListBackground.Size = UDim2.new(1, 6, 1, 3)
			tabListContainer.TabListBackground.Position = UDim2.new(0, -3, 0, 0)
		end

		tabList.Position = UDim2.new(0, 0, 0, 0)
		tabList.Size = UDim2.new(1, 0, 1, -6)
		tabList.BackgroundTransparency = 1
		tabList.ClipsDescendants = true
		tabList.Parent = tabListContainer

		tabListContainer.ScrollButtonDown.Visible = false

		tabListContainer.ScrollButtonDown.Button.MouseButton1Click:connect(function()
			local current = tabList.CanvasPosition.y
			local target = current + (TAB_HEIGHT+1)
			local max = tabList.CanvasSize.Y.Offset - tabList.AbsoluteWindowSize.y
			local newPos = Vector2.new(0, math.min(max, target))
			local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
			tween(tabList, tweenInfo, { CanvasPosition = newPos })
		end)

		local currentAtBottom = nil
		tabList.Changed:connect(function(prop)
			if prop == 'CanvasSize' or prop == 'CanvasPosition' or prop == 'AbsoluteSize' then
				local atBottom = tabList.CanvasPosition.y + tabList.AbsoluteSize.y >= tabList.CanvasSize.Y.Offset

				if currentAtBottom ~= atBottom then
					tabListContainer.ScrollButtonDown.Button.Visible = not atBottom
					local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad)
					local propGoals = { ImageTransparency = atBottom and 1 or 0 }
					tween(tabListContainer.ScrollButtonDown.Gradient, tweenInfo, propGoals)
					tween(tabListContainer.ScrollButtonDown.Arrow, tweenInfo, propGoals)
					tween(tabListContainer.ScrollButtonDown.Button, tweenInfo, propGoals)
					tween(tabListContainer.ScrollButtonDown.BackgroundClipper.Background, tweenInfo, propGoals)

					currentAtBottom = atBottom
				end
			end
		end)
	end
end


local function setScrollButtonVisible(visible)
	if LayoutInfo.isLandscape then
		tabListContainer.ScrollButtonDown.Visible = visible
	end
end


local function selectTab(index, desiredPage)
	local desiredTabButton = tabButtons[index]
	desiredTabButton.BackgroundColor3 = Color3.fromRGB(246, 136, 2)

	local avatarType = AppState.Store:GetState().Character.AvatarType
	if desiredPage.specialPageType == 'Scale' and avatarType == 'R6' then
		desiredTabButton.BackgroundColor3 = Color3.fromRGB(246*.66, 136*.66, 2*.66)
	end
	local imageLabel = desiredTabButton:FindFirstChild('ImageLabel')
	if imageLabel then
		if spriteManager.enabled then
			spriteManager.equip(imageLabel, desiredPage.iconImageSelectedName)
		else
			imageLabel.Image = desiredPage.iconImageSelected
		end
	end
	local textLabel = desiredTabButton:FindFirstChild('TextLabel')
	if textLabel then
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	end

	if LayoutInfo.isLandscape then
		desiredTabButton.BackgroundTransparency = 0
	end

	if currentTabButton then
		currentTabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		if currentPage.specialPageType == 'Scale' and avatarType == 'R6' then
			currentTabButton.BackgroundColor3 = Color3.fromRGB(255*.66, 255*.66, 255*.66)
		end
		local imageLabel = currentTabButton:FindFirstChild('ImageLabel')
		if imageLabel then
			if spriteManager.enabled then
				spriteManager.equip(imageLabel, currentPage.iconImageName)
			else
				imageLabel.Image = currentPage.iconImage
			end
		end
		local textLabel = currentTabButton:FindFirstChild('TextLabel')
		if textLabel then
			textLabel.TextColor3 = Color3.fromRGB(137, 137, 137)
		end

		if LayoutInfo.isLandscape then
			currentTabButton.BackgroundTransparency = 1
		end
	end

	currentTabButton = desiredTabButton
	currentPage = desiredPage
end

local function renderTabButton(index, page, categoryIndex)
	local tabButton = Instance.new('ImageButton')
	tabButton.Name = 'Tab'..page.name
	tabButton.Image = ''
	tabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	if LayoutInfo.isLandscape then
		tabButton.BackgroundTransparency = 1
	end

	local avatarType = AppState.Store:GetState().Character.AvatarType

	if page.specialPageType == 'Scale' and avatarType == 'R6' then
		tabButton.BackgroundColor3 = Color3.fromRGB(255*.66, 255*.66, 255*.66)
	end
	tabButton.BorderSizePixel = 0
	tabButton.AutoButtonColor = false
	if LayoutInfo.isLandscape then
		tabButton.Size = UDim2.new(1, 0, 0, TAB_HEIGHT)
		tabButton.Position = UDim2.new(0, 0, 0, (index-1) * (TAB_HEIGHT+1) + FIRST_TAB_BONUS_WIDTH)
	else
		tabButton.Size = UDim2.new(0, TAB_WIDTH, 0, TAB_HEIGHT)
		tabButton.Position = UDim2.new(0, (index-1) * (TAB_WIDTH+1) + FIRST_TAB_BONUS_WIDTH, 0, 0)
	end
	if index == 1 then
		if LayoutInfo.isLandscape then
			tabButton.Size = UDim2.new(1, 0, 0, TAB_HEIGHT + FIRST_TAB_BONUS_WIDTH)
			tabButton.Position = UDim2.new(0, 0, 0, (index-1) * (TAB_HEIGHT+1))
		else
			tabButton.Size = UDim2.new(0, TAB_WIDTH + FIRST_TAB_BONUS_WIDTH, 0, TAB_HEIGHT)
			tabButton.Position = UDim2.new(0, (index-1) * (TAB_WIDTH+1), 0, 0)
		end
	end

	tabButton.ZIndex = tabList.ZIndex
	tabButton.Parent = tabList.Contents

	if page.iconImage == '' then
		--If tab has no image, then use placeholder text
		local nameLabel = Instance.new('TextLabel')
		nameLabel.BackgroundTransparency = 1
		nameLabel.Size = UDim2.new(1, 0, 1, 0)
		nameLabel.Text = page.title
		nameLabel.Font = Enum.Font.SourceSansBold
		nameLabel.FontSize = 'Size14'
		nameLabel.TextColor3 = Color3.fromRGB(25, 25, 25)
		nameLabel.ZIndex = tabButton.ZIndex
		nameLabel.Parent = tabButton
	else
		local imageFrame = Instance.new('ImageLabel')
		imageFrame.BackgroundTransparency = 1
		imageFrame.Size = UDim2.new(0, 28, 0, 28)
		imageFrame.Position = UDim2.new(.5, -14, .5, -14)
		if index == 1 then
			if LayoutInfo.isLandscape then
				imageFrame.Position = imageFrame.Position + UDim2.new(0, 0, 0, FIRST_TAB_BONUS_WIDTH * 0.5)
			else
				imageFrame.Position = imageFrame.Position + UDim2.new(0, FIRST_TAB_BONUS_WIDTH * .5, 0, 0)
			end
		end
		spriteManager.equip(imageFrame, page.iconImageName)
		imageFrame.ZIndex = tabButton.ZIndex
		imageFrame.Parent = tabButton

		if LayoutInfo.isLandscape then
			imageFrame.Position = imageFrame.Position + UDim2.new(0, 0, 0, -6)

			local nameLabel = Instance.new('TextLabel')
			nameLabel.BackgroundTransparency = 1
			nameLabel.Position = UDim2.new(
				0,
				0,
				imageFrame.Position.Y.Scale,
				imageFrame.Position.Y.Offset+imageFrame.Size.Y.Offset+4)

			nameLabel.Size = UDim2.new(1,0,1,0)
			nameLabel.Text = page.display or Strings:LocalizedString("ErrorDisplayTitle")
			nameLabel.Font = Enum.Font.SourceSans
			nameLabel.FontSize = 'Size14'
			nameLabel.TextColor3 = Color3.fromRGB(137, 137, 137)
			nameLabel.TextXAlignment = 'Center'
			nameLabel.TextYAlignment = 'Top'
			nameLabel.ZIndex = tabButton.ZIndex
			nameLabel.Parent = tabButton
		end
	end

	if index > 1 then
		local divider = Instance.new('Frame')
		divider.Name = 'Divider'
		divider.BackgroundColor3 = Color3.fromRGB(227, 227, 227)
		divider.BorderSizePixel = 0
		if LayoutInfo.isLandscape then
			divider.AnchorPoint = Vector2.new(0.5, 0)
			divider.Size = UDim2.new(1, -12, 0, 1)
			divider.Position = UDim2.new(0.5, 0, 0, (index-1) * (TAB_HEIGHT+1) - 1 + FIRST_TAB_BONUS_WIDTH)
		else
			divider.Size = UDim2.new(0, 1, .6, 0)
			divider.Position = UDim2.new(0, (index-1) * (TAB_WIDTH+1) - 1 + FIRST_TAB_BONUS_WIDTH, .2, 0)
		end
		divider.ZIndex = tabButton.ZIndex + 1
		divider.Parent = tabList.Contents
	end

	tabButton.MouseButton1Click:connect(function()
		if currentTabButton ~= tabButton then
			selectTab(index, page)
			AppState.Store:Dispatch(SelectCategoryTab(categoryIndex, index, tabList.CanvasPosition))
		end
	end)

	return tabButton
end

local function changeCategory(categoryIndex)
	local category = categories[categoryIndex]
	tabList.Contents:ClearAllChildren()

	if LayoutInfo.isLandscape then
		tabList.CanvasSize = UDim2.new(0, 0, 0, #(category.pages) * (TAB_HEIGHT+1) + FIRST_TAB_BONUS_WIDTH - 1)
	else
		tabList.CanvasSize = UDim2.new(0, #(category.pages) * (TAB_WIDTH+1) + FIRST_TAB_BONUS_WIDTH, 0, 0)
	end
	tabList.CanvasPosition = Vector2.new(0,0)

	tabButtons = {}
	for index, page in pairs(category.pages) do
		local tabButton = renderTabButton(index, page, categoryIndex)
		table.insert(tabButtons, tabButton)
	end

	if #category.pages > 0 then
		local tabInfo = AppState.Store:GetState().Category.TabsInfo[categoryIndex]
		if tabInfo and tabInfo.TabIndex and tabInfo.Position then
			selectTab(tabInfo.TabIndex, category.pages[tabInfo.TabIndex])
			tabList.CanvasPosition = tabInfo.Position
		else
			selectTab(1, category.pages[1])
		end
	end

	if LayoutInfo.isLandscape then
		setScrollButtonVisible(#category.pages > 6)
	end
end

return function(CategoryMenu, PageManager, inTabList, inTabListContainer)
	tabList = inTabList
	tabListContainer = inTabListContainer

	initTabList()

	local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	local tweenInfoFast = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

	local imageInvisible = { ImageTransparency = 1 }
	local backgroundInvisible = { BackgroundTransparency = 1 }
	local textInvisible = { TextTransparency = 1 }

	local imageVisible = { ImageTransparency = 0 }
	local backgroundVisible = { BackgroundTransparency = 0 }
	local textVisible = { TextTransparency = 0 }

	CategoryMenu.openCategoryMenuEvent:Connect(function()
		if LayoutInfo.isLandscape then
			tween(tabListContainer.TabListBackground, tweenInfo, imageInvisible)
			tween(tabListContainer.ScrollButtonDown.Arrow, tweenInfo, imageInvisible)

			for _, obj in next, tabList.Contents:GetChildren() do
				if obj.ClassName == 'ImageButton' then
					-- tab button
					if obj.Name == 'Tab'..PageManager:getPageName() then
						local objTweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
						tween(obj, objTweenInfo, backgroundInvisible)
					else
						local objTweenInfo = TweenInfo.new(0)
						tween(obj, objTweenInfo, backgroundInvisible)
					end

					tween(obj.ImageLabel, tweenInfo, imageInvisible)
					tween(obj.TextLabel, tweenInfo, textInvisible)
				else
					tween(obj, tweenInfo, backgroundInvisible)
				end
			end

			tabListContainer.ScrollButtonDown.Button.Visible = false

			tween(tabListContainer.ScrollButtonDown.Gradient, tweenInfoFast, imageInvisible)
			tween(tabListContainer.ScrollButtonDown.BackgroundClipper.Background, tweenInfoFast, imageInvisible)
		end
	end)

	CategoryMenu.closeCategoryMenuEvent:Connect(function()
		if LayoutInfo.isLandscape then
			for _, obj in next, tabList.Contents:GetChildren() do
				if obj.ClassName == 'ImageButton' then
					if obj.Name == 'Tab'..PageManager:getPageName() then
						tween(obj, tweenInfo, backgroundVisible, backgroundInvisible)
					end
					tween(obj.ImageLabel, tweenInfo, imageVisible, imageInvisible)
					tween(obj.TextLabel, tweenInfo, textVisible, textInvisible)
				else
					tween(obj, tweenInfo, backgroundVisible, backgroundInvisible)
				end
			end

			local atBottom = tabList.CanvasPosition.y + tabList.AbsoluteSize.y >= tabList.CanvasSize.Y.Offset
			if not atBottom then
				tabListContainer.ScrollButtonDown.Button.Visible = true
				tween(tabListContainer.ScrollButtonDown.Gradient, tweenInfo, imageVisible)
				tween(tabListContainer.ScrollButtonDown.BackgroundClipper.Background, tweenInfo, imageVisible)
				tween(tabListContainer.ScrollButtonDown.Arrow, tweenInfo, imageVisible)
			end

			tween(tabListContainer.TabListBackground, tweenInfo, imageVisible, imageInvisible).Completed:Connect(function()
				if not LayoutInfo.isLandscape then
					local objTweenInfo = TweenInfo.new(0)
					for _, obj in next, tabList.Contents:GetChildren() do
						if obj.ClassName == 'ImageButton' then
							tween(obj, objTweenInfo, backgroundVisible, backgroundInvisible)
						end
					end
				end
			end)
		end
	end)

	AppState.Store.Changed:Connect(function(newState, oldState)
		if newState.Category.CategoryIndex ~= oldState.Category.CategoryIndex then
			changeCategory(newState.Category.CategoryIndex)
		end
	end)


	return this
end
