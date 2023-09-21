local CoreGui = Game:GetService("CoreGui")
local GuiRoot = CoreGui:FindFirstChild("RobloxGui")
local Modules = GuiRoot:FindFirstChild("Modules")
local ShellModules = Modules:FindFirstChild("Shell")
local Utility = require(ShellModules:FindFirstChild('Utility'))

if not Utility.IsFastFlagEnabled("XboxCPPAccountScreen5") then

local UserData = require(ShellModules:FindFirstChild('UserData'))
local Strings = require(ShellModules:FindFirstChild('LocalizedStrings'))

local SetAccountCredentialsScreen = require(ShellModules:FindFirstChild('SetAccountCredentialsScreen'))
local UnlinkAccountScreen = require(ShellModules:FindFirstChild('UnlinkAccountScreen'))

-- This is an empty page that is a place holder. Account page changes depending on cases
local function createAccountScreen()
	local hasLinkedAccount = UserData:HasLinkedAccount()
	local hasRobloxCredentials = UserData:HasRobloxCredentials()

	-- Cases
	-- 1. Has roblox credentials, which implies they have a linked account
	-- 2. No credentials but a linked account
	-- 3. No Credentials/No Linked account - this should never happen, but cover it
	-- 4. One of these calls has a web error, result will be nil in that case

	-- Legacy
	-- Old signup flow could put a user in a state where they were linked but did not set credentials.
	-- We need to continue to check this until all accounts in this state have been cleaned up. When this
	-- happens, this should just return the unlink screen, or rather the caller can just request an unlink screen

	local this = nil

	if hasRobloxCredentials ~= nil and hasLinkedAccount ~= nil then
		if hasRobloxCredentials == true then
			this = UnlinkAccountScreen()
		elseif hasLinkedAccount == true and hasRobloxCredentials == false then
			this = SetAccountCredentialsScreen(Strings:LocalizedString("SignUpTitle"),
				Strings:LocalizedString("SignUpPhrase"), Strings:LocalizedString("SignUpWord"))
		end
	end

	return this
end

return createAccountScreen

else

local ContextActionService = game:GetService('ContextActionService')
local GuiService = game:GetService('GuiService')

local BaseScreen = require(ShellModules:FindFirstChild('BaseScreen'))
local EventHub = require(ShellModules:FindFirstChild('EventHub'))
local GlobalSettings = require(ShellModules:FindFirstChild('GlobalSettings'))
local Strings = require(ShellModules:FindFirstChild('LocalizedStrings'))
local Analytics = require(ShellModules:FindFirstChild('Analytics'))

local AccountLinkingView = require(ShellModules:FindFirstChild('AccountLinkingView'))
local GameplaySettingsView = require(ShellModules:FindFirstChild('GameplaySettingsView'))

local function createAccountScreen()
	local this = BaseScreen()

	this:SetTitle(Strings:LocalizedString("AccountSettingsTitle"))

	local dummySelection = Utility.Create'Frame'
	{
		BackgroundTransparency = 1;
	}

	local AccountLinkingViewContainer = Utility.Create'Frame'
	{
		Name = "AccountLinkingViewContainer";
		Position = UDim2.new(0, 75, 0, 275);
		Size = UDim2.new(0, 765, 0, 630);
		BorderSizePixel = 0;
		BackgroundTransparency = 1;
		Parent = this.Container
	}

	local accountLinkingView = AccountLinkingView()
	accountLinkingView:SetParent(AccountLinkingViewContainer)


	if Utility.IsFastFlagEnabled("XboxUseCrossPlatformPlay5") then
		local ScreenDivide = Utility.Create'Frame'
		{
			Name = "ScreenDivide";
			Size = UDim2.new(0, 2, 0, 615);
			Position = UDim2.new(0, 840, 0, 275);
			BorderSizePixel = 0;
			BackgroundColor3 = GlobalSettings.PageDivideColor;
			Parent = this.Container;
		}

		local gameplaySettingsViewContainer = Utility.Create'Frame'
		{
			Name = "gameSettingsViewContainer";
			Position = UDim2.new(0, 840, 0, 275);
			Size = UDim2.new(0, 765, 0, 630);
			BorderSizePixel = 0;
			BackgroundTransparency = 1;
			Parent = this.Container;
		}

		local unlinkButton = accountLinkingView:GetUnlinkButton()

		local function connectSelection(gameplaySettingsView)
			local enabledStatusButton = gameplaySettingsView:GetEnabledStatusButton()

			unlinkButton.NextSelectionLeft = unlinkButton
			unlinkButton.NextSelectionRight = enabledStatusButton
			unlinkButton.NextSelectionUp = enabledStatusButton
			unlinkButton.NextSelectionDown = unlinkButton

			enabledStatusButton.NextSelectionLeft = unlinkButton
			enabledStatusButton.NextSelectionRight = enabledStatusButton
			enabledStatusButton.NextSelectionUp = enabledStatusButton
			enabledStatusButton.NextSelectionDown = unlinkButton
		end

		unlinkButton.NextSelectionLeft = unlinkButton
		unlinkButton.NextSelectionRight = unlinkButton
		unlinkButton.NextSelectionUp = unlinkButton
		unlinkButton.NextSelectionDown = unlinkButton

		GameplaySettingsView(connectSelection):SetParent(gameplaySettingsViewContainer)
	end


	--[[ Public API ]]--
	function this:GetAnalyticsInfo()
		return {[Analytics.WidgetNames('WidgetId')] = Analytics.WidgetNames('UnlinkAccountScreenId')}
	end

	-- Override
	function this:GetDefaultSelectionObject()
		return accountLinkingView:GetUnlinkButton()
	end

	-- Override
	local baseFocus = this.Focus
	function this:Focus()
		baseFocus(self)
		accountLinkingView:Focus()
	end

	-- Override
	local baseRemoveFocus = this.RemoveFocus
	function this:RemoveFocus()
		baseRemoveFocus(self)
		accountLinkingView:RemoveFocus()
	end

	return this
end

return createAccountScreen

end
