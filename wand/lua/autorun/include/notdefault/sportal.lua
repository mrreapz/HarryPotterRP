//Sportal

AddCSLuaFile()

hp_mstick.RegisterMagic("sportal", {
	name = "Sportal",
	delay = 2,
	cmd = "sportal_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "makes portal with stones",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetOwner(ply)
		spell:Spawn()
		
		//settings
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
		spell:SetNWVector("SpellColor", Vector(255, 0, 255))
	end,
	
	attack = function(ply, pos)
		local norm = pos.HitNormal
		local p = pos.HitPos
		
		local ef = EffectData()
		ef:SetOrigin(p + (-norm * 3))
		ef:SetNormal(norm)
		util.Effect("effect_portal_hp", ef)
		
		timer.Simple(3, function()
			timer.Create("spawn_stone" .. math.random(1, 1337), 0.2, 20, function()
				local ent = ents.Create("entity_stone_hp")
				ent:SetPos(p + (-norm * 20))
				ent:SetOwner(ply)
				ent:Spawn()
				
				timer.Simple(6, function()
					if not IsValid(ent) then return end
					
					ent:Remove()
				end)
				
				local phys = ent:GetPhysicsObject()
				
				if IsValid(phys) then
					phys:AddAngleVelocity(VectorRand() * 360)
					phys:SetVelocity(-norm * 2000)
				end
			end)
		end)
	end
})
