//Gonfiare

AddCSLuaFile()

hp_mstick.RegisterMagic("gonfiare", {
	name = "Gonfiare",
	delay = 1,
	cmd = "gonfiare_hp",
	codeauthor = "HK47",
	nodefault = true,
	adminonly = true,
	desc = "blow ups your enemy",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetAngles(ply:EyeAngles())
		spell:SetOwner(ply)
		spell:Spawn()
		
		//settings
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
		spell:SetNWVector("SpellColor", Vector(170, 255, 100))
		spell:SetNWFloat("SpellSize", 7)
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		if IsValid(ent) and ent:IsPlayer() or ent:IsNPC() then
			local sc = 1
			
			timer.Create("kill_gonfiare" .. ent:EntIndex(), 2, 1, function()
				if IsValid(ent) then
					local ef = EffectData()
					ef:SetOrigin(ent:GetPos())
					util.Effect("explosion", ef)
					
					for i = 1, ent:GetBoneCount() - 1 do
						ent:ManipulateBoneScale(i, Vector(1, 1, 1))
					end
				
					ent:SetPos(Vector(0, 0, 99999) + VectorRand() * 1000)
					
					if ent:IsPlayer() then
						ent:Kill()
					elseif ent:IsNPC() then
						ent:Fire("sethealth", "0", 0)
					end
				end
			end)
		
			timer.Create("gonfiare_hp" .. ent:EntIndex(), 0.01, 0, function()
				if ent:IsPlayer() and not ent:Alive() then
					timer.Stop("gonfiare_hp" .. ent:EntIndex())
					return
				end
			
				if IsValid(ent) then
					sc = sc + 0.01
					for i = 1, ent:GetBoneCount() - 1 do
						ent:ManipulateBoneScale(i, Vector(sc, sc, sc))
					end
				else
					timer.Stop("gonfiare_hp" .. ent:EntIndex())
				end
			end)
		end
	end
})