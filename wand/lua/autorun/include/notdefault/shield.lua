//Shield

AddCSLuaFile()

hp_mstick.RegisterMagic("shield", {
	name = "Shield",
	delay = 6,
	cmd = "shield_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "god mode in 3 seconds | may give you a chance in battle",
	
	throwprop = function(ply)
		ply:GodEnable()
		ply:SetRenderMode(RENDERMODE_TRANSALPHA)
		ply:SetColor(Color(255, 0, 0, 125))
		ply:EmitSound("npc/antlion/attack_single" .. math.random(1, 3) .. ".wav")
		
		timer.Create("disable_god_" .. ply:EntIndex(), 3, 1, function()
			if SERVER and IsValid(ply) then ply:GodDisable() ply:SetColor(Color(255, 255, 255, 255)) ply:ChatPrint("You have lost shield") end
		end)
	end,
	
	attack = function(ply, pos)
	end
})