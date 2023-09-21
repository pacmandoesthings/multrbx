local module = {
	RegularFont = Enum.Font.SourceSans;

	WhiteTextColor = Color3.fromRGB(255, 255, 255);
	BlueTextColor = Color3.fromRGB(25, 25, 25);

	-- Font Sizes
	ButtonFontSize = 36;
	SubHeaderFontSize = 24;

	--CategoryMenu & Tablist
	CategoryMenuPosition = UDim2.new(0, 100, 0, 270);
	TabListPosition = UDim2.new(0, 220, 0, 270);
	TabListScrollPosition = UDim2.new(0, 220, 0, 170);

	CategoryButtonDefaultSize = UDim2.new(0, 360, 0, 80);
	CategoryButtonSmallSize = UDim2.new(0, 80, 0, 80);

	CategoryButtonImageDefault = 'rbxasset://textures/ui/Shell/AvatarEditor/button/btn-category.png';
	CategoryButtonImageSelected = 'rbxasset://textures/ui/Shell/AvatarEditor/button/btn-category-selected.png';
	CategoryButtonImageInactive = 'rbxasset://textures/ui/Shell/AvatarEditor/button/btn-category-inactive.png';

	CategoryIconSize = UDim2.new(0, 32, 0, 32);
	CategoryTextSize = UDim2.new(0, 200, 0, 50);

	--Indicator
	IndicatorHeight = 83;
	IndicatorBottomDistance = 60;
	IndicatorIconTextDistance = 16;
	IndicatorButtonsDistance = 60;


	--Tween
	DefaultTweenTime = 0.2;

	--Layers
	BackgroundLayer = 1;
	BasicLayer = 2;
	AssetImageLayer = 3;
	EquippedFrameLayer = 4;
	ShadingOverlayLayer = 5;
	IndicatorLayer = 6;

	--Page & CardGrid
	ButtonsPerRow = 3;
	SkinColorsPerRow = 5;
	ButtonSize = 150;
	GridPadding = 20;
	SkinColorGridPadding = 20;
	ExtraVerticalShift = 0;
	SkinColorExtraVerticalShift = 0;
	SkinColorButtonSize = 74;
	SelectorBottomMinDistance = 190;
	SelectorTopMinDistance = 270;

	--Camera
	CameraCenterScreenPosition = Vector2.new(0, 0);
	CameraDefaultCFrame =
		CFrame.new(
			11.4540062, 4.43129206, -24.0810471,
			-0.999674082, 0.0140569285, 0.0213133395,
			0.014922224, 0.999047816, 0.0409984589,
			-0.0207167268, 0.0413031578, -0.998931825);
}
return module

