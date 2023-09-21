--loadstring(game:GetObjects("rbxassetid://382365669")[1].Source)()

local msg = Instance.new("Message",workspace)
msg.Text = "GET HACKED YOU FUCKING BOZOS"
wait(2)
msg:Destroy()
------C0RRUPTION SERVER DESTRUCTION SCRIPT
------SPREAD THE C0RRUPTION




































































for i,v in pairs(game.Players:GetChildren()) do game:GetService("Chat"):Chat(v.Character.Head,"SPREAD THE C0RRUPTION \n SPREAD THE C0RRUPTION \n SPREAD THE C0RRUPTION \n SPREAD THE C0RRUPTION \n SPREAD THE C0RRUPTION") end

function a(b) 
for i,v in next, b:GetChildren() do
if v:IsA("Part") then
bbg = Instance.new("BillboardGui")
bbg.Adornee=v
bbg.Parent=v
bbg.Size=UDim2.new(3,0,3,0)
bbg.StudsOffset=Vector3.new(0,2,0)
fr = Instance.new("Frame", bbg)
fr.BackgroundTransparency=1
fr.Size=UDim2.new(1,0,1,0)
tl = Instance.new("TextLabel", fr)
tl.FontSize="Size48"
tl.BackgroundTransparency=1
tl.Text="SPREAD THE C0RRUPTION"
tl.TextColor3=Color3.new(0.5,0,255)
tl.Size=UDim2.new(1,0,1,0)
end
a(v)
end
end
a(workspace)

game.Lighting.TimeOfDay = "14"
game.Lighting.Brightness = 0
game.Lighting.Ambient=Color3.new(0.5,0,1);
game.Lighting.FogEnd=100;
game.Lighting.FogColor=Color3.new(0.5,0,1);
game.Workspace.Terrain.WaterColor=Color3.new(0.5,0,1);
o1 = Instance.new("Sky")
o1.Name = "Desert Sky"
o1.Parent = game.Lighting
o1.SkyboxBk = "http://www.roblox.com/asset/?id=701987397"
o1.SkyboxDn = "http://www.roblox.com/asset/?id=701987397"
o1.SkyboxFt = "http://www.roblox.com/asset/?id=701987397"
o1.SkyboxLf = "http://www.roblox.com/asset/?id=701987397"
o1.SkyboxRt = "http://www.roblox.com/asset/?id=701987397"
o1.SkyboxUp = "http://www.roblox.com/asset/?id=701987397"

WARSOUNDS = true -- plays war sounds
-------------------------
if WARSOUNDS == true then
myears = Instance.new('Sound')
myears.Parent = workspace
myears.Looped = true
myears.Name = "Darude on meth"
myears.Playing = true
myears.SoundId = "rbxassetid://259174997"
myears.Volume = 10
myears.TimePosition = 0
end

local ID =701987397 --id here
function spamDecal(v)
	if v:IsA("Part") then
		for i=0, 5 do
			D = Instance.new("Decal")
			D.Name = "MYDECALHUE"
			D.Face = i
			D.Parent = v
			D.Texture = ("http://www.roblox.com/asset/?id="..Id)
		end
	else
		if v:IsA("Model") then
			for a,b in pairs(v:GetChildren()) do
				spamDecal(b)
			end
		end
	end
end
function decalspam(id) --use this function, not the one on top
	Id = id
	for i,v in pairs(game.Workspace:GetChildren()) do
		if v:IsA("Part") then
		for i=0, 5 do
			D = Instance.new("Decal")
			D.Name = "MYDECALHUE"
			D.Face = i
			D.Parent = v
			D.Texture = ("http://www.roblox.com/asset/?id="..id)
		end
	else
		if v:IsA("Model") then
			for a,b in pairs(v:GetChildren()) do
				spamDecal(b)
			end
		end
	end
end
end

decalspam(ID)

colorc=Instance.new("ColorCorrectionEffect",game.Lighting)
wait()
spawn(function()
   while wait() do
       colorc.Contrast=math.random(-1,1)
       colorc.Saturation=math.random(-1,1)
       colorc.TintColor = Color3.new(0.5, 0, 1)
   end
end)

Scale = 0.3


function DarkColor(Source)
	for _, Part in pairs(Source:GetChildren()) do
		if Part:IsA("Clothing") or Part:IsA("CharacterMesh") or Part:IsA("BodyColors") or Part:IsA("Decal") or Part:IsA("Texture") or Part:IsA("ShirtGraphic") or Part:IsA("CylinderMesh") or Part:IsA("BlockMesh") then
			Part:Remove()
		elseif Part:IsA("BasePart") then
			if Part:FindFirstChild("Mesh") == nil then
				local Mesh = Instance.new("SpecialMesh", Part)
				Mesh.MeshType = "FileMesh"
				Mesh.MeshId = "http://www.roblox.com/Asset/?id=9856898"
				Mesh.TextureId = "http://www.roblox.com/Asset/?id=48358980"
				Mesh.Scale = Part.Size * 2
				Mesh.VertexColor = Vector3.new(Part.BrickColor.r, Part.BrickColor.g, Part.BrickColor.b)
				Part.BrickColor = BrickColor.new("Institutional white")
			end
			if Part:FindFirstChild("Direction") == nil then
				local Direction = Instance.new("BoolValue", Part)
				Direction.Name = "Direction"
				Direction.Value = math.random(1, 2) == 1 and false or true
			end
			if Part:FindFirstChild("") == nil then
				local Increment = Instance.new("NumberValue", Part)
				Increment.Name = "Increment"
				Increment.Value = math.random(0, 1000) / 1000
			end
			if Part:FindFirstChild("OriginalColor") == nil then
				local OriginalColor = Instance.new("Vector3Value", Part)
				OriginalColor.Name = "OriginalColor"
				OriginalColor.Value = Part.Mesh.VertexColor
			end
			if Part.Increment.Value <= 0 then
				Part.Direction.Value = true
			elseif Part.Increment.Value >= 1 then
				Part.Direction.Value = false
			end
			Part.Increment.Value = Part.Increment.Value + (Scale * (Part.Direction.Value and 1 or -1))
			Part.Mesh.VertexColor = Part.OriginalColor.Value * Part.Increment.Value
		end
		DarkColor(Part)
	end
end


while true do
	DarkColor(Workspace)
	wait()
end



















































------C0RRUPTION SERVER DESTRUCTION SCRIPT
------SPREAD THE C0RRUPTION