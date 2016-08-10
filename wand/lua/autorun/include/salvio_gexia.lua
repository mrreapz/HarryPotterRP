//Salvio Hexia

AddCSLuaFile()

hp_mstick.RegisterMagic("salvio_hexia", {
	name = "Salvio Hexia",
	delay = 5,
	cmd = "salvio_hexia_hp",
	codeauthor = "HK47",
	adminonly = true,
	desc = "makes you invisible",
	
	throwprop = function(ply)
		if ply:GetNWBool("PlySalvioSpell") then return end
	
		ply:EmitSound("phx/explode0" .. math.random(1, 6) .. ".wav", 100, 200)
		
		ply:SetNWBool("PlySalvioSpell", true)
		ply:SetNotSolid(true)
		ply:SetMaterial("models/props_c17/fisheyelens")
		
		timer.Create("Stopsalviog" .. ply:EntIndex(), 18, 1, function()
			if not ply:Alive() then
				hook.Add("PlayerSpawn", "SalvioGexSpell" .. ply:EntIndex(), function(pl)
					if pl == ply then
						ply:SetMaterial("asdasads")
						ply:SetNotSolid(false)
						ply:SetNWBool("PlySalvioSpell", false)
						hook.Remove("PlayerSpawn", "SalvioGexSpell" .. ply:EntIndex())
					end
				end)
			end
			
			if not IsValid(ply) then return end
			
			ply:ChatPrint("You have lost your invisibility!")
			ply:SetMaterial("asdasads")
			ply:SetNotSolid(false)
			ply:SetNWBool("PlySalvioSpell", false)
		end)
	end,
	
	attack = function(ply, pos)
	end
})