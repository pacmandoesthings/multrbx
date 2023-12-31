--[[
			// SocialMorePane.lua

			// Shows a full grid view of a social view. Only shown if social items for a given
			// view are above a threshold set by SocialPane.lua
			// User by SocialPane.lua

			// TODO:
				Bug with TabDock where its removing focus of the last tab when re-entering the tab dock
]]
local CoreGui = Game:GetService("CoreGui")
local GuiRoot = CoreGui:FindFirstChild("RobloxGui")
local Modules = GuiRoot:FindFirstChild("Modules")
local ShellModules = Modules:FindFirstChild("Shell")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")

local AssetManager = require(ShellModules:FindFirstChild('AssetManager'))
local Utility = require(ShellModules:FindFirstChild('Utility'))
local GlobalSettings = require(ShellModules:FindFirstChild('GlobalSettings'))
local ScrollingGridModule = require(ShellModules:FindFirstChild('ScrollingGrid'))
local ScreenManager = require(ShellModules:FindFirstChild('ScreenManager'))
local FriendsData = require(ShellModules:FindFirstChild('FriendsData'))
local FriendsView = require(ShellModules:FindFirstChild('FriendsView'))
local Analytics = require(ShellModules:FindFirstChild('Analytics'))

local createSocialScreen = function(currentScreenTitle, previousScreenName)
	local this = {}

	local mySocialView = nil

	local container = Utility.Create'Frame'
	{
		Name = "SocialContainer";
		Size = UDim2.new(1, 0, 1, 0);
		BackgroundTransparency = 1;
		Visible = false;
	}
	local backLabel = Utility.Create'ImageLabel'
	{
		-- PLACE HOLDER
		Name = "BackLabel";
		Position = UDim2.new(0, 0, 0, 0);
		BackgroundTransparency = 1;
		ZIndex = 2;
		Parent = container;

		Image = "rbxasset://textures/ui/Shell/Icons/BackIcon@1080.png";
		Size = UDim2.new(0,48,0,48);
	}

	-- Right now previous screen is always Friends, but we're still using previousScreenName in case
	-- recently played with ever makes it in
	local backText = Utility.Create'TextLabel'
	{
		Name = "BackText";
		Size = UDim2.new(0, 0, 0, backLabel.Size.Y.Offset);
		Position = UDim2.new(0, backLabel.Size.X.Offset + 8, 0, 0);
		BackgroundTransparency = 1;
		Font = GlobalSettings.RegularFont;
		FontSize = GlobalSettings.ButtonSize;
		TextXAlignment = Enum.TextXAlignment.Left;
		TextColor3 = GlobalSettings.WhiteTextColor;
		Text = Utility.Upper(previousScreenName);
		Parent = container;
	}
	local titleLabel = Utility.Create'TextLabel'
	{
		Name = "TitleLabel";
		Size = UDim2.new(0, 0, 0, 35);
		Position = UDim2.new(0, 16, 0, backLabel.Size.Y.Offset + 74);
		BackgroundTransparency = 1;
		Text = Utility.Upper(currentScreenTitle);
		TextColor3 = GlobalSettings.WhiteTextColor;
		TextXAlignment = Enum.TextXAlignment.Left;
		Font = GlobalSettings.LightFont;
		FontSize = GlobalSettings.HeaderSize;
		Parent = container;
	}

	local socialScrollingGrid = ScrollingGridModule()
	socialScrollingGrid:SetSize(UDim2.new(0, 1438, 0, 610))
	socialScrollingGrid:SetCellSize(Vector2.new(446, 114))
	socialScrollingGrid:SetSpacing(Vector2.new(50, 10))
	socialScrollingGrid:SetScrollDirection(socialScrollingGrid.Enum.ScrollDirection.Horizontal)
	socialScrollingGrid:SetPosition(UDim2.new(0, 0, 0, titleLabel.Position.Y.Offset + titleLabel.Size.Y.Offset + 90))
	socialScrollingGrid:SetClipping(false)
	socialScrollingGrid:SetParent(container)

	--[[ Set Images ]]--
	local function setSocialView()
		Utility.DebugLog('set the social screen data')
		local friendsData = FriendsData.GetOnlineFriendsAsync()
		mySocialView = FriendsView(socialScrollingGrid, friendsData, nil, nil)
	end

	--[[ Public API ]]--
	function this:GetAnalyticsInfo()
		return
		{
			[Analytics.WidgetNames('WidgetId')] = Analytics.WidgetNames('SocialScreenId');
			Title = currentScreenTitle;
		}
	end

	function this:Show()
		container.Visible = true
		self.TransitionTweens = ScreenManager:DefaultFadeIn(container)
		ScreenManager:PlayDefaultOpenSound()
	end

	function this:Hide()
		container.Visible = false
		container.Parent = nil
		ScreenManager:DefaultCancelFade(self.TransitionTweens)
		self.TransitionTweens = nil
	end

	function this:Focus()
		if self.SavedSelectedObject and self.SavedSelectedObject:IsDescendantOf(container) then
			Utility.SetSelectedCoreObject(self.SavedSelectedObject)
		else
			if mySocialView then
				Utility.SetSelectedCoreObject(mySocialView:GetDefaultFocusItem())
			end
		end
		--
		ContextActionService:BindCoreAction("ReturnFromSocialScreen",
			function(actionName, inputState, inputObject)
				if inputState == Enum.UserInputState.End then
					ScreenManager:CloseCurrent()
				end
			end,
			false, Enum.KeyCode.ButtonB)
	end

	function this:RemoveFocus()
		local selectedObject = GuiService.SelectedCoreObject
		if selectedObject and selectedObject:IsDescendantOf(container) then
			self.SavedSelectedObject = selectedObject
			Utility.SetSelectedCoreObject(nil)
		else
			self.SavedSelectedObject = nil
		end
		ContextActionService:UnbindCoreAction("ReturnFromSocialScreen")
	end

	function this:SetPosition(newPosition)
		container.Position = newPosition
	end

	function this:SetParent(newParent)
		container.Parent = newParent
	end

	setSocialView()

	return this
end

return createSocialScreen
