//Crucio

AddCSLuaFile()

hp_mstick.RegisterMagic("crucio", {
	name = "Crucio",
	delay = 2.3,
	cmd = "crucio_hp",
	codeauthor = "HK47",
	adminonly = true,
	desc = "makes your enemy ragdoll and takes pain",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetOwner(ply)
		spell:Spawn()
		
		//settings
		spell:SetNWVector("SpellColor", Vector(255, 0, 0))
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		local npcs = {
			"npc_metropolice",
			"CombinePrison",
			"PrisonShotgunner",
			"ShotgunSoldier",
			"npc_stalker",
			"CombineElite", 
			"npc_combine_s",
			"npc_monk",
			"npc_alyx",
			"npc_barney",
			"npc_citizen",
			"npc_magnusson",
			"npc_kleiner",
			"npc_mossman",
			"npc_eli",
			"npc_gman",
			"Medic",
			"npc_odessa",
			"Rebel",
			"Refugee",
			"VortigauntUriah",
			"npc_vortigaunt",
			"VortigauntSlave",
			"npc_breen"
		}
		
		if IsValid(ent) then		
			if ent:IsPlayer() then
				local rag = ents.Create("prop_ragdoll")
				rag:SetPos(ent:GetPos())
				rag:SetAngles(ent:GetAngles())
				rag:SetModel(ent:GetModel())
				rag:Spawn()
				rag:GetPhysicsObject():ApplyForceCenter(VectorRand() * 2000)
				
				ent:SetNWFloat("hp_crucio", ent:Health())
			
				ent.weps = {}
				ent.angs = ent:EyeAngles()
				
				for k, v in pairs(ent:GetWeapons()) do
					ent.weps[k] = v.ClassName
				end
				
				ent:StripWeapons()
				
				ent:Spectate(OBS_MODE_CHASE)
				ent:DrawViewModel(false)
				ent:DrawWorldModel(false)
				ent:SpectateEntity(rag)	
				
				timer.Create("someshit" .. ent:EntIndex(), 0.4, 0, function()
					if not IsValid(rag) then timer.Stop("someshit" .. ent:EntIndex()) return end
					
					if math.random(1, 2) == 1 then rag:EmitSound("vo/npc/male01/pain0" .. math.random(1, 9) .. ".wav") end
					
					rag:GetPhysicsObject():ApplyForceCenter(VectorRand() * 7000)
				end)
				
				timer.Simple(12, function()
					if IsValid(rag) then rag:Remove() end
					
					if not IsValid(ent) then return end
				
					ent:SpectateEntity(NULL)
					ent:UnSpectate()
					ent:Spawn()
					ent:SetPos(rag:GetPos())
					ent:SetEyeAngles(ent.angs)
					
					ent:SetHealth(math.ceil(ent:GetNWFloat("hp_crucio") / 1.2))
					ent:SetNWFloat("hp_crucio", nil)
					
					for k, v in pairs(ent.weps) do
						ent:Give(tostring(v))
					end
				end)
			elseif ent:IsNPC() then
				for k, v in pairs(npcs) do
					if ent:GetClass() == v then
						local rag = ents.Create("prop_ragdoll")
						rag:SetPos(ent:GetPos())
						rag:SetAngles(ent:GetAngles())
						rag:SetModel(ent:GetModel())
						rag:Spawn()
						rag:GetPhysicsObject():ApplyForceCenter(VectorRand() * 2000)
						
						ent:SetNWFloat("hp_crucio", ent:Health())
					
						local npc = ent:GetClass()
						
						ent:Remove()
						
						timer.Simple(12, function()
							local ent = ents.Create(npc)
							ent:SetPos(rag:GetPos())
							ent:SetModel(rag:GetModel())
							ent:Spawn()
							
							ent:SetHealth(math.ceil(ent:GetNWFloat("hp_crucio") / 1.2))
							ent:SetNWFloat("hp_crucio", nil)
							
							if IsValid(ply) then
								undo.Create(" NPC")
									undo.AddEntity(ent)
									undo.SetPlayer(ply)
								undo.Finish()
							end
							
							if IsValid(rag) then rag:Remove() end
						end)
						
						timer.Create("someshit" .. ent:EntIndex(), 0.4, 0, function()
							if not IsValid(rag) then timer.Stop("someshit" .. ent:EntIndex()) return end
							
							if math.random(1, 2) == 1 then rag:EmitSound("vo/npc/male01/pain0" .. math.random(1, 9) .. ".wav") end
					
							rag:GetPhysicsObject():ApplyForceCenter(VectorRand() * 7000)
						end)
						
						break
					end
				end
			end
		end
	end
})
