//Vulnera sanentur

AddCSLuaFile()

hp_mstick.RegisterMagic("vulnera_sanentur", {
	name = "Vulnera sanentur",
	delay = 1.5,
	cmd = "vulnera_sanentur_hp",
	codeauthor = "HK47",
	desc = "heals you or thing on that you're looking",
	
	throwprop = function(ply)
		local tr = util.TraceHull {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 450,
			filter = ply,
			mins = Vector(-15, -15, -15),
			maxs = Vector(15, 15, 15)
		}
	
		local ent = tr.Entity
		
		if IsValid(ent) then
			if ent:IsPlayer() or ent:IsNPC() then
				ent:SetHealth(math.min(ent:GetMaxHealth(), ent:Health() + 25))
				
				return
			end
		end
		
		ply:SetHealth(math.min(ply:GetMaxHealth(), ply:Health() + 25))
	end,
	
	attack = function(ply, pos)
	end
})
