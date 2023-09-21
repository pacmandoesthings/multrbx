function start(assetid,baseurl)
    game:GetService("ContentProvider"):SetBaseUrl(baseurl)
    game:GetService("ScriptContext").ScriptsDisabled = true
    local plr = game.Players:CreateLocalPlayer(0)
    local BaseUrl = game:GetService("ContentProvider").BaseUrl:lower()
    plr.CharacterAppearance = "http://mulrbx.com/Tools/getchar.aspx?id="..assetid
    plr:LoadCharacter(false)

    return game:GetService("ThumbnailGenerator"):Click("PNG", 1920, 1920, true)
end