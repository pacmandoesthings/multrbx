--





local coreGui = game:GetService("CoreGui")
local robloxGui = coreGui:FindFirstChild("RobloxGui")
local scriptContext = game:GetService("ScriptContext")
local serverStorage = game:GetService('ServerStorage')
local starterGui = game:GetService('StarterGui')







local screenGuiV2 = serverStorage:WaitForChild('ScreenGuiV2')
screenGuiV2.Name = 'ScreenGui'
screenGuiV2.Parent = starterGui
scriptContext:AddCoreScriptLocal("AvatarStarterScriptV2", robloxGui)









