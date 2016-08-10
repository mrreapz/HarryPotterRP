//Impedimenta

AddCSLuaFile()

hp_mstick.RegisterMagic("impedimenta", {
	name = "Impedimenta",
	delay = 1.8,
	cmd = "impedimenta_hp",
	codeauthor = "HK47",
	desc = "changes speed of your enemy",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetOwner(ply)
		spell:Spawn()
		
		//settings
		spell:SetNWVector("SpellColor", Vector(0, 255, 255))
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		if IsValid(ent) and ent:IsPlayer() and not ent:GetNWBool("SpellImpSet") then		
			ent:SetNWFloat("SpellImpGetSpeed", ent:GetWalkSpeed())
			ent:SetNWFloat("SpellImpGetSpeedR", ent:GetRunSpeed())
			ent:SetNWBool("SpellImpSet", true)
			
			ent:SetWalkSpeed(ent:GetWalkSpeed() / 2)
			ent:SetRunSpeed(ent:GetRunSpeed() / 2)
			
			timer.Create("set_speed" .. ent:EntIndex(), 10, 1, function()
				if not ent:Alive() then
					hook.Add("PlayerSpawn", "ifnotchange" .. ent:EntIndex(), function(ply)
						if ply == ent then
							timer.Simple(0.2, function()
								ent:SetNWBool("SpellImpSet", false)
								
								hook.Remove("PlayerSpawn", "ifnotchange" .. ent:EntIndex())
							end)
						end
					end)
				end
			
				if IsValid(ent) then
					ent:SetWalkSpeed(ent:GetNWFloat("SpellImpGetSpeed"))
					ent:SetRunSpeed(ent:GetNWFloat("SpellImpGetSpeedR"))
					ent:SetNWBool("SpellImpSet", false)
				end
			end)
		end
	end
})
