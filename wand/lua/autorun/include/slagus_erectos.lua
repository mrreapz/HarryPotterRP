//Slagus Erectos

AddCSLuaFile()

hp_mstick.RegisterMagic("slagus_erectos", {
	name = "Slagus Erectos",
	delay = 4,
	cmd = "slagus_erectos_hp",
	codeauthor = "HK47",
	adminonly = true,
	desc = "stops your enemy makes spells on 10 seconds",
	
	throwprop = function(ply)
		if CLIENT then return end
	
		local tr = util.TraceHull {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 700,
			filter = ply
		}
		
		local ent = tr.Entity
		
		if IsValid(ent) and ent:IsPlayer() and not ent:GetNWBool("SlagusSpell") and not ent:GetNWBool("SpellStopSay") then
			timer.Create("stop_slagus" .. ent:EntIndex(), 10, 1, function()
				hook.Remove("Think", "slagus_think" .. ent:EntIndex())
			
				if not ent:Alive() then
					hook.Add("PlayerSpawn", "check_already_slagus" .. ent:EntIndex(), function(ply)
						if ply == ent then
							timer.Simple(0.1, function() 
								ply:SetNWBool("SlagusSpell", false) 
								ply:SetNWBool("SpellStopSay", false) 
							end)
							
							hook.Remove("PlayerSpawn", "check_already_slagus" .. ply:EntIndex())
						end
					end)
				end
				
				if IsValid(ent) then 
					ent:SetNWBool("SlagusSpell", false) 
					ent:SetNWBool("SpellStopSay", false) 
				end
			end)
			
			ent:SetNWBool("SpellStopSay", true)
			ent:SetNWBool("SlagusSpell", true)
			
			hook.Add("Think", "slagus_think" .. ent:EntIndex(), function()
				if not ent:GetNWBool("SlagusSpell") or not IsValid(ent) then hook.Remove("Think", "slagus_think" .. ent:EntIndex()) end
				
				if math.random(1, 10) == 5 then
					local ef = EffectData()
					
					ent:ViewPunch(Angle(math.random(-0.1, 0.1), math.random(-0.1, 0.1), math.random(-0.1, 0.1)))
					
					local head = ent:LookupBone("ValveBiped.Bip01_Head1")
					local hpos = ent:GetBonePosition(head)
					
					if not hpos then hpos = ent:GetPos() + Vector(0, 0, 80) end
					
					ef:SetOrigin(hpos)
					ef:SetEntity(ent)
					util.Effect("effect_splashhp", ef)
				end
			end)
		end
	end,
	
	attack = function(ply, pos)
	end
})