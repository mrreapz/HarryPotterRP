//Waddiwasi

AddCSLuaFile()

hp_mstick.RegisterMagic("waddiwasi", {
	name = "Waddiwasi",
	delay = 0.5,
	cmd = "waddiwasi_hp",
	codeauthor = "HK47",
	desc = "pushes objects to your enemy",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetOwner(ply)
		spell:Spawn()
		
		//settings
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		local enemy
		
		if IsValid(ent) and IsValid(ent:GetPhysicsObject()) then
			for k, v in pairs(ents.FindInSphere(ent:GetPos(), 1200)) do
				if v != ply and (v:IsNPC() or v:IsPlayer()) then
					enemy = v
					break
				end
			end
			
			if not enemy then return end
			
			ent:GetPhysicsObject():SetVelocity((enemy:GetPos() - ent:GetPos()):GetNormal() * 99999)
			ent:GetPhysicsObject():AddAngleVelocity(VectorRand() * 360)
		end
	end
})