local Players = game:GetService("Players")

local LuaChat = script.Parent.Parent
local MockId = require(LuaChat.MockId)

local User = {}

User.PresenceType = {
	OFFLINE = "OFFLINE",
	ONLINE = "ONLINE",
	IN_GAME = "IN_GAME",
	IN_STUDIO = "IN_STUDIO",
}

function User.new()
	local self = {}

	return self
end

function User.mock()
	local self = User.new()

	self.id = MockId()
	self.name = "USER NAME"
	self.presence = User.PresenceType.OFFLINE
	self.lastLocation = nil
	self.isFriend = false

	return self
end

function User.fromData(id, name, isFriend)
	local self = User.new()

	self.id = tostring(id)
	self.name = name
	self.presence = id == Players.LocalPlayer.UserId and User.PresenceType.ONLINE or User.PresenceType.OFFLINE
	self.lastLocation = nil
	self.isFriend = isFriend

	return self
end

return User