local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local Mobile = CoreGui.RobloxGui.Modules.Mobile

local Create = require(Mobile.Create)
local Constants = require(Mobile.Constants)
local MobileAppState = require(Mobile.AppState)

local ChatMaster = nil
local AvatarEditorMain = nil

local AppNames = {
	"AvatarEditor",
	"Chat",
}

local AppNameEnum = {}
for i = 1, #AppNames do
	AppNameEnum[AppNames[i]] = AppNames[i]
end

setmetatable(AppNameEnum, {
	__index = function(self, key)
		error(("Invalid AppNameEnum %q"):format(tostring(key)))
	end
})

--[[
	As long as initializing AvatarEditorMain requires a yield, it has to run in a
	spawned task.  It is then possible for the user to switch apps in the middle of
	initialization.  So, openAvatarEditor and closeAvatarEditor first check to see
	if it's currently initializing, and if it is, they set a bool indicating whether
	to call Start() when initialization is done.
]]
local startAvatarEditorAfterInitializing = false


local function notifyAppReady(appName)
	spawn(function()
		GuiService:BroadcastNotification(appName, GuiService:GetNotificationTypeList().APP_READY)
	end)
end


local function openChat()
	if ChatMaster == nil then
		ChatMaster = require(CoreGui.RobloxGui.Modules.ChatMaster).new()
	end

	ChatMaster:Start()
	notifyAppReady(AppNameEnum.Chat)
end


local function closeChat()
	ChatMaster:Stop()
end


local openAvatarEditor = function()
	startAvatarEditorAfterInitializing = true
end


local closeAvatarEditor = function()
	startAvatarEditorAfterInitializing = false
end


if settings():GetFFlag("EnabledAvatarEditorV3") then
	spawn(function()
		-- Fit the main content of the gui under the nav bar
		AvatarEditorMain =
			require(CoreGui.RobloxGui.Modules.LuaApp.Legacy.AvatarEditor.AvatarEditorMain)
				.new(Constants.Header.HEIGHT)

		local function startAvatarEditor()
			AvatarEditorMain:Start()
			notifyAppReady(AppNameEnum.AvatarEditor)
		end

		if startAvatarEditorAfterInitializing then
			startAvatarEditor()
		end

		openAvatarEditor = startAvatarEditor

		closeAvatarEditor = function()
			AvatarEditorMain:Stop()
		end
	end)
else
	spawn(function()
		AvatarEditorMain = require(CoreGui.RobloxGui.Modules.AvatarEditorMainV2)

		local function startAvatarEditor()
			AvatarEditorMain.Start()
			notifyAppReady(AppNameEnum.AvatarEditor)
		end

		if startAvatarEditorAfterInitializing then
			startAvatarEditor()
		end

		openAvatarEditor = startAvatarEditor

		closeAvatarEditor = function()
			AvatarEditorMain.Stop()
		end
	end)
end


local function initMobile()
	local appState = MobileAppState.new()

	GuiService:SetGlobalGuiInset(0, 0, 0, UserInputService.BottomBarSize.Y)
	local screenGui = Create.new "ScreenGui" {
		Name = "HackScreenGui",
		DisplayOrder = 1,

		Create.new "Frame" {
			Name = "HackHeader",
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(1, 0, 0, Constants.Header.HEIGHT),
			BorderSizePixel = 0,
			BackgroundColor3 = Constants.Color.BLUE_PRESSED,
		}
	}
	screenGui.Parent = CoreGui

	appState.store.Changed:Connect(
		function(newState, oldState)
			if oldState.OpenApp ~= newState.OpenApp then

				if newState.OpenApp == AppNameEnum.Chat then
					openChat()
				end

				if newState.OpenApp == AppNameEnum.AvatarEditor then
					openAvatarEditor()
				end

				if oldState.OpenApp == AppNameEnum.Chat then
					closeChat()
				end

				if oldState.OpenApp == AppNameEnum.AvatarEditor then
					closeAvatarEditor()
				end
			end
		end
	)
end


initMobile()

