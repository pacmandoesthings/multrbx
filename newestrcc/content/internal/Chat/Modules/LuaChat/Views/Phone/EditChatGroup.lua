local Modules = script.Parent.Parent.Parent
local Components = Modules.Components

local ActionType = require(Modules.ActionType)
local Constants = require(Modules.Constants)

local BaseScreen = require(Modules.Views.Phone.BaseScreen)

local EditChatGroupComponent = require(Components.EditChatGroup)

local EditChatGroup = BaseScreen:Template()
EditChatGroup.__index = EditChatGroup

function EditChatGroup.new(appState, route)
	local self = {
		appState = appState,
		route = route,
		convoId = route.parameters.conversationId,
		connections = {},
	}
	setmetatable(self, EditChatGroup)

	local participantCount = #appState.store:GetState().Conversations[self.convoId].participants
	local maxSize = Constants.MAX_PARTICIPANT_COUNT + 1 - participantCount
	self.editChatGroupComponent = EditChatGroupComponent.new(appState, maxSize, self.convoId)
	self.rbx = self.editChatGroupComponent.rbx

	self.editChatGroupComponent.BackButtonPressed:Connect(function()
		self.appState.store:Dispatch({
			type = ActionType.PopRoute,
		})
	end)

	return self
end

function EditChatGroup:Start()
	BaseScreen.Start(self)

	do
		local connection = self.appState.store.Changed:Connect(function(current, previous)
			self:Update(current, previous)
		end)
		table.insert(self.connections, connection)
	end
end

function EditChatGroup:Stop()
	BaseScreen.Stop(self)

	for _, connection in ipairs(self.connections) do
		connection:Disconnect()
	end

	self.connections = {}
end

function EditChatGroup:Update(current, previous)
	self.editChatGroupComponent:Update(current, previous)
end

return EditChatGroup