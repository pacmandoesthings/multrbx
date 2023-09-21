local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local LuaChat = CoreGui.RobloxGui.Modules.LuaChat

local Config = require(LuaChat.Config)
local AppState = require(LuaChat.AppState)
local DebugManager = require(LuaChat.Debug.DebugManager)
local ActionType = require(LuaChat.ActionType)
local DialogInfo = require(LuaChat.DialogInfo)

local Intent = DialogInfo.Intent

local ChatMaster = {}
ChatMaster.__index = ChatMaster

function ChatMaster.new()
	local self = {}
	setmetatable(self, ChatMaster)

	if Players.NumPlayers == 0 then
		Players.PlayerAdded:Wait()
	end

	-- Get rid of this once we can detect if play solo or not
	if CoreGui:FindFirstChild("MobileChat") then
		CoreGui.MobileChat:Destroy()
	end

	-- In debug mode, load the DebugManager overlay and logging system
	if Config.Debug then
		warn("CHAT DEBUG MODE IS ENABLED")
		DebugManager:Initialize(CoreGui)
		DebugManager:Start()
	end

	-- Reduce render quality to optimize performance
	settings().Rendering.QualityLevel = 1

	self._appState = AppState.new(CoreGui)
	self._started = false

	return self
end

function ChatMaster:Start()
	RunService:setThrottleFramerateEnabled(true)
	if not self._started then
		GuiService:SetGlobalGuiInset(0, 0, 0, UserInputService.BottomBarSize.Y)
		self._appState.store:Dispatch({
			type = ActionType.SetRoute,
			intent = Intent.ConversationHub,
			parameters = {},
		})
		self._started = true
		return
	end

	self._appState.store:Dispatch({
		type = ActionType.ToggleChatPaused,
		screenManager = self._appState.screenManager,
		value = false,
	})
end

function ChatMaster:Stop()
	RunService:setThrottleFramerateEnabled(false)
	self._appState.store:Dispatch({
		type = ActionType.ToggleChatPaused,
		screenManager = self._appState.screenManager,
		value = true,
	})
end

return ChatMaster