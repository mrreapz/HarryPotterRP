//Everte Statum

AddCSLuaFile()

hp_mstick.RegisterMagic("everte_statum", {
	name = "Everte statum",
	delay = 0.6,
	cmd = "everte_statum_hp",
	codeauthor = "HK47",
	desc = "pushes things",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetOwner(ply)
		spell:Spawn()
		
		//settings
		spell:SetNWVector("SpellColor", Vector(255, 150, 0))
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		if ent:IsPlayer() or ent:IsNPC() then
			ent:SetVelocity((ply:GetAimVector() * 2000) + vector_up * 1000) 
			return
		end
		
		if IsValid(ent) and IsValid(ent:GetPhysicsObject()) then
			ent:GetPhysicsObject():SetVelocity((ply:GetAimVector() * 2000) + vector_up * 1000) 
			ent:GetPhysicsObject():AddAngleVelocity(VectorRand() * 360)
		end
	end
})
