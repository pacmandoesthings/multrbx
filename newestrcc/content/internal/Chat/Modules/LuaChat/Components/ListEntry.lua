local function findAncestor(child, name)
	local parent = child.Parent
	while parent and parent.Name ~= name do
		parent = parent.Parent
	end
	return parent
end

local LuaChat = findAncestor(script, "LuaChat")
local Signal = require(LuaChat.Signal)
local Create = require(LuaChat.Create)
local Constants = require(LuaChat.Constants)

local ListEntry = {}

ListEntry.__index = ListEntry

function ListEntry.new(appState, height)
	local self = {}
	self.rbx = Create.new"TextButton" {
		Name = "Entry",
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		BackgroundColor3 = Constants.Color.WHITE,
		Size = UDim2.new(1, 0, 0, height),
		AutoButtonColor = false,
		Text = "",
	}

	self.tapped = Signal.new()

	local beginningInput = nil
	local function onInputBegan(input)
		if input.UserInputType ~= Enum.UserInputType.Touch or
			(input.UserInputState ~= Enum.UserInputState.Begin and input ~= beginningInput) then
			return
		end
		beginningInput = input
		self.rbx.BackgroundColor3 = Constants.Color.GRAY5
		return
	end

	local function onInputEnded(input, processed)
		if input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		beginningInput = nil
		self.rbx.BackgroundColor3 = Constants.Color.WHITE
		return
	end

	self.rbx.InputBegan:Connect(onInputBegan)
	self.rbx.InputEnded:Connect(onInputEnded)

	self.rbx.MouseButton1Click:connect(function()
		self.tapped:Fire()
	end)

	return self
end

return ListEntry