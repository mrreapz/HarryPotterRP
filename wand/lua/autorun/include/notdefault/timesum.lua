//Timesum

AddCSLuaFile()

hp_mstick.RegisterMagic("timesum", {
	name = "Timesum",
	delay = 3,
	cmd = "timesum_hp",
	codeauthor = "HK47",
	nodefault = true,
	adminonly = true,
	desc = "changes time",
	
	throwprop = function(ply)
		game.SetTimeScale(0.1)
		
		timer.Simple(0.5, function() game.SetTimeScale(1) end)
	end,
	
	attack = function(ply, pos)
	end
})