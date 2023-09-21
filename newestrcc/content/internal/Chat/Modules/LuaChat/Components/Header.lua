local PlayerService = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LuaApp = CoreGui.RobloxGui.Modules.LuaApp
local StringsLocale = require(LuaApp.StringsLocale)

local Modules = script.Parent.Parent
local Components = Modules.Components

local Create = require(Modules.Create)
local Signal = require(Modules.Signal)
local Constants = require(Modules.Constants)

local TextButton = require(Components.TextButton)
local BaseHeader = require(Components.BaseHeader)

local HEIGHT_OF_DISCONNECTED = 32

local Header = BaseHeader:Template()
Header.__index = Header

function Header.new(appState, dialogType)
	local self = {}

	self.heightOfHeader = UserInputService.NavBarSize.Y + UserInputService.StatusBarSize.Y
	self.heightOfDisconnected = HEIGHT_OF_DISCONNECTED

	self.buttons = {}
	self.connections = {}
	self.appState = appState
	self.dialogType = dialogType
	self.backButton = BaseHeader:GetNewBackButton()
	self.backButton.rbx.Visible = false
	self.title = ""
	self.subtitle = nil
	self.connectionState = Enum.ConnectionState.Connected

	self.BackButtonPressed = Signal.new()
	self.backButton.Pressed:Connect(function()
		self.BackButtonPressed:Fire()
	end)

	self.rbx = Create.new "Frame" {
		Name = "HeaderFrame",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, self.heightOfHeader),

		Create.new "Frame" {
			Name = "Disconnected",
			BackgroundColor3 = Constants.Color.GRAY3,
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(0, 1),
			Size = UDim2.new(1, 0, 0, 0), -- Note: Deliberately has zero vertical height, will be scaled when shown.
			Position = UDim2.new(0, 0, 1, 0),
			ClipsDescendants = true,

			Create.new "TextLabel" {
				Name = "Title",
				BackgroundTransparency = 1,
				TextSize = 14,
				TextColor3 = Constants.Color.WHITE,
				Size = UDim2.new(1, 0, 0, HEIGHT_OF_DISCONNECTED),
				Position = UDim2.new(0.5, 0, 1, 0),
				AnchorPoint = Vector2.new(0.5, 1),
				Text = appState.localization:Format(StringsLocale.Keys.NO_NETWORK_CONNECTION),
				Font = "SourceSansBold",
				LayoutOrder = 0,
			},
		},

		Create.new "Frame" {
			Name = "Header",
			BackgroundColor3 = Constants.Color.BLUE_PRESSED,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, self.heightOfHeader),

			Create.new "Frame" {
				Name = "Content",
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, -Constants.PlatformSpecific.HEADER_CONTENT_FRAME_Y_OFFSET),
				Position = UDim2.new(0, 0, 0, Constants.PlatformSpecific.HEADER_CONTENT_FRAME_Y_OFFSET),

				self.backButton.rbx,

				Create.new "Frame" {
					Name = "Titles",
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 200, 1, 0),
					Position = Constants.PlatformSpecific.HEADER_TITLE_FRAME_POSITION,
					AnchorPoint = Constants.PlatformSpecific.HEADER_TITLE_FRAME_ANCHOR_POINT,

					Create.new "UIListLayout" {
						SortOrder = "LayoutOrder",
						VerticalAlignment = Constants.PlatformSpecific.HEADER_VERTICAL_ALIGNMENT,
					},

					Create.new "TextLabel" {
						Name = "Title",
						BackgroundTransparency = 1,
						TextSize = 20,
						TextColor3 = Constants.Color.WHITE,
						Size = UDim2.new(0, 200, 0, 18),
						AnchorPoint = Vector2.new(0.5, 0.5),
						TextXAlignment = Constants.PlatformSpecific.HEADER_TEXT_X_ALIGNMENT,
						Text = "Title",
						Font = "SourceSansBold",
						LayoutOrder = 0,
					},

					Create.new "TextLabel" {
						Name = "Subtitle",
						BackgroundTransparency = 1,
						TextSize = 12,
						TextColor3 = Constants.Color.WHITE,
						Size = UDim2.new(0, 200, 0, 12),
						AnchorPoint = Vector2.new(0.5, 0.5),
						TextXAlignment = Constants.PlatformSpecific.HEADER_TEXT_X_ALIGNMENT,
						Text = "",
						Font = "SourceSans",
						LayoutOrder = 1,
					},
				},

				Create.new "Frame" {
					Name = "Buttons",
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -5, 0, 0),
					Size = UDim2.new(0, 100, 1, 0),
					AnchorPoint = Vector2.new(1, 0),

					Create.new "UIListLayout" {
						SortOrder = "LayoutOrder",
						HorizontalAlignment = "Right",
						FillDirection = "Horizontal",
						VerticalAlignment = Constants.PlatformSpecific.HEADER_VERTICAL_ALIGNMENT,
					},
				},
			},
		},
	}

	self.rbx:GetPropertyChangedSignal("Parent"):Connect(function()
		if self.rbx and self.rbx.Parent then
			game:GetService("RunService").Stepped:wait() -- TextBounds isn't recalculated when this fires so we wait
			self:SetTitle(self.title) -- Again, this can be much cleaner once we have proper truncation support
		end
	end)

	do
		local userId = PlayerService.localPlayer.userId
		local connection = appState.store.Changed:Connect(function(state, oldState)
			if state.Users == oldState.Users then
				return
			end

			if state.Users[userId] == oldState.Users[userId] then
				return
			end

			self:SetConnectionState()
		end)
		table.insert(self.connections, connection)
	end

	setmetatable(self, Header)
	return self
end

function Header:CreateHeaderButton(name, textKey)
	local saveGroup = TextButton.new(self.appState, name, textKey)
	self:AddButton(saveGroup)
	return saveGroup
end

return Header