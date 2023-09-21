local LuaChat = script.Parent.Parent
local Create = require(LuaChat.Create)
local Constants = require(LuaChat.Constants)
local Signal = require(LuaChat.Signal)

local ListEntry = require(LuaChat.Components.ListEntry)

local ICON_CELL_WIDTH = 60
local CLEAR_TEXT_WIDTH = 50
local HEIGHT = 48

local TextInputEntry = {}

function TextInputEntry.new(appState, icon, placeholder)
	local self = {}
	setmetatable(self, {__index = TextInputEntry})

	local size = 24
	local iconWidth = 0

	local listEntry = ListEntry.new(appState, HEIGHT)
	self.rbx = listEntry.rbx
	self.placeholder = placeholder

	if icon then
		iconWidth = ICON_CELL_WIDTH
		local iconImageLabel = Create.new"Frame" {
			Name = "Icon",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(0, iconWidth, 1, 0),
			Position = UDim2.new(0, 0, 0, 0),
			Create.new"ImageLabel" {
				Name = "IconImage",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, size, 0, size),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Image = icon,
				BorderSizePixel = 0,
			},
		}
		iconImageLabel.Parent = self.rbx
	end

	local textBox = Create.new"TextBox" {
		Name = "TextBox",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -iconWidth - CLEAR_TEXT_WIDTH, 1, 0),
		Position = UDim2.new(0, iconWidth, 0, 0),
		TextSize = 18,
		TextColor3 = Constants.Color.GRAY1,
		Font = Enum.Font.SourceSans,
		Text = "",
		PlaceholderText = placeholder or "",
		PlaceholderColor3 = Constants.Color.GRAY3,
		TextXAlignment = Enum.TextXAlignment.Left,
		OverlayNativeInput = true,
		ClearTextOnFocus = false,
		ClipsDescendants = true,
	}
	textBox.Parent = self.rbx

	local clearButton = Create.new"ImageButton"{
		Name = "Clear",
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 16, 0, 16),
		Position = UDim2.new(1, -CLEAR_TEXT_WIDTH/2, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		AutoButtonColor = false,
		Image = "rbxasset://textures/ui/LuaChat/icons/ic-clear-solid.png",
		ImageTransparency = 1,
	}
	clearButton.Parent = self.rbx

	clearButton.MouseButton1Click:Connect(function()
		textBox.Text = ""
	end)

	local divider = Create.new"Frame"{
		Name = "Divider",
		BackgroundColor3 = Constants.Color.GRAY4,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, 1, -1),
	}
	divider.Parent = self.rbx

	self.textBoxComponent = textBox
	self.value = textBox.Text
	self.textBoxChanged = Signal.new()

	local function updateClearButtonVisibility()
		-- If we were to set the visible property of the clear button on the textbox focus lost event
		-- it would disable the clear button, which in turn would stop the click event
		-- from being able to notify the button
		local visible = textBox:IsFocused() and (self.value ~= "")
		clearButton.ImageTransparency = visible and 0 or 1
	end

	textBox:GetPropertyChangedSignal("Text"):Connect(function()
		self.value = textBox.Text

		updateClearButtonVisibility()
		self.textBoxChanged:Fire(self.value)
	end)

	textBox.Focused:Connect(updateClearButtonVisibility)
	textBox.FocusLost:Connect(updateClearButtonVisibility)

	return self
end

function TextInputEntry:ShowDivider(show)
	self.rbx.Divider.Visible = show
end

function TextInputEntry:Update(value)
	if value ~= self.value then
		self.rbx.TextBox.Text = value
		if self.placeholder == nil and value ~= "" then
			self.placeholder = value
			self.rbx.TextBox.PlaceholderText = value
		end
	end
end

return TextInputEntry