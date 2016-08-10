//Episkey

AddCSLuaFile()

hp_mstick.RegisterMagic("episkey", {
	name = "Episkey",
	delay = 1.5,
	cmd = "episkey_hp",
	codeauthor = "HK47",
	desc = "heals you or thing on that you're looking",
	
	throwprop = function(ply)
		local tr = util.TraceHull {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 500,
			filter = ply,
			mins = Vector(-20, -20, -20),
			maxs = Vector(20, 20, 20)
		}
	
		local ent = tr.Entity
		
		if IsValid(ent) then
			if ent:IsPlayer() or ent:IsNPC() then
				ent:SetHealth(math.min(ent:GetMaxHealth(), ent:Health() + 20))
				
				return
			end
		end
		
		ply:SetHealth(math.min(ply:GetMaxHealth(), ply:Health() + 20))
	end,
	
	attack = function(ply, pos)
	end
})
