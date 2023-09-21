local Modules = game:GetService("CoreGui").RobloxGui.Modules

local FlagSettings = require(Modules.LuaApp.FlagSettings)
local Roact = require(Modules.Common.Roact)
local User = require(Modules.LuaApp.Models.User)
local UserThumbnail = require(Modules.LuaApp.Components.UserThumbnail)

local isPeopleListV1Enabled = FlagSettings.IsPeopleListV1Enabled()

local MEASUREMENT_CONSTANTS = {
	THUMBNAIL_SIZE = 90,
	DROPSHADOW_SIZE = 94,
}

MEASUREMENT_CONSTANTS.USERNAME = {
	TEXT_LINE_HEIGHT = isPeopleListV1Enabled and 25 or 20,
	TEXT_FONT_SIZE = 18,
	TEXT_TOP_PADDING = 3,
}

MEASUREMENT_CONSTANTS.PRESENCE = {
	TEXT_TOP_PADDING = 3,
	TEXT_LINE_HEIGHT = 20,
	TEXT_FONT_SIZE = 15,

	ICONS = {
		[User.PresenceType.ONLINE] = "rbxasset://textures/ui/LuaApp/icons/ic-blue-online.png",
		[User.PresenceType.IN_GAME] = "rbxasset://textures/ui/LuaApp/icons/ic-green-ingame.png",
		[User.PresenceType.IN_STUDIO] = "rbxasset://textures/ui/LuaApp/icons/ic-orange-instudio.png",
	},

	DROPSHADOW_MARGIN = (MEASUREMENT_CONSTANTS.DROPSHADOW_SIZE - MEASUREMENT_CONSTANTS.THUMBNAIL_SIZE) / 2,
	BORDER_DIAMETER = 14,
	ICON_OFFSET = 5,
	ICON_SIZE = 24,
}

MEASUREMENT_CONSTANTS.PRESENCE_TEXT_HEIGHT = isPeopleListV1Enabled and MEASUREMENT_CONSTANTS.PRESENCE.TEXT_TOP_PADDING
		+ MEASUREMENT_CONSTANTS.PRESENCE.TEXT_LINE_HEIGHT or 0

local UserThumbnailDefaultOrientation = Roact.PureComponent:extend("UserThumbnailDefaultOrientation")

function UserThumbnailDefaultOrientation.size()
	return MEASUREMENT_CONSTANTS.THUMBNAIL_SIZE
end

function UserThumbnailDefaultOrientation.height()
	return MEASUREMENT_CONSTANTS.THUMBNAIL_SIZE
		+ MEASUREMENT_CONSTANTS.USERNAME.TEXT_TOP_PADDING
		+ MEASUREMENT_CONSTANTS.USERNAME.TEXT_LINE_HEIGHT
		+ MEASUREMENT_CONSTANTS.PRESENCE_TEXT_HEIGHT
end

function UserThumbnailDefaultOrientation:render()
	local user = self.props.user
	local highlightColor = self.props.highlightColor
	local thumbnailType = self.props.thumbnailType

	return Roact.createElement(UserThumbnail, {
		measurements = MEASUREMENT_CONSTANTS,
		user = user,
		highlightColor = highlightColor,
		thumbnailType = thumbnailType,
	})
end

return UserThumbnailDefaultOrientation