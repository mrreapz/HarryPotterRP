//Accio

AddCSLuaFile()

hp_mstick.RegisterMagic("accio", {
	name = "Accio",
	delay = 0.5,
	cmd = "accio",
	codeauthor = "HK47",
	desc = "pull anything",
	
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
		
		if IsValid(ent) and IsValid(ent:GetPhysicsObject()) then
			ent:GetPhysicsObject():SetVelocity(-ply:GetAimVector() * 2000)
			
			timer.Simple(7, function()
				if not IsValid(ent) then return end
			
				hook.Remove("Think", "SetVelOfS" .. ent:EntIndex())
			end)
			
			hook.Add("Think", "SetVelOfS" .. ent:EntIndex(), function()
				if not IsValid(ent) then hook.Remove("Think", "SetVelOfS" .. ent:EntIndex()) return end
			
				if ent:GetPos():Distance(ply:GetPos()) <= 120 then
					ent:GetPhysicsObject():SetVelocity(Vector(0, 0, 0))
					hook.Remove("Think", "SetVelOfS" .. ent:EntIndex())
				end
			end)
			
			if not ent:IsNPC() or not ent:IsPlayer() then ent:GetPhysicsObject():AddAngleVelocity(VectorRand() * 360) end
		end
	end
})
