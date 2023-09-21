
x = 48
y = 48
baseurl = "http://mulrbx.com"

  local quadratic = false
    local baseHatZoom = 30
    local maxHatZoom = 100
    local cameraOffsetX = 0
    local cameraOffsetY = 0
    local maxDimension = 0


function start(userId)
characterAppearanceUrl = "https://mulrbx.com/Tools/FetchCharacterAppeareance.aspx?id="..userId
local player = game:GetService("Players"):CreateLocalPlayer(0)
player.CharacterAppearance = characterAppearanceUrl
player:LoadCharacter(false)

local maxDimension = 0

if player.Character then
    -- Remove gear
    for _, child in pairs(player.Character:GetChildren()) do
        if child:IsA("Tool") then
            child:Destroy()
        elseif child:IsA("Accoutrement") then
            local size = child.Handle.Size / 2 + child.Handle.Position - player.Character.Head.Position
            local xy = Vector2.new(size.x, size.y)
            if xy.magnitude > maxDimension then
                maxDimension = xy.magnitude
            end
        end
    end

    -- Setup Camera
    local maxHatOffset = 0.5 -- Maximum amount to move camera upward to accomodate large hats
    maxDimension = math.min(1, maxDimension / 3) -- Confine maxdimension to specific bounds

    if quadratic then
        maxDimension = maxDimension * maxDimension -- Zoom out on quadratic interpolation
    end

    local viewOffset     = player.Character.Head.CFrame * CFrame.new(cameraOffsetX, cameraOffsetY + maxHatOffset * maxDimension, 0.1) -- View vector offset from head
    local positionOffset = player.Character.Head.CFrame + (CFrame.Angles(0, -math.pi / 16, 0).lookVector.unit * 3) -- Position vector offset from head

    local camera = Instance.new("Camera", player.Character)
    camera.Name = "ThumbnailCamera"
    camera.CameraType = Enum.CameraType.Scriptable
    camera.CoordinateFrame = CFrame.new(positionOffset.p, viewOffset.p)
    camera.FieldOfView = baseHatZoom + (maxHatZoom - baseHatZoom) * maxDimension
end

return game:GetService("ThumbnailGenerator"):Click("PNG", 300, 300,  true)
end