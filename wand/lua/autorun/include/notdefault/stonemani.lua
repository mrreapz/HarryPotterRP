//Stonemani

AddCSLuaFile()

hp_mstick.RegisterMagic("stonemani", {
	name = "Stonemani",
	delay = 1.5,
	cmd = "stonemani_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "makes stone with boom",
	
	throwprop = function(ply)
		local ang = ply:EyeAngles()
		local vector = ply:GetAimVector()
		
		local ent = ents.Create("entity_stone_hp")
		ent:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 50 - ang:Up() * 5)
		ent:SetOwner(ply)
		ent:Spawn()
		
		local phys = ent:GetPhysicsObject()
		
		if IsValid(phys) then
			phys:SetVelocity(vector * 6000)
			phys:AddAngleVelocity(VectorRand() * 360)
		end
	end,
	
	attack = function(ply, pos)
	end
})
