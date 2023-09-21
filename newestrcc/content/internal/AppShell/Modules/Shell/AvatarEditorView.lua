-------------- CONSTANTS --------------
local STICK_ROTATION_MULTIPLIER = 3
local THUMBSTICK_DEADZONE = 0.2

-------------- SERVICES --------------
local UserInputService = game:GetService('UserInputService')
local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')
local CoreGui = game:GetService('CoreGui')

------------ MODULES -------------------
local GuiRoot = CoreGui:FindFirstChild('RobloxGui')
local Modules = GuiRoot:FindFirstChild('Modules')

local AppState = require(Modules.LuaApp.Legacy.AvatarEditor.AppState)
local ToggleAvatarType = require(Modules.LuaApp.Actions.ToggleAvatarType)
local ToggleAvatarEditorFullView = require(Modules.LuaApp.Actions.ToggleAvatarEditorFullView)

local CreateCharacterManager = require(Modules.LuaApp.Legacy.AvatarEditor.CharacterManager)
local CreatePageManager = require(Modules.LuaApp.Legacy.AvatarEditor.PageManagerConsole)
local CreateCategoryMenu = require(Modules.LuaApp.Legacy.AvatarEditor.CategoryMenuConsole)
local CreateTabList = require(Modules.LuaApp.Legacy.AvatarEditor.TabListConsole)
local ConsoleButtonIndicators = require(Modules.LuaApp.Legacy.AvatarEditor.ConsoleButtonIndicators)
local LayoutInfo = require(Modules.LuaApp.Legacy.AvatarEditor.LayoutInfoConsole)

----------- UTILITIES --------------
local Utilities = require(Modules.LuaApp.Legacy.AvatarEditor.Utilities)
local TableUtilities = require(Modules.LuaApp.TableUtilities)

------------ SHELL MODULES -------------------
local ShellModules = script.Parent
local UserData = require(ShellModules:FindFirstChild('UserData'))
local CameraManager = require(ShellModules:FindFirstChild('CameraManager'))
local Utility = require(ShellModules:FindFirstChild('Utility'))
local EventHub = require(ShellModules:FindFirstChild('EventHub'))
local LoadingWidget = require(ShellModules:FindFirstChild('LoadingWidget'))

------------ VARIABLES -------------------
local characterTemplates = {}

local UseNewAppShellPlace = Utility.IsFeatureNonZero("XboxAvatarEditorRolloutPercent")

if UseNewAppShellPlace then
	characterTemplates.CharacterR6 = ReplicatedStorage:WaitForChild('CharacterR6')
	characterTemplates.CharacterR15 = ReplicatedStorage:WaitForChild('CharacterR15')
end


local cameraTweenerObject = {
	tweenCamera = function(newCFrame, newFOV)
		CameraManager:UpdateAvatarEditorCamera(newCFrame, newFOV)
	end
}

----------- CLASS DECLARATION --------------

local function createAvatarEditorView()
	AppState:Init()
	local this = {}
	local storeChangedCn = nil
	local scrollingFrameCn = nil
	local avatarEditorLoader = nil
	local savedSelectedGuiObject = nil
	local selectedGuiObjectEnterFullView = nil
	local toggleButtonDebounce = true
	local toggleViewDebounce = true
	local showCount = 0
	local inShow = false
	local inFocus = false
	local lastCharacterSaveTime = nil

	local characterUpdated = false
	local characterEquipped = false
	local savingAvatarMutex = false
	local rotationInfo = {
		rotation = 0;
		lastRotation = 0;
		delta = 0;
	}

	local Container = Utilities.create'ScrollingFrame'
	{
		Name = 'AvatarEditorContainer';
		Size = UDim2.new(1, 0, 1, 0);
		CanvasSize = UDim2.new(1, 0, 1, 0);
		BackgroundTransparency = 1;
		ScrollingEnabled = false;
		Selectable = false;
		Visible = true;
		BorderSizePixel = 0;
		ScrollBarThickness = 0;
	}

	local BackgroundOverlay = Utilities.create'ImageLabel'
	{
		Name = 'BackgroundOverlay';
		Size = UDim2.new(1, 0, 1, 0);
		BackgroundTransparency = 1;
		Visible = true;
		Image = 'rbxasset://textures/ui/Shell/AvatarEditor/graphic/gr-background overlay.png';
		ZIndex = LayoutInfo.BackgroundLayer;
		Parent = Container;
	}

	local scrollingFrame = Utilities.create'ScrollingFrame'
	{
		AnchorPoint = Vector2.new(1, 0);
		Position = UDim2.new(1, -99, 0, 270);
		Size = UDim2.new(0, 491, 1, -270);
		Name = "ScrollingFrame";
		BackgroundTransparency = 1;
		ClipsDescendants = true;
		Visible = true;
		ScrollingEnabled = false;
		ScrollBarThickness = 0;
		Selectable = false;
		ZIndex = LayoutInfo.BasicLayer;
		Parent = Container;
	}

	local equippedFrameTemplate = Utilities.create'ImageLabel'
	{
		Size = UDim2.new(1, 0, 1, 0);
		BackgroundTransparency = 1;
		BorderSizePixel = 0;
		Name = 'EquippedFrameTemplate';
		Image = 'rbxasset://textures/ui/Shell/AvatarEditor/graphic/gr-wearing indicator.png';
	}

	ConsoleButtonIndicators.init(Container)

	local BottomOverlay = Utilities.create'ImageLabel'
	{
		Name = 'BottomOverlay';
		AnchorPoint = Vector2.new(0, 1);
		Position = UDim2.new(0, 0, 1, 0);
		Size = UDim2.new(1, 0, 0, 190);
		BackgroundTransparency = 1;
		Visible = true;
		Image = 'rbxasset://textures/ui/Shell/AvatarEditor/graphic/gr-bottom overlay.png';
		ZIndex = LayoutInfo.ShadingOverlayLayer;
		Parent = Container;
	}

	local function initStickRotation()
		local gamepadInput = Vector2.new(0, 0)
		ContextActionService:UnbindCoreAction("StickRotation")
		ContextActionService:BindCoreAction("StickRotation", function(actionName, inputState, inputObject)
			if inputState == Enum.UserInputState.Change then
				gamepadInput = inputObject.Position or gamepadInput
				gamepadInput = Vector2.new(gamepadInput.X, gamepadInput.Y)
				if math.abs(gamepadInput.X) > THUMBSTICK_DEADZONE then
					rotationInfo.delta = STICK_ROTATION_MULTIPLIER * gamepadInput.X
				else
					rotationInfo.delta = 0
				end
			end
		end,
		false, Enum.KeyCode.Thumbstick2)
	end

	local function initKeyControls()
		toggleButtonDebounce = true
		toggleViewDebounce = true
		ContextActionService:UnbindCoreAction("KeyControls")
		ContextActionService:BindCoreAction("KeyControls", function(actionName, inputState, inputObject)
			if inputState == Enum.UserInputState.Begin then
				if inputObject.KeyCode == Enum.KeyCode.ButtonSelect and not AppState.Store:GetState().FullView then
					if toggleButtonDebounce then
						toggleButtonDebounce = false
						AppState.Store:Dispatch(ToggleAvatarType())
						toggleButtonDebounce = true
					end
				end

				if inputObject.KeyCode == Enum.KeyCode.ButtonR3 then
					if toggleViewDebounce then
						toggleViewDebounce = false
						AppState.Store:Dispatch(ToggleAvatarEditorFullView())
						toggleViewDebounce = true
					end
				end
			end
		end,
		false, Enum.KeyCode.ButtonR3, Enum.KeyCode.ButtonSelect)
	end

	local function updateFullViewCoreAction(fullView)
		ContextActionService:UnbindCoreAction("FullView")
		if fullView == true then
			ContextActionService:BindCoreAction("FullView",
				function(actionName, inputState, inputObject)
					if inputState == Enum.UserInputState.End then
						if inputObject.KeyCode == Enum.KeyCode.ButtonB then
							AppState.Store:Dispatch(ToggleAvatarEditorFullView())
						end
						return Enum.ContextActionResult.Sink
					end
				end,
				false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonA)

			BackgroundOverlay.Visible = false
			BottomOverlay.Visible = false
		elseif fullView == false then
			BackgroundOverlay.Visible = true
			BottomOverlay.Visible = true
		end
	end

	local cameraController = require(Modules.LuaApp.Legacy.AvatarEditor.CameraController)
	cameraController.init(AppState.Store, cameraTweenerObject, LayoutInfo.CameraCenterScreenPosition)

	local characterManager = CreateCharacterManager(
		{
			get = Utilities.httpGet;
			post = Utilities.httpPost;
		},
		characterTemplates,
		1
	)

	local PageManager = CreatePageManager(
		UserData:GetRbxUserId(),
		equippedFrameTemplate,
		scrollingFrame,
		characterManager
	)
	if cameraController.updatePageCamera then
		PageManager:setUpdateCameraCallback(cameraController.updatePageCamera)
	end
	local CategoryMenu = CreateCategoryMenu(Container)
	local TabList = CreateTabList(Container, CategoryMenu, PageManager)


	local function FocusAll()
		initStickRotation()
		initKeyControls()

		CategoryMenu:Focus()
		TabList:Focus()
		PageManager:Focus()

		if not savedSelectedGuiObject and not AppState.Store:GetState().FullView then
			CategoryMenu.selectCurrentCategory()
		elseif savedSelectedGuiObject then
			Utilities.setSelectedCoreObject(savedSelectedGuiObject)
		end
		updateFullViewCoreAction(AppState.Store:GetState().FullView)

		storeChangedCn = AppState.Store.Changed:Connect(function(newState, oldState)
			if newState.FullView ~= oldState.FullView then
				updateFullViewCoreAction(newState.FullView)
				if newState.FullView == true then
					local selectedCoreObject = Utilities.getSelectedCoreObject()
					if selectedCoreObject then
						selectedGuiObjectEnterFullView = selectedCoreObject
					end
					Utilities.setSelectedCoreObject(nil)
				else
					if selectedGuiObjectEnterFullView then
						Utilities.setSelectedCoreObject(selectedGuiObjectEnterFullView)
					end
				end
			end

			if not characterEquipped or not characterUpdated then
				local didUpdate = false
				local didEquip = false

				if newState.Character.AvatarType ~= oldState.Character.AvatarType then
					didUpdate = true
				end

				if newState.Character.Assets ~= oldState.Character.Assets then
					for assetType, assetList in pairs(oldState.Character.Assets) do
						if not newState.Character.Assets[assetType] and assetList then
							if next(assetList) ~= nil then
								didUpdate = true
								didEquip = true
								break
							end
						end
					end

					if not didUpdate or not didEquip then
						for assetType, _ in pairs(newState.Character.Assets) do
							if newState.Character.Assets[assetType] ~= oldState.Character.Assets[assetType] then
								local addTheseAssets = TableUtilities.ListDifference(
										newState.Character.Assets[assetType] or {},
										oldState.Character.Assets[assetType] or {})
								local removeTheseAssets =
									TableUtilities.ListDifference(oldState.Character.Assets[assetType] or {},
									newState.Character.Assets[assetType] or {})

								if next(addTheseAssets) ~= nil or next(removeTheseAssets) ~= nil then
									didUpdate = true
									didEquip = true
									break
								end
							end
						end
					end
				end

				if newState.Character.BodyColors ~= oldState.Character.BodyColors then
					local differentBodyColors =
						TableUtilities.TableDifference(newState.Character.BodyColors, oldState.Character.BodyColors)
					if next(differentBodyColors) ~= nil then
						didUpdate = true
					end
				end

				if newState.Character.Scales ~= oldState.Character.Scales then
					local differentScales =
						TableUtilities.TableDifference(newState.Character.Scales, oldState.Character.Scales)
					if next(differentScales) ~= nil then
						didUpdate = true
					end
				end

				if not characterEquipped then
					characterEquipped = didEquip
				end

				if not characterUpdated then
					characterUpdated = didUpdate
				end
			end
		end)

		scrollingFrameCn = scrollingFrame.Changed:connect(
			function(prop)
				if prop == 'CanvasPosition' then
					PageManager:updateListContent(scrollingFrame.CanvasPosition.Y)
				end
			end
		)
	end

	local function RemoveFocusAll()
		PageManager:RemoveFocus()
		CategoryMenu:RemoveFocus()
		TabList:RemoveFocus()
		Utilities.disconnectEvent(storeChangedCn)
		Utilities.disconnectEvent(scrollingFrameCn)
		ContextActionService:UnbindCoreAction("FullView")
		ContextActionService:UnbindCoreAction("StickRotation")
		ContextActionService:UnbindCoreAction("KeyControls")
	end

	function this:Show(parent)
		local startCount = showCount
		inShow = true
		characterUpdated = false
		characterEquipped = false
		local prevAvatarEditorLoader = avatarEditorLoader

		Utilities.fastSpawn(function()
			if startCount == showCount then
				avatarEditorLoader = LoadingWidget(
					{Parent = parent},
					{function()
						if prevAvatarEditorLoader then
							prevAvatarEditorLoader:AwaitFinished()
							prevAvatarEditorLoader:Cleanup()
						end
						if startCount == showCount then
							characterManager.updateAvatarType()
							characterManager.initFromServer()
							characterManager.show()
						end
					end}
				)
				avatarEditorLoader:AwaitFinished()
				if startCount == showCount then
					avatarEditorLoader:Cleanup()
					avatarEditorLoader = nil
				end
			end

			if startCount == showCount then
				Container.Parent = parent
				if inFocus then
					FocusAll()
				end

				while startCount == showCount do
					local deltaT = Utilities.renderWait()
					if startCount == showCount then
						rotationInfo.rotation = rotationInfo.rotation + deltaT * rotationInfo.delta
						characterManager.setRotation(rotationInfo.rotation)
						if not lastCharacterSaveTime or tick() - lastCharacterSaveTime > 5 then
							characterManager.characterSave(false)
							lastCharacterSaveTime = tick()
						end
					end
				end
			end
		end)
	end

	function this:Hide()
		inShow = false
		showCount = showCount + 1
		characterManager.hide()
		savedSelectedGuiObject = nil
		selectedGuiObjectEnterFullView = nil
		Container.Parent = nil

		if not avatarEditorLoader then
			RemoveFocusAll()
			CategoryMenu:Hide()
			local savedCharacterUpdated = characterUpdated
			local savedCharacterEquipped = characterEquipped
			spawn(function()
				while savingAvatarMutex do
					wait()
				end
				savingAvatarMutex = true
				characterManager.characterSave(true)
				savingAvatarMutex = false

				if savedCharacterUpdated then
					EventHub:dispatchEvent(EventHub.Notifications["CharacterUpdated"])
				end
				if savedCharacterEquipped then
					EventHub:dispatchEvent(EventHub.Notifications["CharacterEquipped"], AppState.Store:GetState().Character.Assets)
				end
			end)
		end
	end

	--Rebind actions, make them in the right order
	function this:Focus()
		inFocus = true
		if inShow and not avatarEditorLoader then
			FocusAll()
		end
	end

	function this:RemoveFocus()
		inFocus = false
		if inShow and not avatarEditorLoader then
			savedSelectedGuiObject = Utilities.getSelectedCoreObject()
			RemoveFocusAll()
		end
	end

	function this:Destruct()
		this:RemoveFocus()
		this:Hide()
		Container:Destroy()
		characterManager.destroy()
		AppState:Destruct()
	end

	function this:GetFocusPoint()
		return characterManager.getFocusPoint({'HumanoidRootPart'})
	end

	return this
end

return createAvatarEditorView