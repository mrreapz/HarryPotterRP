//Perfectium

AddCSLuaFile()

hp_mstick.RegisterMagic("perfectium", {
	name = "Perfectium",
	delay = 0.8,
	cmd = "perfectium_hp",
	codeauthor = "HK47",
	nodefault = true,
	adminonly = true,
	desc = "blow ups your enemy's head",
	
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
		spell:SetNWVector("SpellColor", Vector(255, 150, 0))
		spell:SetNWFloat("SpellSize", 7)
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		if IsValid(ent) and ent:IsPlayer() or ent:IsNPC() then
			timer.Create("perfectium_hp" .. ent:EntIndex(), 0.006, 0, function()
				if ent:IsPlayer() and not ent:Alive() then
					timer.Stop("perfectium_hp" .. ent:EntIndex())
					return
				end
			
				if IsValid(ent) then
					if ent:Health() < 300 then
						ent:SetHealth(ent:Health() + 1)
						
						local col = 255 - (ent:Health() * 0.85)
						ent:SetColor(Color(col + (ent:Health() * 0.85), col, col))
						
						local bone = ent:LookupBone("ValveBiped.Bip01_Head1")
						if bone then
							local sc = 2 + math.abs(math.sin(CurTime() * 3) * 2)
							ent:ManipulateBoneScale(bone, Vector(sc, sc, sc))
						end
					else
						ent:SetColor(Color(255, 255, 255))
						
						local bone = ent:LookupBone("ValveBiped.Bip01_Head1")
						if bone then
							ent:ManipulateBoneScale(bone, Vector(1, 1, 1))
						end
						
						if ent:IsPlayer() then
							ent:Kill()
						elseif ent:IsNPC() then
							ent:Fire("sethealth", "0", 0)
						end
					end
				else
					timer.Stop("perfectium_hp" .. ent:EntIndex())
				end
			end)
		end
	end
})