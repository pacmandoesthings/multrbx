local LuaChat = script.Parent.Parent
local Signal = require(LuaChat.Signal)
local Create = require(LuaChat.Create)
local ConversationEntry = require(LuaChat.Components.ConversationEntry)
local LoadingIndicator = require(LuaChat.Components.LoadingIndicator)

local ConversationList = {}

local function conversationSortPredicate(a, b)
	--For conversations that faked based on friend relations,
	--for now there is no meaningful lastUpdated value to give them,
	--and this property is set to nil, so the sort predicate needs to
	--be able to handle that.
	if a.lastUpdated ~= nil and b.lastUpdated ~= nil then
		return a.lastUpdated:GetUnixTimestamp() > b.lastUpdated:GetUnixTimestamp()
	elseif a.lastUpdated ~= nil then
		return true
	elseif b.lastUpdated ~= nil then
		return false
	else
		return a.title < b.title
	end
end

function ConversationList.new(appState, conversations)
	local self = {}
	self.appState = appState

	self.conversations = {}
	self.conversationEntries = {}
	self.conversationUsers = {}
	self.isTouchingBottom = false
	self.RequestOlderConversations = Signal.new()

	self.filterPredicate = nil

	self.ConversationTapped = Signal.new()
	self.lastTappedConversationEntry = nil
	self._oldState = nil

	self.rbx = Create.new "ScrollingFrame" {
		Name = "ConversationList",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 5,
		BottomImage = "rbxasset://textures/ui/LuaChat/9-slice/scroll-bar.png",
		MidImage = "rbxasset://textures/ui/LuaChat/9-slice/scroll-bar.png",
		TopImage = "rbxasset://textures/ui/LuaChat/9-slice/scroll-bar.png",

		Create.new "UIListLayout" {
			SortOrder = Enum.SortOrder.LayoutOrder
		}
	}

	self.convoLoadingIndicatorFrame = Create.new "Frame" {
			Name = "LoadingIndicatorFrame",
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 72),
			Visible = false
	}
	self.convoLoadingIndicatorFrame.Parent = self.rbx

	self.rbx:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
		if not self.isTouchingBottom and
			self.rbx.CanvasPosition.Y + self.rbx.AbsoluteSize.Y >= self.rbx.CanvasSize.Y.Offset then
			self.isTouchingBottom = true
			self.RequestOlderConversations:Fire()
		elseif self.rbx.CanvasPosition.Y + self.rbx.AbsoluteSize.Y < self.rbx.CanvasSize.Y.Offset then
			self.isTouchingBottom = false
		end
	end)

	appState.store.Changed:Connect(function(state, oldState)
		if not oldState.FetchingConversations and state.FetchingConversations then
			self:StartFetchingConversationsAnimation()
		elseif oldState.FetchingConversations and not state.FetchingConversations then
			self:StopFetchingConversationsAnimation()
		end
	end)

	setmetatable(self, ConversationList)

	if conversations then
		self:Update(self.appState.store:GetState(), {})
	end

	return self
end

function ConversationList:Update(current, previous)
	local users = current.Users
	local conversations = current.Conversations

	for _, conversation in pairs(conversations) do
		local existing = self.conversations[conversation.id]
		local existingEntry = self.conversationEntries[conversation.id]
		local userCache = self.conversationUsers[conversation.id]

		local doUpdate = false

		if conversation ~= existing or current.Location.current ~= previous.Location.current then
			doUpdate = true
		else
			if userCache then
				for _, id in ipairs(conversation.participants) do
					if userCache[id] ~= users[id] then
						doUpdate = true
						break
					end
				end
			else
				doUpdate = true
			end
		end

		if not userCache then
			userCache = {}
			self.conversationUsers[conversation.id] = userCache
		end

		if doUpdate then
			if existingEntry then
				existingEntry:Update(conversation)
			else
				local entry = ConversationEntry.new(self.appState, conversation)
				entry.rbx.Parent = self.rbx
				entry.Tapped:Connect(function()
					self.ConversationTapped:Fire(conversation.id)
				end)

				self.conversationEntries[conversation.id] = entry
			end

			self.conversations[conversation.id] = conversation

			-- TODO: May not correctly handle users leaving?
			for _, id in ipairs(conversation.participants) do
				userCache[id] = users[id]
			end
		end
	end

	local toDelete = {}
	for _, conversation in pairs(self.conversations) do
		local hasBeenRemoved = conversations[conversation.id] == nil
		if hasBeenRemoved then
			table.insert(toDelete, conversation.id)
		end
	end
	for _, id in ipairs(toDelete) do
		local entry = self.conversationEntries[id]
		entry.rbx:Destroy()
		self.conversationEntries[id] = nil
		self.conversations[id] = nil
	end

	self:Filter()
	self:Sort()
	self:ResizeCanvas()

	self._oldState = current
end

function ConversationList:SetFilterPredicate(filterPredicate)
	self.filterPredicate = filterPredicate

	local state = self.appState.store:GetState()
	self:Update(state, self._oldState or state)
end

function ConversationList:Filter()
	for _, conversationEntry in pairs(self.conversationEntries) do
		local conversation = conversationEntry.conversation
		local filterPredicate = self.filterPredicate
		if filterPredicate and conversation then
			conversationEntry.rbx.Visible = filterPredicate(conversation.title)
		else
			conversationEntry.rbx.Visible = true
		end
	end
end

function ConversationList:Sort()
	local sorted = {}
	for _, conversation in pairs(self.conversations) do
		table.insert(sorted, conversation)
	end

	table.sort(sorted, conversationSortPredicate)

	for key, conversation in ipairs(sorted) do
		local entry = self.conversationEntries[conversation.id]
		entry.rbx.LayoutOrder = key
	end

	self.convoLoadingIndicatorFrame.LayoutOrder = #sorted + 1
end

function ConversationList:ResizeCanvas()
	local height = 0
	for _, entry in pairs(self.conversationEntries) do
		if entry.rbx.Visible then
			height = height + entry.rbx.AbsoluteSize.Y
		end
	end

	if self.convoLoadingIndicatorFrame.Visible then
		height = height + self.convoLoadingIndicatorFrame.AbsoluteSize.Y
	end

	self.rbx.CanvasSize = UDim2.new(1, 0, 0, height)
end

function ConversationList:StartFetchingConversationsAnimation()
	if not self.currentFetchConvoIndicator then
		local loadingIndicator = LoadingIndicator.new(self.appState, 1)
		loadingIndicator.rbx.AnchorPoint = Vector2.new(0.5, 0.5)
		loadingIndicator.rbx.Position = UDim2.new(0.5, 0, 0.5, 0)
		loadingIndicator.rbx.Parent = self.convoLoadingIndicatorFrame

		self.currentFetchConvoIndicator = loadingIndicator

		self.convoLoadingIndicatorFrame.Visible = true

		self:ResizeCanvas()
		self:Sort()
	end
end

function ConversationList:StopFetchingConversationsAnimation()
	if self.currentFetchConvoIndicator then
		self.currentFetchConvoIndicator:Destroy()
		self.currentFetchConvoIndicator = nil
		self.convoLoadingIndicatorFrame.Visible = false

		self:ResizeCanvas()
	end
end

ConversationList.__index = ConversationList

return ConversationList