//Punch

AddCSLuaFile()

hp_mstick.RegisterMagic("punch", {
	name = "Punch",
	delay = 0.3,
	cmd = "punch_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "punches your enemy",
	
	throwprop = function(ply)
		local tr = util.TraceLine {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 700,
			filter = ply
		}
	
		local ent = tr.Entity
		
		if IsValid(ent) and ent:IsPlayer() then
			ent:SetEyeAngles(Angle(math.random(0, 360), math.random(0, 360), 0))
			ent:SetVelocity(VectorRand() * 1000)
		end
	end,
	
	attack = function(ply, pos)
	end
})