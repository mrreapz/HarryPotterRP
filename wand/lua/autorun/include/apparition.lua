//Apparition

AddCSLuaFile()

hp_mstick.RegisterMagic("apparition", {
	name = "Apparition",
	delay = 2,
	cmd = "apparition_hp",
	codeauthor = "HK47",
	noreturn = true,
	desc = "death eater's smoke fly",
	
	throwprop = function(ply)
		if ply:GetNWBool("apparition_hp") then return end

		if SERVER then
			ply:SetNWBool("apparition_hp", true)
			
			ply:SetNoDraw(true)
			
			hook.Add("GetFallDamage", "apparition_hp_check" .. ply:EntIndex(), function(pl, sp)
				if pl == ply then
					return 0
				end
			end)
			
			hook.Add("Think", "apparition_hp_s" .. ply:EntIndex(), function()
				if not IsValid(ply) then hook.Remove("Think", "apparition_hp_s" .. ply:EntIndex()) hook.Remove("GetFallDamage", "apparition_hp_check" .. ply:EntIndex()) return end

				if ply:IsOnGround() or not ply:Alive() then
					hook.Remove("Think", "apparition_hp_s" .. ply:EntIndex()) 
					hook.Remove("GetFallDamage", "apparition_hp_check" .. ply:EntIndex())
					ply:SetNWBool("apparition_hp", false)
					ply:SetNoDraw(false)
					
					if ply:Alive() then ply:SetVelocity(Vector(0, 0, 0)) end
					
					local ef = EffectData()
					ef:SetOrigin(ply:GetPos() + Vector(0, 0, 20))
					ef:SetAngles(Angle(90, 0, 0))
					ef:SetStart(Vector(0, 150, 255))
					ef:SetScale(3)
					util.Effect("effect_ringhp", ef)
					
					ply:EmitSound("phx/explode00.wav")
					
					return
				end
				
				local ef = EffectData()
				ef:SetOrigin(ply:GetPos())
				ef:SetEntity(ply)
				util.Effect("effect_asmoke_hp", ef)
				
				ply:SetVelocity(ply:GetAimVector() * 150)
			end)
		end
	end,
	
	attack = function(ply, pos)
	end
})