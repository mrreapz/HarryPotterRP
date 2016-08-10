//Aguamenti

AddCSLuaFile()

hp_mstick.RegisterMagic("aguamenti", {
	name = "Aguamenti",
	delay = 0.3,
	cmd = "aguamenti_hp",
	codeauthor = "HK47",
	desc = "makes water",
	
	throwprop = function(ply)
		local ang = ply:EyeAngles()
		local vector = ply:GetAimVector()
		
		local ent = ents.Create("entity_water_hp")
		ent:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 25 - ang:Up() * 5)
		ent:Spawn()
		
		local phys = ent:GetPhysicsObject()
		
		if IsValid(phys) then
			phys:SetVelocity(vector * 3000)
		end
	end,
	
	attack = function(ply, pos)
	end
})
