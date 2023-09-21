--[[
	Defines a set of tweens and default lifecycle handlers appropriate for this
	platform.
]]

local Modules = script.Parent.Parent.Parent
local Constants = require(Modules.Constants)
local Device = require(Modules.Device)

local BaseView = require(Modules.BaseView)

local BaseScreen = BaseView:Template()

--Constants
local RIGHT_SIDE = UDim2.new(1, 0, 0, 0)
local LEFT_SIDE = UDim2.new(-1, 0, 0, 0)
local CENTER = UDim2.new(0, 0, 0, 0)

function BaseScreen:Start()
	if self.appState.store:GetState().FormFactor == Device.FormFactor.TABLET then
		return
	end
	local viewStack = self.appState.screenManager:GetViewStack()

	-- If we're the only view, we don't need to animate in
	if #viewStack == 1 and viewStack[1] == self then
		self.rbx.Position = CENTER
	else
		self.rbx.Position = RIGHT_SIDE
		self.rbx:TweenPosition(CENTER, Constants.Tween.PHONE_TWEEN_DIRECTION,
			Constants.Tween.PHONE_TWEEN_STYLE, Constants.Tween.PHONE_TWEEN_TIME, true)
	end
end

function BaseScreen:Stop()
	if self.appState.store:GetState().FormFactor == Device.FormFactor.TABLET then
		self.rbx.Parent = nil
		return
	end
	self.rbx.Position = CENTER
	self.rbx:TweenPosition(RIGHT_SIDE, Constants.Tween.PHONE_TWEEN_DIRECTION,
		Constants.Tween.PHONE_TWEEN_STYLE, Constants.Tween.PHONE_TWEEN_TIME, true,
		function()
			-- Once we are fully tweened out we can unparent ourselves and save rendering time
			self.rbx.Parent = nil
		end)
end

function BaseScreen:Resume()
	if self.appState.store:GetState().FormFactor == Device.FormFactor.TABLET then
		return
	end
	self.rbx.Position = LEFT_SIDE
	self.rbx:TweenPosition(CENTER, Constants.Tween.PHONE_TWEEN_DIRECTION,
		Constants.Tween.PHONE_TWEEN_STYLE, Constants.Tween.PHONE_TWEEN_TIME, true)
end

function BaseScreen:Pause()
	if self.appState.store:GetState().FormFactor == Device.FormFactor.TABLET then
		return
	end
	self.rbx.Position = CENTER
	self.rbx:TweenPosition(LEFT_SIDE, Constants.Tween.PHONE_TWEEN_DIRECTION,
		Constants.Tween.PHONE_TWEEN_STYLE, Constants.Tween.PHONE_TWEEN_TIME, true)
end

return BaseScreen