//Stors

AddCSLuaFile()

hp_mstick.RegisterMagic("stors", {
	name = "Stors",
	delay = 2.3,
	cmd = "stors_hp",
	codeauthor = "HK47",
	nodefault = true,
	fulladminonly = true,
	desc = "makes spell storm",
	
	throwprop = function(ply)
		local tr = ply:GetEyeTrace()
		
		tr = util.TraceLine {
			start = tr.HitPos,
			endpos = tr.HitPos,
			filter = ply
		}
		
		timer.Create("spawn_storm" .. ply:EntIndex(), 0.1, 55, function()
			if not IsValid(ply) then return end
		
			local tab = hp_mstick.GetMagic()
			local mag = tab[1]
			
			mag.throwprop(ply)
		end)
	end,
	
	attack = function(ply, pos)
	end
})