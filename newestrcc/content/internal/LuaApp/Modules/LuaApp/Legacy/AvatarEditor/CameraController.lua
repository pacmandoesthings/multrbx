local CoreGui = game:GetService("CoreGui")

local currentCameraPosition = Vector3.new(7.2618074, 4.74155569, -22.701086)
local currentCameraFocusPoint = Vector3.new(15.2762003, 3.28499985, -16.8211994)
local currentCameraFov = 0
local cameraCenterScreenPosition

local this = {}
local cameraTweener = nil


local function getScreenSize()
	return game.Workspace.CurrentCamera.ViewportSize
end


function this.init(Store, inCameraTweener, inCameraCenterScreenPosition)
	cameraTweener = inCameraTweener
	cameraCenterScreenPosition = inCameraCenterScreenPosition
	Store.Changed:Connect(
		function(newState, oldState)
			if newState.FullView ~= oldState.fullView then
				if newState.FullView == true then
					this.tweenCameraToFullView()
				else
					this.tweenCameraToPageView()
				end
			end
		end
	)
end


local function tweenCameraIntoPlace(position, focusPoint, targetFOV)
	local aspectRatio = getScreenSize().X / getScreenSize().Y

	local fy = 0.5 * targetFOV * math.pi / 180.0 -- half vertical field of view (in radians)
	local fx = math.atan( aspectRatio * math.tan(fy) ) -- half horizontal field of view (in radians)

	local anglesX = math.atan( cameraCenterScreenPosition.X * math.tan(fx) )
	local anglesY = math.atan( cameraCenterScreenPosition.Y * math.tan(fy) )

	local targetCFrame
		= CFrame.new(position)
		* CFrame.Angles(0,anglesX,0)
		* CFrame.new(Vector3.new(), focusPoint-position)
		* CFrame.Angles(anglesY,0,0)

	cameraTweener.tweenCamera(targetCFrame, targetFOV)
end


local fullView = false

function this.tweenCameraToFullView()
	fullView = true

	local targetCFrame = CFrame.new(
		13.2618074,   4.74155569,  -22.701086,
		-0.94241035,  0.0557777137, -0.329775006,
		 0.000000000, 0.98599577,    0.166770056,
		 0.334458828, 0.157165825,  -0.92921263)

	cameraTweener.tweenCamera(targetCFrame, 70)
end


function this.tweenCameraToPageView()
	fullView = false

	tweenCameraIntoPlace(
		currentCameraPosition,
		currentCameraFocusPoint,
		currentCameraFov)
end


function this.updatePageCamera(position, focusPoint, fov)
	currentCameraPosition = position
	currentCameraFocusPoint = focusPoint
	currentCameraFov = fov

	if not fullView then
		tweenCameraIntoPlace(position, focusPoint, fov)
	end
end


return this
