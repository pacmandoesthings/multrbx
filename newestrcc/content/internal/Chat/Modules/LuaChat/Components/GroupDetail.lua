
local function getAsset(name)
	return "rbxasset://textures/ui/LuaChat/"..name..".png"
end

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LuaApp = CoreGui.RobloxGui.Modules.LuaApp
local StringsLocale = require(LuaApp.StringsLocale)

local Modules = script.Parent.Parent
local Signal = require(Modules.Signal)
local Create = require(Modules.Create)
local WebApi = require(Modules.WebApi)
local Constants = require(Modules.Constants)
local Functional = require(Modules.Functional)
local ActionType = require(Modules.ActionType)
local DialogInfo = require(Modules.DialogInfo)

local ConversationActions = require(Modules.Actions.ConversationActions)

local Components = Modules.Components
local HeaderLoader = require(Components.HeaderLoader)
local SectionComponent = require(Components.ListSection)
local ActionEntryComponent = require(Components.ActionEntry)
local DialogComponents = require(Components.DialogComponents)
local UserListComponent = require(Components.UserList)
local ListEntryComponent = require(Components.ListEntry)
local ResponseIndicator = require(Components.ResponseIndicator)

local ConversationModel = require(Modules.Models.Conversation)

local Intent = DialogInfo.Intent

local PARTICIPANT_VIEW = 1
local PARTICIPANT_REPORT = 2
local PARTICIPANT_REMOVE = 3

local SeeMoreButton = {}
SeeMoreButton.__index = SeeMoreButton

function SeeMoreButton.new(appState)
	local self = {}
	setmetatable(self, SeeMoreButton)

	local listEntry = ListEntryComponent.new(appState, 40)

	self.rbx = listEntry.rbx
	self.tapped = listEntry.tapped

	local label = Create.new"TextLabel" {
		Name = "Label",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -12, 1, 0),
		Position = UDim2.new(0, 12, 0, 0),
		TextSize = 16,
		TextColor3 = Constants.Color.BLUE_PRIMARY,
		Font = Enum.Font.SourceSans,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = appState.localization:Format(StringsLocale.Keys.SEE_MORE_FRIENDS),
	}
	label.Parent = self.rbx

	local divider = Create.new"Frame" {
		Name = "Divider",
		BackgroundColor3 = Constants.Color.GRAY4,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, 1, -1),
	}
	divider.Parent = self.rbx

	return self
end

function SeeMoreButton:Update(text)
	self.rbx.Label.Text = text
end

local GroupDetail = {}
GroupDetail.__index = GroupDetail

function GroupDetail.new(appState, convoId)
	local self = {}
	self.connections = {}
	setmetatable(self, GroupDetail)

	self.appState = appState
	self.conversationId = convoId
	self.AddFriendsPressed = Signal.new()

	self.oldState = nil
	self.header = HeaderLoader.GetHeader(appState, Intent.GroupDetail)
	self.header:SetTitle(appState.localization:Format(StringsLocale.Keys.CHAT_DETAILS))
	self.header:SetDefaultSubtitle()
	self.header:SetBackButtonEnabled(true)

	self.rbx = Create.new"Frame" {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Constants.Color.GRAY5,
		BorderSizePixel = 0,

		self.header.rbx,
		Create.new "ScrollingFrame" {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 0,
			Create.new"Frame" {
				Name = "Content",
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundColor3 = Constants.Color.GRAY5,
				BorderSizePixel = 0,
				Create.new"UIListLayout" {
					Name = "ListLayout",
					SortOrder = Enum.SortOrder.LayoutOrder,
				},
			},
		},
	}
	local scrollingFrame = self.rbx.ScrollingFrame
	local content = scrollingFrame.Content

	self.BackButtonPressed = self.header.BackButtonPressed

	scrollingFrame.Position = UDim2.new(0, 0, 0, self.header.rbx.Size.Y.Offset)
	scrollingFrame.Size = UDim2.new(1, 0, 1, -self.header.rbx.Size.Y.Offset)

	self.responseIndicator = ResponseIndicator.new(appState)
	self.responseIndicator:SetVisible(false)

	self.general = SectionComponent.new(appState, StringsLocale.Keys.GENERAL)
	self.general.rbx.LayoutOrder = 1
	self.general.rbx.Parent = content

	self.groupName = ActionEntryComponent.new(appState, getAsset("icons/ic-nametag"), StringsLocale.Keys.CHAT_GROUP_NAME)
	self.groupName.rbx.LayoutOrder = 2
	self.groupName.rbx.Parent = content
	self.groupName.tapped.Event:Connect(function()
		self.appState.store:Dispatch({
			type = ActionType.SetRoute,
			intent = Intent.EditGroupName,
			parameters = {
				conversationId = self.conversationId,
			},
		})
	end)

	self.responseIndicator = ResponseIndicator.new(appState)
	self.responseIndicator:SetVisible(false)
	self.responseIndicator.rbx.Parent = self.rbx

	self.groupNameDialog = DialogComponents.TextInputDialog.new(appState, StringsLocale.Keys.CHAT_GROUP_NAME, 150)
	self.groupNameDialog.rbx.Parent = self.rbx
	self.groupNameDialog.saved:Connect(function(newName)
		self.responseIndicator:SetVisible(true)
		local callback = function()
			self.responseIndicator:SetVisible(false)
		end
		local action = ConversationActions.RenameGroupConversation(self.conversation.id, newName, callback)
		appState.store:Dispatch(action)
	end)
	self.groupNameDialog.cancel:Connect(function()
		if self.conversation then
			self.groupNameDialog:Update(self.conversation.title)
			self.groupNameDialog.textInputComponent.textBoxComponent:ReleaseFocus()
		end
	end)

	-- Tween the dialog upwards if the keyboard pops up.
	self.tween = nil
	local inputServiceConnection = UserInputService:GetPropertyChangedSignal('OnScreenKeyboardVisible'):Connect(function()
		if UserInputService.OnScreenKeyboardVisible then
			if self.tween == nil then
				local duration = UserInputService.OnScreenKeyboardAnimationDuration
				local yPos = UserInputService.OnScreenKeyboardPosition.Y / 2
				local tweenInfo = TweenInfo.new(duration)
				local propertyGoals =
				{
					Position = UDim2.new(0.5, 0, 0, yPos)
				}
				self.tween = TweenService:Create(self.groupNameDialog.rbx.Dialog, tweenInfo, propertyGoals)
			end
			self.tween:Play()
		end
	end)
	table.insert(self.connections, inputServiceConnection)

	local members = SectionComponent.new(appState, StringsLocale.Keys.MEMBERS)
	members.rbx.LayoutOrder = 5
	members.rbx.Parent = content

	self.addFriends = ActionEntryComponent.new(appState, getAsset("icons/ic-add-friends"),
		StringsLocale.Keys.ADD_FRIENDS, 36)
	self.addFriends.rbx.LayoutOrder = 6
	self.addFriends:SetDividerOffset(60)
	self.addFriends.rbx.Parent = content

	self.AddFriendsPressed = self.addFriends.tapped.Event

	self.participantsList = UserListComponent.new(appState, getAsset("icons/ic-more"))
	self.participantsList.rbx.LayoutOrder = 7
	self.participantsList.rbx.Parent = content
	self.participantsList.userSelected:Connect(function(user)
		if user.id ~= tostring(Players.LocalPlayer.UserId) then
			self.appState.store:Dispatch({
				type = ActionType.SetRoute,
				intent = Intent.ParticipantOptions,
				parameters = {
					conversationId = self.conversationId,
					userId = user.id,
				},
			})
		end
	end)

	self.participantDialog = DialogComponents.OptionDialog.new(appState, StringsLocale.Keys.OPTION, {
		[PARTICIPANT_VIEW] = StringsLocale.Keys.VIEW_PROFILE,
		[PARTICIPANT_REPORT] = StringsLocale.Keys.REPORT_USER,
		[PARTICIPANT_REMOVE] = StringsLocale.Keys.REMOVE_FROM_GROUP,
	})
	self.participantDialog.rbx.LayoutOrder = 8
	self.participantDialog.rbx.Parent = self.rbx
	self.participantDialog.selected:Connect(function(optionId, userId)
		local user = self.appState.store:GetState().Users[userId]
		if user == nil then
			return
		end
		if optionId == PARTICIPANT_VIEW then
			if user and user.id and (type(user.id) == 'string' or type(user.id) == 'number') then
				GuiService:BroadcastNotification(WebApi.MakeUserProfileUrl(user.id),
					GuiService:GetNotificationTypeList().VIEW_PROFILE)
			else
				print("Bad input to RequestNativeView, show error prompt here")
			end
		elseif optionId == PARTICIPANT_REPORT then
			if user and user.id and (type(user.id) == 'string' or type(user.id) == 'number') then
				GuiService:BroadcastNotification(WebApi.MakeReportUserUrl(user.id, convoId),
					GuiService:GetNotificationTypeList().REPORT_ABUSE)
			else
				print("Bad input to RequestNativeView, show error prompt here")
			end
		elseif optionId == PARTICIPANT_REMOVE then
			local messageArguments = {
				USERNAME = user.name,
			}
			self.removeUserDialog:Update(StringsLocale.Keys.REMOVE_USER_CONFIRMATION_MESSAGE, user, messageArguments)
			self.appState.store:Dispatch({
				type = ActionType.SetRoute,
				intent = Intent.RemoveUser,
				parameters = {
					conversationId = self.conversationId,
				},
			})
		end
	end)

	self.removeUserDialog = DialogComponents.ConfirmationDialog.new(appState,
		StringsLocale.Keys.REMOVE_USER, nil, StringsLocale.Keys.CANCEL, StringsLocale.Keys.REMOVE)
	self.removeUserDialog.rbx.Parent = self.rbx
	self.removeUserDialog.saved:Connect(function(user)
		local userId = user.id
		local convoId = self.conversation.id

		self.responseIndicator.rbx.Parent = self.rbx
		self.responseIndicator:SetVisible(true)

		local action = ConversationActions.RemoveUserFromConversation(userId, convoId, function()
			self.responseIndicator:SetVisible(false)
		end)
		self.appState.store:Dispatch(action)
	end)

	self.seeMore = SeeMoreButton.new(appState)
	self.seeMore.rbx.LayoutOrder = 9
	self.seeMore.rbx.Parent = content
	self.showAllParticipants = false
	self.seeMore.tapped:Connect(function()
		if self.showAllParticipants then
			self.showAllParticipants = false
			self:Update(appState.store:GetState())
		else
			self.showAllParticipants = true
			self:Update(appState.store:GetState())
		end
	end)

	self.blankSection = SectionComponent.new(appState)
	self.blankSection.rbx.LayoutOrder = 10
	self.blankSection.rbx.Parent = content

	self.leaveGroup = ActionEntryComponent.new(appState, getAsset("icons/ic-leave"), StringsLocale.Keys.LEAVE_GROUP)
	self.leaveGroup.rbx.LayoutOrder = 11
	self.leaveGroup.rbx.Parent = content
	self.leaveGroup.tapped.Event:Connect(function()
		self.appState.store:Dispatch({
			type = ActionType.SetRoute,
			intent = Intent.LeaveGroup,
			parameters = {
				conversationId = self.conversationId,
			},
		})
	end)

	content.ListLayout:ApplyLayout()

	self.leaveGroupDialog = DialogComponents.ConfirmationDialog.new(appState,
		StringsLocale.Keys.LEAVE_GROUP, StringsLocale.Keys.LEAVE_GROUP_MESSAGE,
		StringsLocale.Keys.STAY, StringsLocale.Keys.LEAVE)
	self.leaveGroupDialog.rbx.Parent = self.rbx
	self.leaveGroupDialog.saved:Connect(function()
		local userId = tostring(Players.LocalPlayer.UserId)
		local convoId = self.conversation.id

		self.responseIndicator.rbx.Parent = self.rbx
		self.responseIndicator:SetVisible(true)

		local action = ConversationActions.RemoveUserFromConversation(userId, convoId, function()
			self.responseIndicator:SetVisible(false)
		end)
		self.appState.store:Dispatch(action)
	end)

	self.conversation = ConversationModel.empty()

	self:Update(appState.store:GetState())

	local ancestryChangedConnection = self.rbx.AncestryChanged:Connect(function(rbx, parent)
		if rbx == self.rbx and parent == nil then
			self:Destruct()
		end
	end)
	table.insert(self.connections, ancestryChangedConnection)

	return self
end

function GroupDetail:Update(state)
	local conversation = state.Conversations[state.Location.current.parameters.conversationId]
	self.header:SetConnectionState(state.ConnectionState)
	if conversation ~= nil then --if conversation ~= self.conversation then
		if conversation.id ~= self.conversation.id then
			self.showAllParticipants = false
		end

		if conversation.isDefaultTitle then
			local notSetLocalized = self.appState.localization:Format(StringsLocale.Keys.NOT_SET)
			self.groupName:Update(notSetLocalized)
			self.groupNameDialog:Update("")
		else
			self.groupName:Update(conversation.title)
			self.groupNameDialog:Update(conversation.title)
		end

		local count = 0
		local users = Functional.Map(conversation.participants, function(userId)
			count = count + 1
			return (count <= 3 or self.showAllParticipants) and state.Users[userId] or nil
		end)

		if count > 3 and not self.showAllParticipants then
			local messageArguments = {
				NUMBER_OF_FRIENDS = tostring(count-3)
			}
			local message = self.appState.localization:Format(StringsLocale.Keys.SEE_MORE_FRIENDS, messageArguments)
			self.seeMore:Update(message)
			self.seeMore.rbx.Visible = true
		elseif count > 3 then
			self.seeMore:Update(self.appState.localization:Format(StringsLocale.Keys.SEE_LESS_FRIENDS))
			self.seeMore.rbx.Visible = true
		else
			self.seeMore.rbx.Visible = false
		end

		self.participantsList:Update(users)

		if conversation.initiator ~= self.conversation.initiator then
			if conversation.initiator == tostring(Players.LocalPlayer.UserId)
				and conversation.conversationType == ConversationModel.Type.MULTI_USER_CONVERSATION then
				self.participantDialog.optionGuis[PARTICIPANT_REMOVE].Visible = true
			else
				self.participantDialog.optionGuis[PARTICIPANT_REMOVE].Visible = false
			end
			self.participantDialog:Resize()
		end
		if conversation.conversationType == ConversationModel.Type.MULTI_USER_CONVERSATION then
			self.general.rbx.Visible = true
			self.groupName.rbx.Visible = true
			self.leaveGroup.rbx.Visible = true
			self.blankSection.rbx.Visible = true
		elseif conversation.conversationType == ConversationModel.Type.ONE_TO_ONE_CONVERSATION then
			self.general.rbx.Visible = false
			self.groupName.rbx.Visible = false
			self.leaveGroup.rbx.Visible = false
			self.blankSection.rbx.Visible = false
		end

		self.conversation = conversation
	end
	if self.oldState == nil or state.Location.current ~= self.oldState.Location.current then
		if state.Location.current.intent == Intent.EditGroupName then
			self.groupNameDialog:Prompt()
			self.groupNameDialog.textInputComponent.textBoxComponent:CaptureFocus()
		elseif state.Location.current.intent == Intent.ParticipantOptions then
			self.participantDialog:Prompt(state.Location.current.parameters.userId)
		elseif state.Location.current.intent == Intent.RemoveUser then
			self.removeUserDialog:Prompt()
		elseif state.Location.current.intent == Intent.LeaveGroup then
			self.leaveGroupDialog:Prompt()
		elseif self.oldState ~= nil and state.Location.current.intent == Intent.GroupDetail then
			if self.oldState.Location.current.intent == Intent.EditGroupName then
				self.groupNameDialog:Close()
			elseif self.oldState.Location.current.intent == Intent.ParticipantOptions then
				self.participantDialog:Close()
			elseif self.oldState.Location.current.intent == Intent.RemoveUser then
				self.removeUserDialog:Close()
			elseif self.oldState.Location.current.intent == Intent.LeaveGroup then
				self.leaveGroupDialog:Close()
			end
		end
	end
	local highestYValue = 0
	for _, element in pairs(self.rbx.ScrollingFrame.Content:GetChildren()) do
		if element:IsA("GuiObject") then
			highestYValue = highestYValue + element.Size.Y.Offset
		end
	end
	self.rbx.ScrollingFrame.CanvasSize = UDim2.new(1, 0, 0, highestYValue)
	self.rbx.ScrollingFrame.Content.Size = UDim2.new(1, 0, 0, highestYValue)

	self.oldState = state
end

function GroupDetail:Destruct()
	for _, connection in ipairs(self.connections) do
		connection:Disconnect()
	end

	self.connections = {}

	self.responseIndicator:Destruct()

	self.rbx:Destroy()
end

return GroupDetail
