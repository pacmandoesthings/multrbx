local Modules = script.Parent

local ActionType = require(Modules.ActionType)

local NotificationService = game:GetService("NotificationService")

local NavigationEventReceiver = {}

function NavigationEventReceiver:init(appState)

	local function onNaviationNotifications(eventData)
		if eventData.detailType == "Destination" then
			appState.store:Dispatch( {type = ActionType.OpenApp, appName = eventData.detail} )
		end
	end

	local function onRobloxEventReceived(eventData)
		if eventData.namespace == "Navigations" then
			onNaviationNotifications(eventData)
		end
	end

	NotificationService.RobloxEventReceived:connect(onRobloxEventReceived)
end

return NavigationEventReceiver
