-- This is the entry point for the Roblox Chat Program

local CoreGui = game:GetService("CoreGui")
local Modules = CoreGui.RobloxGui.Modules

local ChatMaster = require(Modules.ChatMaster)

-- Start the Lua Chat
local chatMaster = ChatMaster.new()
chatMaster:Start()

