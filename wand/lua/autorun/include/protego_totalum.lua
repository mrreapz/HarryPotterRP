//Protego totalum

AddCSLuaFile()

hp_mstick.RegisterMagic("protego_totalum", {
	name = "Protego totalum",
	delay = 1.5,
	cmd = "protego_totalum_hp",
	codeauthor = "HK47",
	noreturn = true,
	desc = "makes shield from spells on 13 seconds",
	
	throwprop = function(ply)
		if ply:GetNWBool("ProtegoTotalum") then return end
	
		ply:EmitSound("phx/explode0" .. math.random(1, 6) .. ".wav", 100, 200)
		
		local pos = ply:GetPos()
		
		local ef = EffectData()
		ef:SetOrigin(ply:GetPos())
		ef:SetAngles(Angle(90, 0, 0))
		ef:SetStart(Vector(150, 255, 255)) //color
		ef:SetScale(3)
		util.Effect("effect_ringhp", ef)
		
		if CLIENT then return end
		
		local unforgivables = {
			"Avada kedavra",
			"Crucio",
		}
		
		hook.Add("Think", "protego_totalum" .. ply:EntIndex(), function()
			if not IsValid(ply) then hook.Remove("Think", "protego_totalum" .. ply:EntIndex()) return end
		
			for k, v in pairs(ents.FindInSphere(pos, 170)) do
				local ent = v
			
				if ent:GetClass() == "entity_spell_fly" then
					if ent:GetOwner() == ply then return end
				
					for z, p in pairs(unforgivables) do
						if ent:GetNWString("SpellName") == p then break end
						
						local ef = EffectData()
						ef:SetOrigin(ply:GetPos())
						ef:SetAngles(Angle(90, 0, 0))
						ef:SetStart(Vector(150, 255, 255)) //color
						ef:SetScale(3)
						util.Effect("effect_ringhp", ef)
						
						local ef = EffectData()
						ef:SetOrigin(ent:GetPos())
						ef:SetAngles(ent:GetAngles())
						ef:SetStart(Vector(150, 255, 255)) //color
						ef:SetScale(1)
						util.Effect("effect_ringhp", ef)
						
						ent:Remove()
					end
				end
			end
		end)
		
		ply:SetNWBool("ProtegoTotalum", true)
		
		timer.Create("protego_totalum_t" .. ply:EntIndex(), 13, 1, function() hook.Remove("Think", "protego_totalum" .. ply:EntIndex()) ply:SetNWBool("ProtegoTotalum", false) ply:ChatPrint("You have lost protect") end)
	end,
	
	attack = function(ply, pos)
	end
})