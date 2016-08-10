//Speedom

AddCSLuaFile()

hp_mstick.RegisterMagic("speedom", {
	name = "Speedom",
	delay = 8,
	cmd = "speedom_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "makes you fast in 6 seconds",
	
	throwprop = function(ply)
		ply:SetWalkSpeed(400)
		ply:SetRunSpeed(400)
		ply:SetJumpPower(400)
		ply:SetRenderMode(RENDERMODE_TRANSALPHA)
		ply:SetColor(Color(0, 255, 0, 180))
		ply:EmitSound("npc/antlion/attack_single" .. math.random(1, 3) .. ".wav")
		
		timer.Create("disable_fast_" .. ply:EntIndex(), 6, 1, function()
			if IsValid(ply) then 
				ply:SetWalkSpeed(200)
				ply:SetRunSpeed(400)
				ply:SetJumpPower(200)
				ply:SetColor(Color(255, 255, 255, 255)) 
				ply:ChatPrint("You have lost quick mode") 
			end
		end)
	end,
	
	attack = function(ply, pos)
	end
})