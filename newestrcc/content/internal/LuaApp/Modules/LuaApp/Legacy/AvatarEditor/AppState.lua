local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:FindFirstChild("RobloxGui")
local Modules = RobloxGui.Modules

local AvatarReducer = require(Modules.LuaApp.Reducers.AvatarEditor.Avatar)
local Store = require(Modules.Common.Rodux).Store

local AppState = {}

function AppState:Init()
	self.Store = Store.new(AvatarReducer)
end

function AppState:Destruct()
	self.Store:Destruct()
end

AppState:Init()

return AppState
