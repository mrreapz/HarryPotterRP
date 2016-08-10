//Walkspeeden

AddCSLuaFile()

hp_mstick.RegisterMagic("salkspeeden", {
	name = "Walkspeeden",
	delay = 3.1,
	cmd = "walkspeeden_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "moves you",
	
	throwprop = function(ply)
		ply:SetNWFloat("GetSpeed_hp", ply:GetWalkSpeed())
		ply:SetWalkSpeed(1000)
		ply:SetNWFloat("GetSpeed2_hp", ply:GetRunSpeed())
		ply:SetRunSpeed(1000)
	
		timer.Create("Speed_rings" .. ply:EntIndex(), 0.2, 0, function()
			if not IsValid(ply) then return end
		
			local tr = util.TraceLine {
				start = ply:GetShootPos(),
				endpos = ply:GetShootPos() + ply:GetAimVector() * 60,
				filter = ply
			}
			
			ply:EmitSound("phx/explode0" .. math.random(1, 6) .. ".wav", 100, 200)
			
			local ef = EffectData()
			ef:SetOrigin(tr.HitPos)
			ef:SetAngles(ply:EyeAngles())
			ef:SetStart(Vector(0, 255, 255))
			ef:SetScale(1)
			util.Effect("effect_ringhp", ef)
		end)
		
		timer.Create("set_again_hp" .. ply:EntIndex(), 3, 1, function()
			if not IsValid(ply) then return end
			
			hook.Remove("Think", "SO_MOVE_GUY_hp" .. ply:EntIndex())
			timer.Stop("Speed_rings" .. ply:EntIndex())
			
			ply:SetRunSpeed(ply:GetNWFloat("GetSpeed2_hp"))
			ply:SetWalkSpeed(ply:GetNWFloat("GetSpeed_hp"))
			ply:ConCommand("-forward")
		end)
		
		hook.Add("Think", "SO_MOVE_GUY_hp" .. ply:EntIndex(), function()
			if not IsValid(ply) then hook.Remove("Think", "SO_MOVE_GUY_hp" .. ply:EntIndex()) timer.Stop("Speed_rings" .. ply:EntIndex()) end
			
			ply:ConCommand("+forward")
			ply:ConCommand("-back")
		end)
	end,
	
	attack = function(ply, pos)
	end
})