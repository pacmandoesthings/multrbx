
local LuaChat = script.Parent
local ActionType = require(LuaChat.ActionType)

local Device = {}

Device.FormFactor = {
	UNKNOWN = "UNKNOWN",
	TABLET = "TABLET",
	PHONE = "PHONE",
}

function Device.Init(store)

	local formFactor = Device.FormFactor.PHONE
	local function setFormFactor(viewportSize)
		if viewportSize.X == 1 then
			--Camera.ViewportSize hasn't been properly set yet
			formFactor = Device.FormFactor.UNKNOWN
		elseif viewportSize.Y > viewportSize.X then
			formFactor = Device.FormFactor.PHONE
		else
			formFactor = Device.FormFactor.TABLET
		end
		store:Dispatch({
			type = ActionType.SetFormFactor,
			formFactor = formFactor,
		})
	end
	local camera = game.Workspace:WaitForChild("Camera")
	setFormFactor(camera.ViewportSize)
	camera.Changed:Connect(function(prop)
		if prop == "ViewportSize" then
			setFormFactor(camera.ViewportSize)
		end
	end)
end

return Device