--[[r
		Filename: Record.lua
		Written by: jeditkacheff
		Version 1.0
		Description: Takes care of the Record Tab in Settings Menu
--]]
-------------- SERVICES --------------
local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GuiService = game:GetService("GuiService")
local Settings = UserSettings()
local GameSettings = Settings.GameSettings

----------- UTILITIES --------------
local utility = require(RobloxGui.Modules.Utility)

------------ Variables -------------------
local PageInstance = nil

----------- CLASS DECLARATION --------------

local function Initialize()
	local settingsPageFactory = require(RobloxGui.Modules.Settings.SettingsPageFactory)
	local this = settingsPageFactory:CreateNewPage()
	local isRecordingVideo = false

	local recordingEvent = Instance.new("BindableEvent")
	recordingEvent.Name = "RecordingEvent"
	this.RecordingChanged = recordingEvent.Event
	function this:IsRecording()
		return isRecordingVideo
	end
	
	------ TAB CUSTOMIZATION -------
	this.TabHeader.Name = "RecordTab"

	this.TabHeader.Icon.Image = "rbxasset://textures/ui/Settings/MenuBarIcons/RecordTab.png"
	this.TabHeader.Icon.Size = UDim2.new(0,41,0,40)
	this.TabHeader.Icon.Position = UDim2.new(0,5,0.5,-20)

	this.TabHeader.Icon.Title.Text = "Record"

	this.TabHeader.Size = UDim2.new(0,130,1,0)


	------ PAGE CUSTOMIZATION -------
	this.Page.Name = "Record"

	local function makeTextLabel(name, text, bold, size, pos, parent)
		local textLabel = utility:Create'TextLabel'
		{
			Name = name,
			BackgroundTransparency = 1,
			Text = text,
			TextWrapped = true,
			Font = Enum.Font.SourceSans,
			FontSize = Enum.FontSize.Size24,
			TextColor3 = Color3.new(1,1,1),
			Size = size,
			Position = pos,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			ZIndex = 2,
			Parent = parent
		};
		if bold then textLabel.Font = Enum.Font.SourceSansBold end

		return textLabel
	end

	-- need to override this function from SettingsPageFactory
	-- DropDown menus require hub to to be set when they are initialized
	function this:SetHub(newHubRef)
		this.HubRef = newHubRef

		local recordEnumNames = {}
		recordEnumNames[1] = "Save To Disk"
		recordEnumNames[2] = "Upload to YouTube"

		local startSetting = 2
		if GameSettings.VideoUploadPromptBehavior == Enum.UploadSetting["Never"] then
			startSetting = 1
		end

		---------------------------------- SCREENSHOT -------------------------------------
		local screenshotTitle = makeTextLabel("ScreenshotTitle", 
												"Screenshot",
												true, UDim2.new(1,0,0,36), UDim2.new(0,10,0.05,0), this.Page)
		screenshotTitle.FontSize = Enum.FontSize.Size36

		local screenshotBody = makeTextLabel("ScreenshotBody", 
												"By clicking the 'Take Screenshot' button, the menu will close and take a screenshot and save it to your computer.",
												false, UDim2.new(1,-10,0,70), UDim2.new(0,0,1,0), screenshotTitle)

		local closeSettingsFunc = function()
			this.HubRef:SetVisibility(false, true)
		end
		this.ScreenshotButton = utility:MakeStyledButton("ScreenshotButton", "Take Screenshot", UDim2.new(0,300,0,44), closeSettingsFunc)
		
		this.ScreenshotButton.Position = UDim2.new(0,400,1,0)
		this.ScreenshotButton.Parent = screenshotBody


		---------------------------------- VIDEO -------------------------------------
		local videoTitle = makeTextLabel("VideoTitle", 
												"Video",
												true, UDim2.new(1,0,0,36), UDim2.new(0,10,0.5,0), this.Page)
		videoTitle.FontSize = Enum.FontSize.Size36

		local videoBody = makeTextLabel("VideoBody", 
												"By clicking the 'Record Video' button, the menu will close and start recording your screen.",
												false, UDim2.new(1,-10,0,70), UDim2.new(0,0,1,0), videoTitle)

		this.VideoSettingsFrame, 
		this.VideoSettingsLabel,
		this.VideoSettingsMode = utility:AddNewRow(this, "Video Settings", "Selector", recordEnumNames, startSetting, 270)

		this.VideoSettingsMode.IndexChanged:connect(function(newIndex)
			if newIndex == 1 then
				GameSettings.VideoUploadPromptBehavior = Enum.UploadSetting.Never
			elseif newIndex == 2 then
				GameSettings.VideoUploadPromptBehavior = Enum.UploadSetting.Always
			end
		end)


		local recordButton = utility:MakeStyledButton("RecordButton", "Record Video", UDim2.new(0,300,0,44), closeSettingsFunc)
		
		recordButton.Position = UDim2.new(0,410,1,10)
		recordButton.Parent = this.VideoSettingsMode.SelectorFrame.Parent
		recordButton.MouseButton1Click:connect(function()
			isRecordingVideo = not isRecordingVideo
			if isRecordingVideo then
				recordButton.RecordButtonTextLabel.Text = "Stop Recording"
			else
				recordButton.RecordButtonTextLabel.Text = "Record Video"
			end
			recordingEvent:Fire(isRecordingVideo)
		end)



		recordButton:SetVerb("RecordToggle")
		this.ScreenshotButton:SetVerb("Screenshot")

		this.Page.Size = UDim2.new(1,0,0,400)
	end

	return this
end


----------- Public Facing API Additions --------------
PageInstance = Initialize()

PageInstance.Displayed.Event:connect(function()
	GuiService.SelectedCoreObject = PageInstance.ScreenshotButton
end)


return PageInstance