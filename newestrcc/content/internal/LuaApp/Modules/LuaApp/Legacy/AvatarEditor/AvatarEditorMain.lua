local userInputService = game:GetService('UserInputService')
local sharedStorage = game:GetService('ReplicatedStorage')
local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:FindFirstChild("RobloxGui")
local Modules = RobloxGui.Modules

local AppState = require(Modules.LuaApp.Legacy.AvatarEditor.AppState)
local AppGui = require(Modules.LuaApp.Legacy.AvatarEditor.AppGui)
local AppScene = require(Modules.LuaApp.Legacy.AvatarEditor.AppScene)

local AvatarEditorScene = AppScene.RootScene

local CreateCharacterManager = require(Modules.LuaApp.Legacy.AvatarEditor.CharacterManager)
local ParticleScreen = require(Modules.LuaApp.Legacy.AvatarEditor.ParticleScreen)
local utilities = require(Modules.LuaApp.Legacy.AvatarEditor.Utilities)
local tween = require(Modules.LuaApp.Legacy.AvatarEditor.TweenInstanceController)

local spriteManager = require(Modules.LuaApp.Legacy.AvatarEditor.SpriteSheetManager)
local LayoutInfo = require(Modules.LuaApp.Legacy.AvatarEditor.LayoutInfo)
local categories = require(Modules.LuaApp.Legacy.AvatarEditor.Categories)
local Strings = require(Modules.LuaApp.Legacy.AvatarEditor.LocalizedStrings)

while not game:GetService('Players').LocalPlayer do wait() end


return { new = function(topOffset)
topOffset = topOffset or 0

local appGui = AppGui(
	UDim2.new(0, 0, 0,  topOffset),
	UDim2.new(1, 0, 1, -topOffset))

local camera = game.Workspace.CurrentCamera
local topFrame = appGui.RootGui:WaitForChild('TopFrame')
local mainFrame = appGui.RootGui:WaitForChild('Frame')
local scrollingFrame = mainFrame:WaitForChild('ScrollingFrame')
local equippedFrameTemplate = appGui.RootGui:WaitForChild('SelectionFrameTemplate')
local fakeScrollBar = mainFrame:WaitForChild('FakeScrollBar')
local detailsMenuFrame = appGui.RootGui:WaitForChild('DetailsFrame')

-- Add the gui into the renderable PlayerGui (this does not
-- happen automatically because characterAutoLoads is false)
local starterGuiChildren = game.StarterGui:GetChildren()
for i = 1, #starterGuiChildren do
	local guiClone = starterGuiChildren[i]:clone()
	guiClone.Parent = RobloxGui.Parent
end


scrollingFrame.ClipsDescendants = true
if LayoutInfo.isLandscape then
	scrollingFrame.Position = UDim2.new(0, 108, 0, 0)
	scrollingFrame.Size = UDim2.new(1, -111, 1, 0)
else
	scrollingFrame.Position = UDim2.new(0, 0, 0, 50)
	scrollingFrame.Size = UDim2.new(1, 0, 1, -50)
end


spriteManager.equipDescendants(appGui.RootGui)


if LayoutInfo.isLandscape then
	topFrame.Size = UDim2.new(0.5, 0, 1, 0)

	mainFrame.Position = UDim2.new(0.5, -60, 0, 0)
	mainFrame.Size = UDim2.new(0.5, 60, 1, 0)
	mainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
	mainFrame.BackgroundTransparency = 0.5

	scrollingFrame.Size = UDim2.new(1, -128, 1, 0)
	scrollingFrame.Position = UDim2.new(0, 116, 0, 0)

	detailsMenuFrame.BackgroundTransparency = 1
	detailsMenuFrame.ClipsDescendants = false
	detailsMenuFrame.Background.Visible = true

	AvatarEditorScene.Model.Unions.BaseCylinder.BillboardGui.TextLabel.Size = UDim2.new(0.3, 0, 1, 0)
	AvatarEditorScene.Model.Unions.BaseCylinder.BillboardGui.TextLabel.Position = UDim2.new(0.5, 0, 0, 0)
end


local function GetNameValue(playerName)
	local value = 0
	for index = 1, #playerName do
		local cValue = string.byte(string.sub(playerName, index, index))
		local reverseIndex = #playerName - index + 1
		if #playerName%2 == 1 then
			reverseIndex = reverseIndex - 1
		end
		if reverseIndex%4 >= 2 then
			cValue = -cValue
		end
		value = value + cValue
	end
	return value
end


local characterManager = CreateCharacterManager(
	{
		get = function(url)
			return utilities.httpGet(url)
		end;

		post = function(url, data)
			return utilities.httpPost(url, data)
		end;
	},
	{
		CharacterR6 = sharedStorage:WaitForChild('CharacterR6');
		CharacterR15 = sharedStorage:WaitForChild('CharacterR15');
	},
	GetNameValue(game.Players.LocalPlayer.Name)+1
)


local warningIsOpen = false
local currentWarning = 0


local function closeWarning()
	if not warningIsOpen then return end
	warningIsOpen = false

	utilities.fastSpawn(function()
		local tweenInfo = TweenInfo.new(0.3)
		local textTweenInfo = TweenInfo.new(0.1)

		currentWarning = currentWarning + 1

		tween(topFrame.Warning.WarningText, textTweenInfo, { TextTransparency = 1 })

		tween(topFrame.Warning, tweenInfo, {
			Size = UDim2.new(0, 70, 0, 70);
			Position = UDim2.new(0.5, -35, 0.5, -35);
		})
		tween(topFrame.Warning.WarningIcon, tweenInfo, { Position = UDim2.new(0.5, -24, 0.5, -24) })
		tween(topFrame.Warning.WarningIcon, tweenInfo, { ImageTransparency = 1 })
		tween(topFrame.Warning.BackgroundFill, tweenInfo, { ImageTransparency = 1 })
		tween(topFrame.Warning.RoundedEnd, tweenInfo, { ImageTransparency = 1 })
		tween(topFrame.Warning.RoundedStart, tweenInfo, { ImageTransparency = 1 })
	end)
end


local function resetWarning()
	topFrame.Warning.WarningText.TextTransparency = 1
	topFrame.Warning.Size = UDim2.new(0, 70, 0, 70)
	topFrame.Warning.Position = UDim2.new(0.5, -35, 0.5, -35)
	topFrame.Warning.WarningIcon.Position = UDim2.new(0.5, -24, 0.5, -24)
	topFrame.Warning.WarningIcon.ImageTransparency = 1
	topFrame.Warning.BackgroundFill.ImageTransparency = 1
	topFrame.Warning.RoundedEnd.ImageTransparency = 1
	topFrame.Warning.RoundedStart.ImageTransparency = 1
end


local function displayWarning(text, displayTime) -- No displayTime = infinite
	warningIsOpen = true

	utilities.fastSpawn(function()
		topFrame.Warning.Visible = true
		resetWarning()

		local thisWarning = currentWarning + 1
		currentWarning = thisWarning

		local t = 0.3

		topFrame.Warning.WarningText.TextTransparency = 1

		local tweenInfo = TweenInfo.new(t)

		local warningGoals = {
			Size = UDim2.new(0, 266, 0, 70);
			Position = UDim2.new(0.5, -133, 0.5, -35);
		}
		tween(topFrame.Warning, tweenInfo, warningGoals)

		local warningIconGoals = {
			Rotation = -360;
			ImageTransparency = 0;
			Position = UDim2.new(0, 12, 0.5, -24);
		}
		local warningIconStarts = {
			Rotation = 0;
			ImageTransparency = 1;
		}
		tween(topFrame.Warning.WarningIcon, tweenInfo, warningIconGoals, warningIconStarts)

		local backgroundGoals = {
			ImageTransparency = 0.25
		}
		local backgroundStarts = {
			ImageTransparency = 1
		}
		tween(topFrame.Warning.BackgroundFill, tweenInfo, backgroundGoals, backgroundStarts)
		tween(topFrame.Warning.RoundedEnd, tweenInfo, backgroundGoals, backgroundStarts)
		tween(topFrame.Warning.RoundedStart, tweenInfo, backgroundGoals, backgroundStarts)

		topFrame.Warning.WarningText.Text = text or Strings:LocalizedString("ErrorWarningPhrase")

		wait(t)

		if thisWarning ~= currentWarning then return end

		local textGoals = {
			TextTransparency = 0
		}
		local textStarts = {
			TextTransparency = 1
		}
		tween(topFrame.Warning.WarningText, tweenInfo, textGoals, textStarts)

		if thisWarning ~= currentWarning then return end

		if displayTime then
			wait(displayTime)
			if thisWarning == currentWarning then
				closeWarning()
			end
		end
	end)
end


characterManager.setDisplayWarningCallbacks(
	displayWarning,
	closeWarning
)

local function updateViewMode(desiredViewMode)
	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0)
	if desiredViewMode then
		if LayoutInfo.isLandscape then
			tween(mainFrame, tweenInfo, { Position = UDim2.new(1, 0, 0, 0) })
			tween(topFrame, tweenInfo, { Size = UDim2.new(1, 0, 1, 0) })
		else
			tween(mainFrame, tweenInfo, { Position = UDim2.new(0, 0, 1, 0) })
			tween(topFrame, tweenInfo, { Size = UDim2.new(1, 0, 1, 0) })
		end
	else
		if LayoutInfo.isLandscape then
			tween(mainFrame, tweenInfo, { Position = UDim2.new(0.5, -60, 0, 0) })
			tween(topFrame, tweenInfo, { Size = UDim2.new(0.5, 0, 1, 0) })
		else
			tween(mainFrame, tweenInfo, { Position = UDim2.new(0, 0, .5, -18) })
			tween(topFrame, tweenInfo, { Size = UDim2.new(1, 0, 0.5, -18) })
		end
	end
end


ParticleScreen.init()

require(Modules.LuaApp.Legacy.AvatarEditor.Header).new("Avatar").rbx.Parent = appGui.RootGui

require(Modules.LuaApp.Legacy.AvatarEditor.AvatarTypeSwitch)(
	appGui.RootGui:WaitForChild('AvatarTypeSwitch'))

characterManager.initFromServer()


local longPressMenu = require(Modules.LuaApp.Legacy.AvatarEditor.LongPressMenu)(
	characterManager,
	appGui.RootGui:WaitForChild('ShadeLayer'),
	appGui.RootGui:WaitForChild('MenuFrame'),
	appGui.RootGui:WaitForChild('DetailsFrame')
)

require(Modules.LuaApp.Legacy.AvatarEditor.AccessoriesColumn)(
	appGui.RootGui:WaitForChild('AccessoriesColumn'), longPressMenu)

local PageManager = require(Modules.LuaApp.Legacy.AvatarEditor.PageManager)(
	game.Players.LocalPlayer.userId,
	equippedFrameTemplate,
	scrollingFrame,
	characterManager,
	longPressMenu)

local categoryButtonTemplate = LayoutInfo.isLandscape and appGui.RootGui:WaitForChild('TabletCategoryButtonTemplate') or
	appGui.RootGui:WaitForChild('CategoryButtonTemplate')
local CategoryMenu = require(Modules.LuaApp.Legacy.AvatarEditor.CategoryMenu)(
	mainFrame:WaitForChild('TopMenuContainer'),
	categoryButtonTemplate)

require(Modules.LuaApp.Legacy.AvatarEditor.DarkCoverManager)(
	appGui.RootGui:WaitForChild('DarkCover'), CategoryMenu)

require(Modules.LuaApp.Legacy.AvatarEditor.TabList)(CategoryMenu, PageManager,
	mainFrame:WaitForChild('TabList'),
	mainFrame:WaitForChild('TabListContainer'))


local cameraController = require(Modules.LuaApp.Legacy.AvatarEditor.CameraController)

camera.CameraType = Enum.CameraType.Scriptable
camera.CFrame = LayoutInfo.CameraDefaultCFrame
camera.FieldOfView = 70

PageManager:setUpdateCameraCallback(cameraController.updatePageCamera)

cameraController.init(
	AppState.Store,
	{
		tweenCamera = function(targetCFrame, targetFOV)
			local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0)
			local propGoals = {
				CFrame = targetCFrame;
				FieldOfView = targetFOV;
			}
			tween(camera, tweenInfo, propGoals)
		end
	},
	LayoutInfo.CameraCenterScreenPosition
)


--This function fades the fake scrollbar out after not being used for 3 seconds
local lastScrollPosition = fakeScrollBar.AbsolutePosition.Y
local lastScrollCount = 0
local function updateScrollBarVisibility()
	local thisScrollPosition = fakeScrollBar.AbsolutePosition.Y
	if thisScrollPosition ~= lastScrollPosition then
		lastScrollPosition = thisScrollPosition

		lastScrollCount = lastScrollCount + 1
		local thisScrollCount = lastScrollCount

		fakeScrollBar.ImageTransparency = .65
		wait(2)
		if thisScrollCount == lastScrollCount then
			local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0)
			tween(fakeScrollBar, tweenInfo, { ImageTransparency = 1 }).Completed:wait()
		end
	end
end

local fakeScrollBarWidth = 4

scrollingFrame.Changed:connect(function(prop)
	local barSize = 0
	local scrollingFrameSize = scrollingFrame.AbsoluteSize.Y
	local canvasPosition = scrollingFrame.CanvasPosition.Y
	local canvasSize = scrollingFrame.CanvasSize.Y.Offset
	if scrollingFrameSize < canvasSize then
		barSize = (scrollingFrameSize / canvasSize) * scrollingFrameSize
	end
	if barSize > 0 then
		fakeScrollBar.Visible = true
		fakeScrollBar.Size = UDim2.new(0,fakeScrollBarWidth,0,barSize)
		local scrollPercent = canvasPosition/(canvasSize-scrollingFrameSize)
		fakeScrollBar.Position =
			UDim2.new( 1, -fakeScrollBarWidth, 0, (scrollingFrameSize-barSize) * scrollPercent )
				+ scrollingFrame.Position
	else
		fakeScrollBar.Visible = false
	end

	utilities.fastSpawn(updateScrollBarVisibility)

	if prop == 'CanvasPosition' then
		PageManager:updateListContent(canvasPosition)
	end
end)


AppState.Store.Changed:Connect(function(newState, oldState)
	if newState.FullView ~= oldState.FullView then
		updateViewMode(newState.FullView)
	end

	if newState.Category.CategoryIndex ~= oldState.Category.CategoryIndex
		or newState.Category.TabsInfo ~= oldState.Category.TabsInfo
		or newState.Character.AvatarType ~= oldState.Character.AvatarType then

		local categoryIndex = newState.Category.CategoryIndex
		local tabInfo = categoryIndex and newState.Category.TabsInfo[categoryIndex]
		local tabIndex = tabInfo and tabInfo.TabIndex or 1
		local desiredPage = categories[categoryIndex].pages[tabIndex]

		if desiredPage.r15only and newState.Character.AvatarType == 'R6' then
			displayWarning(desiredPage.r15onlyMessage or Strings:LocalizedString("R15OnlyPhrase"))
		else
			closeWarning()
		end
	end
end)



local SetAvatarEditorFullView = require(Modules.LuaApp.Actions.SetAvatarEditorFullView)

local function setViewMode(desiredViewMode)
	if desiredViewMode ~= AppState.Store:GetState().FullView then
		AppState.Store:Dispatch(SetAvatarEditorFullView(desiredViewMode))
	end
end

local rotation = 0
local lastRotation = 0
local downKeys = {}
local lastTouchInput = nil
local lastTouchPosition = nil
local lastInputBeganPosition = Vector3.new(0,0,0)
local lastEmptyInput = 0
local characterRotationSpeed = .0065
local tapDistanceThreshold = 10 -- maximum distance between input begin and end for it to count as a tap
local doubleTapThreshold = .25

local function handleInput(input, soaked)
	if input.UserInputState == Enum.UserInputState.Begin then
		downKeys[input.KeyCode] = true
		if not soaked then

			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				downKeys[Enum.UserInputType.MouseButton1] = true
				lastTouchPosition = input.Position
				lastTouchInput = input
			end
			if input.UserInputType == Enum.UserInputType.Touch then
				lastTouchInput = input
				lastTouchPosition = input.Position
			end

			if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
				--This is used for doubletap detection
				lastInputBeganPosition = input.Position
			end

			if input.KeyCode == Enum.KeyCode.ButtonR3 then
				characterManager.playLookAround()
			end

		end
	elseif input.UserInputState == Enum.UserInputState.End then
		downKeys[input.KeyCode] = false
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			downKeys[Enum.UserInputType.MouseButton1] = false
		end
		if lastTouchInput == input or input.UserInputType == Enum.UserInputType.MouseButton1 then
			lastTouchInput = nil
		end

		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			if (lastInputBeganPosition and lastInputBeganPosition - input.Position).magnitude <= tapDistanceThreshold then
				local thisEmptyInput = tick()
				if thisEmptyInput - lastEmptyInput <= doubleTapThreshold then
					setViewMode(not AppState.Store:GetState().FullView)
				end
				lastEmptyInput = thisEmptyInput
			end
		end
	elseif input.UserInputState == Enum.UserInputState.Change then
		if (lastTouchInput == input and input.UserInputType == Enum.UserInputType.Touch)
			or (input.UserInputType == Enum.UserInputType.MouseMovement and downKeys[Enum.UserInputType.MouseButton1]) then

			local touchDelta = (input.Position - lastTouchPosition)
			lastTouchPosition = input.Position
			rotation = rotation + touchDelta.x * characterRotationSpeed
		end
	end
end

userInputService.InputBegan:connect(handleInput)
userInputService.InputChanged:connect(handleInput)
userInputService.InputEnded:connect(handleInput)

userInputService.TouchSwipe:connect(function(swipeDirection, numberOfTouches, soaked)
	if not soaked and not LayoutInfo.isLandscape then
		if AppState.Store:GetState().FullView and swipeDirection == Enum.SwipeDirection.Up then
			setViewMode(false)
		elseif not AppState.Store:GetState().FullView and swipeDirection == Enum.SwipeDirection.Down then
			setViewMode(true)
		end
	end
end)

local function onLastInputTypeChanged(inputType)
	local isGamepad = inputType.Name:find('Gamepad')
	local isTouch = inputType == Enum.UserInputType.Touch
	local isMouse = inputType.Name:find('Mouse') or inputType == Enum.UserInputType.Keyboard

	if not isGamepad and not isTouch and not isMouse then
		return
	end

	if isGamepad then
		userInputService.MouseIconEnabled = false
	else
		userInputService.MouseIconEnabled = true
	end
end

userInputService.LastInputTypeChanged:connect(onLastInputTypeChanged)
onLastInputTypeChanged(userInputService:GetLastInputType())

local function lockPart(part)
	if part:IsA('BasePart') then
		part.Locked = true
	end
end

game.Workspace.DescendantAdded:connect(lockPart)
for _, v in next, utilities.getDescendants(game.Workspace) do
	lockPart(v)
end

utilities.fastSpawn(function()
	while true do
		wait(5)
		characterManager.characterSave()	--Don't worry, it only saves changes
	end
end)

game.OnClose = function()
	characterManager.characterSave(true)
end

require(Modules.LuaApp.Legacy.AvatarEditor.FullView)(
	topFrame:WaitForChild('FullViewButton'))



characterManager.recalculateRestingPartOffsets()


local rotationalInertia = .9

spawn(function()
	local rotationalMomentum = 0
	local ranOnce = false
	while true do
		local delta = 0
		if ranOnce then
			delta = utilities.renderWait()
		end
		local tilt = 0
		local offsetTheseRots = 0

		if downKeys[Enum.KeyCode.Left] or downKeys[Enum.KeyCode.A] then
			rotation = rotation - delta*math.rad(180)
		elseif downKeys[Enum.KeyCode.Right] or downKeys[Enum.KeyCode.D] then
			rotation = rotation + delta*math.rad(180)
		end

		if userInputService.GamepadEnabled then
			for _, gamepad in next, userInputService:GetNavigationGamepads() do
				local state = userInputService:GetGamepadState(gamepad)

				for _, obj in next, state do
					if obj.KeyCode == Enum.KeyCode.Thumbstick2 then
						if math.abs(obj.Position.x) > 0.25 then
							local deltaRotation = obj.Position.x*delta*math.rad(180)
							rotation = rotation + deltaRotation
							if userInputService.TouchEnabled or userInputService.MouseEnabled then
								offsetTheseRots = offsetTheseRots - deltaRotation
							end
						end
						if math.abs(obj.Position.y) > 0.25 then
							tilt = tilt + obj.Position.y*math.rad(45)
						end
					end
				end
			end
		end

		if lastTouchInput then
			rotationalMomentum = rotation - lastRotation
		elseif rotationalMomentum ~= 0 then
			rotationalMomentum = rotationalMomentum * rotationalInertia
			if math.abs(rotationalMomentum) < .001 then
				rotationalMomentum = 0
			end
			rotation = rotation + rotationalMomentum
		end

		characterManager.setRotation(rotation)
		lastRotation = rotation

		if not ranOnce then
			characterManager.refreshCharacterScale()
			ranOnce = true
		end
	end
end)

	local AppMain = {}

	function AppMain:Start()
		appGui.ScreenGui.Parent = CoreGui
		appGui.EdgeShadingGui.Parent = CoreGui
		AvatarEditorScene.Parent = game.Workspace
		characterManager.show()
	end

	function AppMain:Stop()
		appGui.ScreenGui.Parent = nil
		appGui.EdgeShadingGui.Parent = nil
		AvatarEditorScene.Parent = nil
		characterManager.hide()
	end

	return AppMain;

end }
