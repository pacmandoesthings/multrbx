local windowSize = game:GetService("CoreGui").RobloxGui.AbsoluteSize
local isLandscape =  windowSize.x > windowSize.y

local module = {
	isLandscape = isLandscape;
	ButtonsPerRow = 4;
	SkinColorsPerRow = 5;
	SkinColorGridPadding = 12;
}

if isLandscape then
	module.FullViewInitialPosition = UDim2.new(1, -112, 1, -52)
	module.AvatarTypeSwitchOffColor = Color3.fromRGB(182, 182, 182)
	module.AvatarTypeSwitchOnColor = Color3.new(1, 1, 1)
	module.AvatarTypeSwitchTextSize = 14
	module.AvatarTypeSwitchInitialPosition = UDim2.new(0.5, -148, 0, 24)
	module.AvatarTypeSwitchPositionFullView = UDim2.new(0.5, -148, 0, -86)
	module.AvatarTypeSwitchPosition = UDim2.new(0.5, -148, 0, 24)

	module.TabWidth = 84
	module.TabHeight = 72
	module.FirstTabBonusWidth = 45
	module.GridPadding = 12
	module.ExtraVerticalShift = 8
	module.SkinColorExtraVerticalShift = 0

	module.CameraCenterScreenPosition = Vector2.new(-0.5, 0)

	module.CameraDefaultCFrame =
		CFrame.new(
			11.4540062, 4.43129206, -24.0810471,
			-0.999674082, 0.0140569285, 0.0213133395,
			0.014922224, 0.999047816, 0.0409984589,
			-0.0207167268, 0.0413031578, -0.998931825)
else
	module.FullViewInitialPosition = UDim2.new(1, -52, 1, -52)
	module.AvatarTypeSwitchOffColor = Color3.new(0.44, 0.44, 0.44)
	module.AvatarTypeSwitchOnColor = Color3.new(1, 1, 1)
	module.AvatarTypeSwitchTextSize = 18
	module.AvatarTypeSwitchInitialPosition = UDim2.new(1, -88, 0, 24)
	module.AvatarTypeSwitchPositionFullView = UDim2.new(1, -88, 0, -86)
	module.AvatarTypeSwitchPosition = UDim2.new(1, -88, 0, 24)

	module.TabWidth = 60
	module.TabHeight = 50
	module.FirstTabBonusWidth = 10
	module.GridPadding = 6
	module.ExtraVerticalShift = 25
	module.SkinColorExtraVerticalShift = 25

	module.CameraCenterScreenPosition = Vector2.new(0, -0.5)

	module.CameraDefaultCFrame =
		CFrame.new(
			10.2426682, 5.1197648, -30.9536419,
			-0.946675897, 0.123298854, -0.297661126,
			0.000000000, 0.92387563, 0.382692933,
			0.322187454, 0.36228618, -0.874610782)
end

return module

