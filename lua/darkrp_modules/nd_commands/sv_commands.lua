local function Donate(ply, text, team)
    if string.sub(text, 1, 7) == "!donate" then
        ply:SendLua( [[ gui.OpenURL("https://www.twitchalerts.com/donate/normaldifficulty") ]])
    end 
end
hook.Add( "PlayerSay", "Donate", Donate)