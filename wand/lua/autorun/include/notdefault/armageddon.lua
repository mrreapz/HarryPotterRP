//Armageddon

AddCSLuaFile()

hp_mstick.RegisterMagic("armageddon", {
	name = "Armageddon",
	delay = 3,
	cmd = "armageddon_hp",
	codeauthor = "HK47",
	nodefault = true,
	adminonly = true,
	desc = "makes stone armageddon",
	
	throwprop = function(ply)
		local tr = ply:GetEyeTrace()
		
		util.ScreenShake(tr.HitPos, 1000, 1000, 15, 10000)
		
		//for k, v in pairs(player.GetAll()) do v:EmitSound("music/ravenholm_1.mp3") end
		
		tr = util.TraceLine {
			start = tr.HitPos,
			endpos = tr.HitPos + Vector(0, 0, 9999999),
			filter = ply
		}
		
		for i = 1, math.random(80, 160) do
			local ent = ents.Create("entity_stone_hp")
			local vec = VectorRand()
			vec.z = 0
			ent:SetPos((tr.HitPos - Vector(0, 0, math.random(100, 2000))) + Vector(math.random(-5000, 5000), math.random(-5000, 5000), 0))
			ent:SetOwner(ply)
			ent:Spawn()
			ent:SetModelScale(math.random(10, 30), 0)
			
			local phys = ent:GetPhysicsObject()
			
			if IsValid(phys) then
				phys:SetVelocity(Vector(0, 0, -999999) + (VectorRand() * 999999))
				phys:AddAngleVelocity(VectorRand() * 360)
				
				//timer.Create("fuck_system" .. ent:EntIndex(), 0.5, 0, function()
					//if not IsValid(ent) then timer.Stop("fuck_system" .. ent:EntIndex()) end
				//end)
			end
		end
	end,
	
	attack = function(ply, pos)
	end
})
