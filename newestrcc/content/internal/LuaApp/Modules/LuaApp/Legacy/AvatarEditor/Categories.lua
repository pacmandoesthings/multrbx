local Modules = game:GetService("CoreGui"):FindFirstChild("RobloxGui").Modules

local LayoutInfo = require(Modules.LuaApp.Legacy.AvatarEditor.LayoutInfo)
local Strings = require(Modules.LuaApp.Legacy.AvatarEditor.LocalizedStrings)

local legsZoomCFrame = CFrame.new(0, 0.75, -8)
local faceZoomCFrame = CFrame.new(0, 4.1, -10) * CFrame.Angles(math.rad(10), 0, 0)
local armsZoomCFrame = CFrame.new(0, 2.5, -8)
local headWideZoomCFrame = CFrame.new(0, 3.5, -6)

if LayoutInfo.isLandscape then
	legsZoomCFrame = CFrame.new(-0.75, -2, -1.5)
	faceZoomCFrame = CFrame.new(-1.65, 1.1, -3)
	armsZoomCFrame = CFrame.new(-0.6, -0.5, -1)
	headWideZoomCFrame = CFrame.new(-0.35, 1, 0)
end

local legsFocus = {Parts={'RightUpperLeg', 'LeftUpperLeg'}}
local faceFocus = {Parts={'Head'}}
local armsFocus = {Parts={'UpperTorso'}}
local headWideFocus = {Parts={'Head'}}
local neckFocus = {Parts={'Head', 'UpperTorso'}}
local shoulderFocus = {Parts={'Head', 'RightUpperArm', 'LeftUpperArm'}}
local waistFocus = {Parts={'LowerTorso', 'RightUpperLeg', 'LeftUpperLeg'}}

local scalingOnlyWorksForR15Text = Strings:LocalizedString("ScalingForR15Phrase")
local animationsOnlyWorkForR15Text = Strings:LocalizedString("AnimationsForR15Phrase")

local recentPage = {name = 'Recent All',
	title = Strings:LocalizedString("RecentAllWord"),
	display = Strings:LocalizedString("AllWord"),
	iconImage =			'rbxasset://textures/AvatarEditorIcons/PageIcons/Category/ic-all.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/PageIcons/Category/ic-all-on.png',
	iconImageName =		'ic-all',
	iconImageSelectedName = 'ic-all-on',
	specialPageType = 'Recent All'
}

local recentClothingPage = {name = 'Recent Clothing',
	title = Strings:LocalizedString("RecentClothingWord"),
	display = Strings:LocalizedString("ClothingWord"),
	iconImage =			'rbxasset://textures/AvatarEditorIcons/PageIcons/Category/ic-clothing.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/PageIcons/Category/ic-clothing-on.png',
	iconImageName = 'ic-clothing',
	iconImageSelectedName = 'ic-clothing-on',
	specialPageType = 'Recent Clothing'
}
local recentBodyPage = {name = 'Recent Body',
	title = Strings:LocalizedString("RecentBodyWord"),
	display = Strings:LocalizedString("BodyWord"),
	iconImage =			'rbxasset://textures/AvatarEditorIcons/PageIcons/Category/ic-body-part.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/PageIcons/Category/ic-body-part-on.png',
	iconImageName = 'ic-body',
	iconImageSelectedName = 'ic-body-on',
	specialPageType = 'Recent Body'
}
local recentAnimationPage = {name = 'Recent Animation',
	title = Strings:LocalizedString("RecentAnimationWord"),
	display = Strings:LocalizedString("AnimationsWord"),
	iconImage =			'rbxasset://textures/AvatarEditorIcons/PageIcons/Category/ic-avatar-animation.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/PageIcons/Category/ic-avatar-animation-on.png',
	iconImageName = 'ic-animations',
	iconImageSelectedName = 'ic-animations-on',
	specialPageType = 'Recent Animation'
}
local recentOutfitsPage = {name = 'Recent Costumes',
	title = Strings:LocalizedString("RecentCostumesWord"),
	display = Strings:LocalizedString("OutfitsWord"),
	iconImageName = 'ic-costumes',
	iconImageSelectedName = 'ic-costumes-on',
	specialPageType = 'Recent Outfits'
}


local outfitsPage = {name = 'Outfits',			--outfits will include packages in some way
	title = Strings:LocalizedString("OutfitsWord"),
	display = Strings:LocalizedString("OutfitsWord"),
	iconImage =			'rbxasset://textures/AvatarEditorIcons/ic-bundle.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/ic-bundle-white.png',
	iconImageName = 'ic-costumes',
	iconImageSelectedName = 'ic-costumes-on',
	infiniteScrolling = true,
	specialPageType = 'Outfits'
}
local hatsPage = {name = 'Hats',
	title = Strings:LocalizedString("HatsWord"),
	display = Strings:LocalizedString("HatWord"),
	typeName = 'Hat',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/ic-hat.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/ic-hat-white.png',
	iconImageName = 'ic-hat',
	iconImageSelectedName = 'ic-hat-on',
	infiniteScrolling = true,
	recommendedSort = true,
	CameraCFrameOffset = headWideZoomCFrame,
	CameraFocus = headWideFocus
}
local hairPage = {name = 'Hair',
	title = Strings:LocalizedString("HairWord"),
	display = Strings:LocalizedString("HairWord"),
	typeName = 'Hair Accessory',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/PageIcons/Clothing/ic-hair.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/PageIcons/Clothing/ic-hair-on.png',
	iconImageName = 'ic-hair',
	iconImageSelectedName = 'ic-hair-on',
	infiniteScrolling = true,
	recommendedSort = true,
	CameraCFrameOffset = headWideZoomCFrame,
	CameraFocus = headWideFocus
}
local faceAccessoryPage = {name = 'Face Accessories',
	title = Strings:LocalizedString("FaceAccessoriesWord"),
	display = Strings:LocalizedString("FaceWord"),
	typeName = 'Face Accessory',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/PageIcons/Clothing/ic-face.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/PageIcons/Clothing/ic-face-on.png',
	iconImageName = 'ic-face-accessories',
	iconImageSelectedName = 'ic-face-accessories-on',
	infiniteScrolling = true,
	recommendedSort = true,
	CameraCFrameOffset = faceZoomCFrame,
	CameraFocus = faceFocus
}
local neckAccessoryPage = {name = 'Neck Accessories',
	title = Strings:LocalizedString("NeckAccessoriesWord"),
	display = Strings:LocalizedString("NeckWord"),
	typeName = 'Neck Accessory',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/PageIcons/Clothing/ic-neck.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/PageIcons/Clothing/ic-neck-on.png',
	iconImageName = 'ic-neck',
	iconImageSelectedName = 'ic-neck-on',
	infiniteScrolling = true,
	recommendedSort = true,
	CameraCFrameOffset = armsZoomCFrame:lerp(faceZoomCFrame, 0.5),
	CameraFocus = neckFocus
}
local shoulderAccessoryPage = {name = 'Shoulder Accessories',
	title = Strings:LocalizedString("ShoulderAccessoriesWord"),
	display = Strings:LocalizedString("ShoulderWord"),
	typeName = 'Shoulder Accessory',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/PageIcons/Clothing/ic-shoulder.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/PageIcons/Clothing/ic-shoulder-on.png',
	iconImageName = 'ic-shoulders',
	iconImageSelectedName = 'ic-shoulders-on',
	infiniteScrolling = true,
	recommendedSort = true,
	CameraCFrameOffset = armsZoomCFrame:lerp(faceZoomCFrame, 0.5),
	CameraFocus = shoulderFocus
}
local frontAccessoryPage = {name = 'Front Accessories',
	title = Strings:LocalizedString("FrontAccessoriesWord"),
	display = Strings:LocalizedString("FrontWord"),
	typeName = 'Front Accessory',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/PageIcons/Clothing/ic-front.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/PageIcons/Clothing/ic-front-on.png',
	iconImageName = 'ic-front',
	iconImageSelectedName = 'ic-front-on',
	infiniteScrolling = true,
	recommendedSort = true,
	CameraCFrameOffset = armsZoomCFrame,
	CameraFocus = armsFocus
}
local backAccessoryPage = {name = 'Back Accessories',
	title = Strings:LocalizedString("BackAccessoriesWord"),
	display = Strings:LocalizedString("BackWord"),
	typeName = 'Back Accessory',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/PageIcons/Clothing/ic-back.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/PageIcons/Clothing/ic-back-on.png',
	iconImageName = 'ic-back',
	iconImageSelectedName = 'ic-back-on',
	infiniteScrolling = true,
	recommendedSort = true,
	CameraCFrameOffset = armsZoomCFrame,
	CameraFocus = armsFocus
}
local waistAccessoryPage = {name = 'Waist Accessories',
	title = Strings:LocalizedString("WaistAccessoriesWord"),
	display = Strings:LocalizedString("WaistWord"),
	typeName = 'Waist Accessory',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/PageIcons/Clothing/ic-waist.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/PageIcons/Clothing/ic-waist-on.png',
	iconImageName = 'ic-waist',
	iconImageSelectedName = 'ic-waist-on',
	infiniteScrolling = true,
	recommendedSort = true,
	CameraCFrameOffset = armsZoomCFrame:lerp(legsZoomCFrame, 0.5),
	CameraFocus = waistFocus
}
local shirtsPage = {name = 'Shirts',
	title = Strings:LocalizedString("ShirtsWord"),
	display = Strings:LocalizedString("ShirtWord"),
	typeName = 'Shirt',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/ic-tshirt.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/ic-tshirt-white.png',
	iconImageName = 'ic-shirts',
	iconImageSelectedName = 'ic-shirts-on',
	infiniteScrolling = true,
	recommendedSort = true,
	CameraCFrameOffset = armsZoomCFrame,
	CameraFocus = armsFocus
}
local pantsPage = {name = 'Pants',
	title = Strings:LocalizedString("PantsWord"),
	display = Strings:LocalizedString("PantsWord"),
	typeName = 'Pants',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/ic-pant.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/ic-pant-white.png',
	iconImageName = 'ic-pants',
	iconImageSelectedName = 'ic-pants-on',
	infiniteScrolling = true,
	recommendedSort = true,
	CameraCFrameOffset = legsZoomCFrame,
	CameraFocus = legsFocus
}
local facesPage = {name = 'Faces',
	title = Strings:LocalizedString("FacesWord"),
	display = Strings:LocalizedString("FaceWord"),
	typeName = 'Face',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/ic-face.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/ic-face-white.png',
	iconImageName = 'ic-face',
	iconImageSelectedName = 'ic-face-on',
	infiniteScrolling = true,
	recommendedSort = true,
	CameraCFrameOffset = faceZoomCFrame,
	CameraFocus = faceFocus
}
local headsPage = {name = 'Heads',
	title = Strings:LocalizedString("HeadsWord"),
	display = Strings:LocalizedString("HeadWord"),
	typeName = 'Head',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/ic-head.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/ic-head-white.png',
	iconImageName = 'ic-head',
	iconImageSelectedName = 'ic-head-on',
	infiniteScrolling = true,
	recommendedSort = true,
	CameraCFrameOffset = faceZoomCFrame,
	CameraFocus = faceFocus
}
local torsosPage = {name = 'Torsos',
	title = Strings:LocalizedString("TorsosWord"),
	display = Strings:LocalizedString("TorsoWord"),
	typeName = 'Torso',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/ic-torso.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/ic-torso-white.png',
	iconImageName = 'ic-torso',
	iconImageSelectedName = 'ic-torso-on',
	infiniteScrolling = true,
	CameraCFrameOffset = armsZoomCFrame,
	CameraFocus = armsFocus
}
local rightArmsPage = {name = 'Right Arms',
	title = Strings:LocalizedString("RightArmsWord"),
	display = Strings:LocalizedString("RightArmWord"),
	typeName = 'RightArm',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/ic-rightarm.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/ic-rightarm-white.png',
	iconImageName = 'ic-right-arms',
	iconImageSelectedName = 'ic-right-arms-on',
	infiniteScrolling = true,
	CameraCFrameOffset = armsZoomCFrame,
	CameraFocus = armsFocus
}
local leftArmsPage = {name = 'Left Arms',
	title = Strings:LocalizedString("LeftArmsWord"),
	display = Strings:LocalizedString("LeftArmWord"),
	typeName = 'LeftArm',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/ic-leftarm.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/ic-leftarm-white.png',
	iconImageName = 'ic-left-arms',
	iconImageSelectedName = 'ic-left-arms-on',
	infiniteScrolling = true,
	CameraCFrameOffset = armsZoomCFrame,
	CameraFocus = armsFocus
}
local rightLegsPage = {name = 'Right Legs',
	title = Strings:LocalizedString("RightLegsWord"),
	display = Strings:LocalizedString("RightLegWord"),
	typeName = 'RightLeg',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/ic-rightleg.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/ic-rightleg-white.png',
	iconImageName = 'ic-right-legs',
	iconImageSelectedName = 'ic-right-legs-on',
	infiniteScrolling = true,
	CameraCFrameOffset = legsZoomCFrame,
	CameraFocus = legsFocus
}
local leftLegsPage = {name = 'Left Legs',
	title = Strings:LocalizedString("LeftLegsWord"),
	display = Strings:LocalizedString("LeftLegWord"),
	typeName = 'LeftLeg',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/ic-leftleg.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/ic-leftleg-white.png',
	iconImageName = 'ic-left-legs',
	iconImageSelectedName = 'ic-left-legs-on',
	infiniteScrolling = true,
	CameraCFrameOffset = legsZoomCFrame,
	CameraFocus = legsFocus
}
local gearPage = {name = 'Gear',
	title = Strings:LocalizedString("GearWord"),
	display = Strings:LocalizedString("GearWord"),
	typeName = 'Gear',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/ic-gear.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/ic-gear-white.png',
	iconImageName = 'ic-gear',
	iconImageSelectedName = 'ic-gear-on',
	infiniteScrolling = true,
	recommendedSort = true,
}
local skinTonePage = {name = 'Skin Tone',
	title = Strings:LocalizedString("SkinToneWord"),
	display = Strings:LocalizedString("SkinToneWord"),
	iconImage =			'rbxasset://textures/AvatarEditorIcons/ic-color.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/ic-color-filled.png',
	iconImageName = 'ic-skintone',
	iconImageSelectedName = 'ic-skintone-on',
	special = true,
	specialPageType = 'Skin Tone'
}
local scalePage = {name = 'Scale',
	title = Strings:LocalizedString("ScaleWord"),
	display = Strings:LocalizedString("ScaleWord"),
	iconImage =			'rbxasset://textures/AvatarEditorIcons/ic-scale.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/ic-scale-filled.png',
	iconImageName = 'ic-scale',
	iconImageSelectedName = 'ic-scale-on',
	special = true,
	r15only = true,
	r15onlyMessage = scalingOnlyWorksForR15Text,
	specialPageType = 'Scale'
}

local climbAnimPage = {name = 'Climb Animations',
	title = Strings:LocalizedString("ClimbAnimationsWord"),
	display = Strings:LocalizedString("ClimbWord"),
	typeName = 'ClimbAnimation',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/PageIcons/Avatar-Animation/ic-climb.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/PageIcons/Avatar-Animation/ic-climb-on.png',
	iconImageName = 'ic-climb',
	iconImageSelectedName = 'ic-climb-on',
	infiniteScrolling = true,
	r15only = true,
	r15onlyMessage = animationsOnlyWorkForR15Text
}
local jumpAnimPage = {name = 'Jump Animations',
	title = Strings:LocalizedString("JumpAnimationsWord"),
	display = Strings:LocalizedString("JumpWord"),
	typeName = 'JumpAnimation',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/PageIcons/Avatar-Animation/ic-jump.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/PageIcons/Avatar-Animation/ic-jump-on.png',
	iconImageName = 'ic-jump',
	iconImageSelectedName = 'ic-jump-on',
	infiniteScrolling = true,
	r15only = true,
	r15onlyMessage = animationsOnlyWorkForR15Text
}
local fallAnimPage = {name = 'Fall Animations',
	title = Strings:LocalizedString("FallAnimationsWord"),
	display = Strings:LocalizedString("FallWord"),
	typeName = 'FallAnimation',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/PageIcons/Avatar-Animation/ic-fall.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/PageIcons/Avatar-Animation/ic-fall-on.png',
	iconImageName = 'ic-fall',
	iconImageSelectedName = 'ic-fall-on',
	infiniteScrolling = true,
	r15only = true,
	r15onlyMessage = animationsOnlyWorkForR15Text
}
local idleAnimPage = {name = 'Idle Animations',
	title = Strings:LocalizedString("IdleAnimationsWord"),
	display = Strings:LocalizedString("IdleWord"),
	typeName = 'IdleAnimation',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/PageIcons/Avatar-Animation/ic-idle.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/PageIcons/Avatar-Animation/ic-idle-on.png',
	iconImageName = 'ic-idle',
	iconImageSelectedName = 'ic-idle-on',
	infiniteScrolling = true,
	r15only = true,
	r15onlyMessage = animationsOnlyWorkForR15Text
}
local walkAnimPage = {name = 'Walk Animations',
	title = Strings:LocalizedString("WalkAnimationsWord"),
	display = Strings:LocalizedString("WalkWord"),
	typeName = 'WalkAnimation',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/PageIcons/Avatar-Animation/ic-walk.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/PageIcons/Avatar-Animation/ic-walk-on.png',
	iconImageName = 'ic-walk',
	iconImageSelectedName = 'ic-walk-on',
	infiniteScrolling = true,
	r15only = true,
	r15onlyMessage = animationsOnlyWorkForR15Text
}
local runAnimPage = {name = 'Run Animations',
	title = Strings:LocalizedString("RunAnimationsWord"),
	display = Strings:LocalizedString("RunWord"),
	typeName = 'RunAnimation',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/PageIcons/Avatar-Animation/ic-run.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/PageIcons/Avatar-Animation/ic-run-on.png',
	iconImageName = 'ic-run',
	iconImageSelectedName = 'ic-run-on',
	infiniteScrolling = true,
	r15only = true,
	r15onlyMessage = animationsOnlyWorkForR15Text
}
local swimAnimPage = {name = 'Swim Animations',
	title = Strings:LocalizedString("SwimAnimationsWord"),
	display = Strings:LocalizedString("SwimWord"),
	typeName = 'SwimAnimation',
	iconImage =			'rbxasset://textures/AvatarEditorIcons/PageIcons/Avatar-Animation/ic-swim.png',
	iconImageSelected =	'rbxasset://textures/AvatarEditorIcons/PageIcons/Avatar-Animation/ic-swim-on.png',
	iconImageName = 'ic-swim',
	iconImageSelectedName = 'ic-swim-on',
	infiniteScrolling = true,
	r15only = true,
	r15onlyMessage = animationsOnlyWorkForR15Text
}


local recentCategory = {name = 'Recent',
	title = Strings:LocalizedString("RecentWord"),
	display = Strings:LocalizedString("RecentWord"),
	iconImage = 'rbxasset://textures/AvatarEditorIcons/PageIcons/Category/ic-recent.png',
	selectedIconImage = 'rbxasset://textures/AvatarEditorIcons/PageIcons/Category/ic-recent-on.png',
	iconImageConsole = 'rbxasset://textures/ui/Shell/AvatarEditor/icon/ic-recent-wht.png',
	selectedIconImageConsole = 'rbxasset://textures/ui/Shell/AvatarEditor/icon/ic-recent-blk.png',
	iconImageName = 'ic-recent',
	selectedIconImageName = 'ic-recent-on',
	pages = {recentPage, recentClothingPage, recentBodyPage}
}
local clothingCategory = {name = 'Clothing',
	title = Strings:LocalizedString("ClothingWord"),
	display = Strings:LocalizedString("ClothingWord"),
	iconImage = 'rbxasset://textures/AvatarEditorIcons/PageIcons/Category/ic-clothing.png',
	selectedIconImage = 'rbxasset://textures/AvatarEditorIcons/PageIcons/Category/ic-clothing-on.png',
	iconImageConsole = 'rbxasset://textures/ui/Shell/AvatarEditor/icon/ic-clothing-wht.png',
	selectedIconImageConsole = 'rbxasset://textures/ui/Shell/AvatarEditor/icon/ic-clothing-blk.png',
	iconImageName = 'ic-clothing',
	selectedIconImageName = 'ic-clothing-on',
	pages = {hatsPage,
		shirtsPage,
		pantsPage,
		hairPage,
		faceAccessoryPage,
		neckAccessoryPage,
		shoulderAccessoryPage,
		frontAccessoryPage,
		backAccessoryPage,
		waistAccessoryPage,
		gearPage,},
}
local bodyCategory = {name = 'Body',
	title = Strings:LocalizedString("BodyWord"),
	display = Strings:LocalizedString("BodyWord"),
	iconImage = 'rbxasset://textures/AvatarEditorIcons/PageIcons/Category/ic-body-part.png',
	selectedIconImage = 'rbxasset://textures/AvatarEditorIcons/PageIcons/Category/ic-body-part-on.png',
	iconImageConsole = 'rbxasset://textures/ui/Shell/AvatarEditor/icon/ic-body-wht.png',
	selectedIconImageConsole = 'rbxasset://textures/ui/Shell/AvatarEditor/icon/ic-body-blk.png',
	iconImageName = 'ic-body',
	selectedIconImageName = 'ic-body-on',
	pages = {outfitsPage, facesPage, headsPage, torsosPage, rightArmsPage, leftArmsPage, rightLegsPage, leftLegsPage},
}
local animationCategory = {name = 'Animation',
	title = Strings:LocalizedString("AnimationWord"),
	display = Strings:LocalizedString("AnimationsWord"),
	iconImage = 'rbxasset://textures/AvatarEditorIcons/PageIcons/Category/ic-avatar-animation.png',
	selectedIconImage = 'rbxasset://textures/AvatarEditorIcons/PageIcons/Category/ic-avatar-animation-on.png',
	iconImageConsole = 'rbxasset://textures/ui/Shell/AvatarEditor/icon/ic-animation-wht.png',
	selectedIconImageConsole = 'rbxasset://textures/ui/Shell/AvatarEditor/icon/ic-animation-blk.png',
	iconImageName = 'ic-animations',
	selectedIconImageName = 'ic-animations-on',
--	pages = {climbAnimPage, jumpAnimPage, fallAnimPage, idleAnimPage, walkAnimPage, runAnimPage, swimAnimPage}
	pages = {idleAnimPage, walkAnimPage, runAnimPage, jumpAnimPage, fallAnimPage, climbAnimPage, swimAnimPage}
}
local costumeCategory = {name = 'Costume',
	title = Strings:LocalizedString("CostumeWord"),
	display = Strings:LocalizedString("OutfitsWord"),
	iconImageConsole = 'rbxasset://textures/ui/Shell/AvatarEditor/icon/ic-costume-wht.png',
	selectedIconImageConsole = 'rbxasset://textures/ui/Shell/AvatarEditor/icon/ic-costume-blk.png',
	iconImageName = 'ic-costumes',
	selectedIconImageName = 'ic-costumes-on',
	pages = {outfitsPage}
}

local categories = {
	recentCategory,
	clothingCategory,
	bodyCategory,
}

table.insert(categories, animationCategory)
table.insert(recentCategory.pages, recentAnimationPage)

bodyCategory.pages = {facesPage, headsPage, torsosPage, rightArmsPage, leftArmsPage, rightLegsPage, leftLegsPage}

table.insert(categories, costumeCategory)

outfitsPage.iconImageName = 'ic-all'
outfitsPage.iconImageSelectedName = 'ic-all-on'


table.insert(bodyCategory.pages, 1, skinTonePage)
table.insert(bodyCategory.pages, 2, scalePage)

if LayoutInfo.isLandscape then
	animationCategory.iconImageName = 'ic-run'
	animationCategory.selectedIconImageName = 'ic-run-on'

	recentAnimationPage.iconImageName = 'ic-run'
	recentAnimationPage.iconImageSelectedName = 'ic-run-on'

	outfitsPage.display = Strings:LocalizedString("AllWord")

	table.insert(recentCategory.pages, recentOutfitsPage)

	clothingCategory.pages = {hatsPage,
		hairPage,
		faceAccessoryPage,
		neckAccessoryPage,
		shoulderAccessoryPage,
		frontAccessoryPage,
		backAccessoryPage,
		waistAccessoryPage,
		shirtsPage,
		pantsPage,
		gearPage}

	leftArmsPage.display = Strings:LocalizedString("LeftArmsWord")
	rightArmsPage.display = Strings:LocalizedString("RightArmsWord")
	leftLegsPage.display = Strings:LocalizedString("LeftLegsWord")
	rightLegsPage.display = Strings:LocalizedString("RightLegsWord")
end


return categories

