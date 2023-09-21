local GuiService = game:GetService("GuiService")
local ContextActionService = game:GetService("ContextActionService")

local Modules = game:GetService("CoreGui"):FindFirstChild("RobloxGui").Modules

local AppState = require(Modules.LuaApp.Legacy.AvatarEditor.AppState)
local SelectCategoryTab = require(Modules.LuaApp.Actions.SelectCategoryTab)

local LayoutInfo = require(Modules.LuaApp.Legacy.AvatarEditor.LayoutInfoConsole)
local Utilities = require(Modules.LuaApp.Legacy.AvatarEditor.Utilities)
local Categories = require(Modules.LuaApp.Legacy.AvatarEditor.Categories)
local TweenController = require(Modules.LuaApp.Legacy.AvatarEditor.TweenInstanceController)

local function createTabList(container, CategoryMenu, PageManager)
	local this = {}

	local tabButtons = {}
	local selectedTabIndex = 1

	local STATE = {
		OPEN = "Open"; -- Tablist has been open by pressing "A" on one tabButton
		CLOSED = "Closed"; -- Tablist is closed and player is navigating between all tabButtons
		HIDDEN = "Hidden"; -- FullView mode
	}
	local state = STATE.CLOSED

	local SELECTOR_TOP_MIN_DISTANCE = LayoutInfo.SelectorTopMinDistance
	local SELECTOR_BOTTOM_MIN_DISTANCE = LayoutInfo.SelectorBottomMinDistance

	local firstVisibleTabIndex = 1

	local userInputServiceConn = nil
	local storeChangedCn = nil
	local openCategoryMenuConn = nil
	local closeCategoryMenuConn = nil
	local tweenConns = {}

	local TabList = Utilities.create'Frame'
	{
		Name = 'TabList';
		Position = LayoutInfo.TabListPosition;
		Size = UDim2.new(0, 360, 1, 0);
		BackgroundTransparency = 1;
		Parent = container;
		Visible = false;
	}

	Utilities.create'UIListLayout'
	{
		Name = 'TabListUIListLayout';
		Padding = UDim.new(0, 20);
		Parent = TabList;
	}

	local buttonSelector = Utilities.create'ImageLabel'
	{
		Name = 'TabSelector';
		Image = "rbxasset://textures/ui/Shell/AvatarEditor/graphic/gr-item selector-8px corner.png";
		Position = UDim2.new(0, -7, 0, -7);
		Size = UDim2.new(1, 14, 1, 14);
		BackgroundTransparency = 1;
		ScaleType = Enum.ScaleType.Slice;
		SliceCenter = Rect.new(31, 31, 63, 63);
	}

	local function getCategoryIndex()
		return AppState.Store:GetState().Category.CategoryIndex
	end

	local function tweenTabListState(state, tweenTime)
		tweenTime = tweenTime or 0.2
		local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0)

		if state == STATE.HIDDEN then
			TweenController(TabList, tweenInfo, { Position = UDim2.new(0, -360, 0, 270) })
		elseif state == STATE.CLOSED or state == STATE.OPEN then
			TweenController(TabList, tweenInfo, { Position = LayoutInfo.TabListPosition })
		end
	end

	-- Navigate on tabButton to highlight tabButton
	local function highlightTabButton(tabButton)
		tabButton.Image = LayoutInfo.CategoryButtonImageSelected;
		tabButton.TabText.TextColor3 = LayoutInfo.BlueTextColor
		tabButton.TabText.TextTransparency = 0
	end

	-- Default tabButton style
	local function defaultTabButton(tabButton)
		tabButton.Image = LayoutInfo.CategoryButtonImageDefault;
		tabButton.TabText.TextColor3 = LayoutInfo.WhiteTextColor
		tabButton.TabText.TextTransparency = 0
	end

	-- Inactive tabButton style
	local function inactiveTabButton(tabButton)
		tabButton.Image = LayoutInfo.CategoryButtonImageInactive;
		tabButton.TabText.TextTransparency = 0.5
	end

	-- Active TabList style
	local function activeTabList()
		for i = 1, #tabButtons do
			if selectedTabIndex ~= i then
				defaultTabButton(tabButtons[i])
			else
				highlightTabButton(tabButtons[i])
			end
		end
	end

	-- Inactive Tablist style
	local function inactiveTabList()
		for i = 1, #tabButtons do
			if selectedTabIndex ~= i then
				inactiveTabButton(tabButtons[i])
			end
		end
	end

	-- Open one of the tabButtons
	local function openTab()
		state = STATE.OPEN
		inactiveTabList()
		GuiService.SelectedCoreObject = nil

		-- Select first gui in PageManager
		PageManager:focusOnCard()
	end

	-- Close tab and back to navigation between all tabButtons
	local function closeTab()
		state = STATE.CLOSED
		activeTabList()
		GuiService.SelectedCoreObject = tabButtons[selectedTabIndex]
	end

	-- Check if TabList need to scroll up/down
	local function checkScroll()
		local selectedObject = GuiService.SelectedCoreObject
		local topDistance = selectedObject.AbsolutePosition.Y
		local bottomDistance = container.AbsoluteSize.Y - topDistance - selectedObject.AbsoluteSize.Y
		local tweenInfo =
			TweenInfo.new(
				LayoutInfo.DefaultTweenTime,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.InOut, 0, false, 0)

		if bottomDistance < SELECTOR_BOTTOM_MIN_DISTANCE then
			-- Scroll down, TabList move up or make first item invisible
			if TabList.AbsolutePosition.Y == SELECTOR_TOP_MIN_DISTANCE then
				TweenController(TabList, tweenInfo, { Position = LayoutInfo.TabListScrollPosition })
			else
				table.insert(tweenConns, TweenController(TabList, tweenInfo,
					{
						Position = LayoutInfo.TabListScrollPosition - UDim2.new(0, 0, 0, 100)
					}
				).Completed:Connect(
					function()
						tabButtons[firstVisibleTabIndex].Visible = false
						firstVisibleTabIndex = firstVisibleTabIndex + 1
						TabList.Position = LayoutInfo.TabListScrollPosition
					end
				))
			end
		elseif topDistance < SELECTOR_TOP_MIN_DISTANCE then
			-- Scroll up, TabList move down or make first item visible
			local propGoals = {
				Position = LayoutInfo.TabListPosition
			}
			if firstVisibleTabIndex > 1 then
				firstVisibleTabIndex = firstVisibleTabIndex - 1
				table.insert(tweenConns, TweenController(TabList, tweenInfo, propGoals).Completed:Connect(function()
					tabButtons[firstVisibleTabIndex].Visible = true
					TabList.Position = LayoutInfo.TabListScrollPosition
				end))
			else
				TweenController(TabList, tweenInfo, propGoals)
			end
		end
	end

	local function selectTab(newTabButton, oldTabButton)
		if oldTabButton then
			defaultTabButton(oldTabButton)
		end
		highlightTabButton(newTabButton)
		checkScroll()
	end

	local function getTabInfo(tabButton)
		local topDistance = tabButton.AbsolutePosition.Y
		local bottomDistance = container.AbsoluteSize.Y - topDistance - tabButton.AbsoluteSize.Y
		local tabInfo = {}
		tabInfo.Position = TabList.Position
		tabInfo.FirstVisibleTabIndex = firstVisibleTabIndex

		if bottomDistance < SELECTOR_BOTTOM_MIN_DISTANCE then
			-- Scroll down, TabList move up or make first item invisible
			tabInfo.Position = LayoutInfo.TabListScrollPosition

			if TabList.AbsolutePosition.Y < SELECTOR_TOP_MIN_DISTANCE then
				tabInfo.FirstVisibleTabIndex = firstVisibleTabIndex + 1
			end
		elseif topDistance < SELECTOR_TOP_MIN_DISTANCE then
			-- Scroll up, TabList move down or make first item visible
			if firstVisibleTabIndex > 1 then
				tabInfo.Position = LayoutInfo.TabListScrollPosition
				tabInfo.FirstVisibleTabIndex = firstVisibleTabIndex - 1
			else
				tabInfo.Position = LayoutInfo.TabListPosition
			end
		end
		return tabInfo
	end

	local function createTabButton(index, title)
		--ImageButton will prevent the ButtonA Press passing into ContextActionService
		local TabButton = Utilities.create'ImageLabel'
		{
			Name = index < 10 and 'Tab0'..index or 'Tab'..index;
			Size = LayoutInfo.CategoryButtonDefaultSize;
			BackgroundTransparency = 1;
			BorderSizePixel = 0;
			Image = LayoutInfo.CategoryButtonImageDefault;
			ScaleType = Enum.ScaleType.Slice;
			SliceCenter = Rect.new(8, 8, 9, 9);
			Parent = TabList;
			Selectable = true;
			SelectionImageObject = buttonSelector;
		}

		local TabText = Utilities.create'TextLabel'
		{
			Name = 'TabText';
			Position = UDim2.new(0, 20, 0, 0);
			Size = UDim2.new(1, 0, 1, 0);
			BackgroundTransparency = 1;
			BorderSizePixel = 0;
			Text = title;
			TextXAlignment = 'Left';
			TextColor3 = LayoutInfo.WhiteTextColor;
			TextSize = LayoutInfo.ButtonFontSize;
			Font = LayoutInfo.RegularFont;
			Parent = TabButton;
		}


		local tweenInfo = TweenInfo.new(
			LayoutInfo.DefaultTweenTime,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.InOut, 0, false, 0)

		TweenController(TabButton, tweenInfo, { ImageTransparency = 0 }, { ImageTransparency = 1 })
		TweenController(TabText, tweenInfo, { TextTransparency = 0 }, { TextTransparency = 1 })

		TabButton.SelectionGained:connect(function()
			if selectedTabIndex ~= index then
				local tabInfo = getTabInfo(TabButton)
				AppState.Store:Dispatch(
					SelectCategoryTab(
						getCategoryIndex(), index, tabInfo.Position, tabInfo.FirstVisibleTabIndex))
			end
		end)

		return TabButton
	end

	local function updateTabButton(tabButton, title)
		tabButton.TabText.Text = title
		local tweenInfo = TweenInfo.new(
			LayoutInfo.DefaultTweenTime,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.InOut, 0, false, 0)

		TweenController(tabButton, tweenInfo, { ImageTransparency = 0 }, { ImageTransparency = 1 })
		TweenController(tabButton.TabText, tweenInfo, { TextTransparency = 0 }, { TextTransparency = 1 })
	end

	local function createTabButtons()
		local tabPages = Categories[getCategoryIndex()].pages

		-- Remove redundant tabButtons
		while #tabButtons > #tabPages do
			tabButtons[#tabButtons]:Destroy()
			tabButtons[#tabButtons] = nil
		end

		if #tabPages < 1 then
			return
		end

		-- Update existing tabButtons or create new tabButtons
		for i = 1, #tabPages do
			if tabButtons[i] then
				updateTabButton(tabButtons[i], tabPages[i].title)
			else
				local tabButton = createTabButton(i, tabPages[i].title)
				table.insert(tabButtons, tabButton)
			end
		end

		closeTab()
	end

	local function disconnectUserInputService()
		ContextActionService:UnbindCoreAction("TabListConsole")
	end

	local function connectUserInputService()
		ContextActionService:UnbindCoreAction("TabListConsole")
		ContextActionService:BindCoreAction("TabListConsole",
			function(actionName, inputState, inputObject)
				if inputState == Enum.UserInputState.End then
					if inputObject.KeyCode == Enum.KeyCode.ButtonA then
						if state == STATE.CLOSED and PageManager:hasAssets() then
							openTab()
						end
					elseif inputObject.KeyCode == Enum.KeyCode.ButtonB then
						if state == STATE.CLOSED then
							CategoryMenu.selectCurrentCategory()
						elseif state == STATE.OPEN then
							closeTab()
						end
					end
				end
			end,
			false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonA)
	end

	local function openCategoryMenu()
		local tabInfo = AppState.Store:GetState().Category.TabsInfo[getCategoryIndex()]
		if tabInfo and tabInfo.TabIndex and tabInfo.Position and tabInfo.FirstVisibleTabIndex then
			TabList.Position = tabInfo.Position
			firstVisibleTabIndex = tabInfo.FirstVisibleTabIndex
		else
			firstVisibleTabIndex = 1
			TabList.Position = LayoutInfo.TabListPosition
		end
		createTabButtons()

		for i = 1, firstVisibleTabIndex - 1 do
			tabButtons[i].Visible = false
		end
		for i = firstVisibleTabIndex, #tabButtons do
			tabButtons[i].Visible = true
		end
		TabList.Visible = true
		connectUserInputService()
	end

	local function closeCategoryMenu()
		TabList.Visible = false
		disconnectUserInputService()
	end

	local function update(newState, oldState)
		if newState.Category.CategoryIndex ~= oldState.Category.CategoryIndex or
			newState.Category.TabsInfo ~= oldState.Category.TabsInfo then

			local oldTabIndex = selectedTabIndex
			local tabInfo = newState.Category.TabsInfo[newState.Category.CategoryIndex]
			if tabInfo and tabInfo.TabIndex then
				selectedTabIndex = tabInfo.TabIndex
			else
				selectedTabIndex = 1
			end
			if newState.Category.TabsInfo ~= oldState.Category.TabsInfo then
				selectTab(tabButtons[selectedTabIndex], tabButtons[oldTabIndex], tabInfo.Position, tabInfo.FirstVisibleTabIndex)
			end
		end
		if newState.FullView ~= oldState.FullView then
			if newState.FullView then
				tweenTabListState(STATE.HIDDEN)
			else
				tweenTabListState(state)
			end
		end
	end

	function this:Focus()
		if TabList.Visible then
			connectUserInputService()
		end
		openCategoryMenuConn = CategoryMenu.openCategoryMenuEvent:Connect(openCategoryMenu)
		closeCategoryMenuConn = CategoryMenu.closeCategoryMenuEvent:Connect(closeCategoryMenu)
		storeChangedCn = AppState.Store.Changed:Connect(update)
		GuiService:AddSelectionParent("Tablist", TabList)
	end

	function this:RemoveFocus()
		userInputServiceConn = Utilities.disconnectEvent(userInputServiceConn)
		openCategoryMenuConn = Utilities.disconnectEvent(openCategoryMenuConn)
		closeCategoryMenuConn = Utilities.disconnectEvent(closeCategoryMenuConn)
		storeChangedCn = Utilities.disconnectEvent(storeChangedCn)
		Utilities.disconnectEvents(tweenConns)
		tweenConns = {}
		GuiService:RemoveSelectionGroup("Tablist")
	end

	return this
end

return createTabList
