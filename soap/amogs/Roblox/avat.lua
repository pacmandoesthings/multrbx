
function start(playerid,baseurl)
    pcall(function() game:GetService("ContentProvider"):SetBaseUrl(baseurl) end)
    game:GetService("ScriptContext").ScriptsDisabled = true
    local plr = game.Players:CreateLocalPlayer(0)
    local BaseUrl = game:GetService("ContentProvider").BaseUrl:lower()
    plr.CharacterAppearance = BaseUrl .. "/Tools/FetchCharacterAppeareance.aspx?id="..playerid
    plr:LoadCharacter(false)
    for i,v in pairs(plr.Character:GetChildren()) do
        print(v)
        if v:IsA("Tool") then
            plr.Character.Torso["Right Shoulder"].CurrentAngle = math.pi / 2
        end
    end

    return game:GetService("ThumbnailGenerator"):Click("PNG", 300, 300, true)

end