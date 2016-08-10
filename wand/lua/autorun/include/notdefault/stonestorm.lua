//Stonestorm

AddCSLuaFile()

hp_mstick.RegisterMagic("stonestorm", {
	name = "Stonestorm",
	delay = 2.3,
	cmd = "stonestorm_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "makes big stone storm",
	
	throwprop = function(ply)
		local tr = ply:GetEyeTrace()
		
		tr = util.TraceLine {
			start = tr.HitPos,
			endpos = tr.HitPos + Vector(0, 0, 800),
			filter = ply
		}
		
		timer.Create("spawn_stone" .. ply:EntIndex(), 0.1, 55, function()
			local ent = ents.Create("entity_stone_hp")
			ent:SetPos(tr.HitPos + Vector(math.random(-130, 130), math.random(-130, 130), 0))
			ent:SetOwner(ply)
			ent:Spawn()
			
			timer.Simple(6, function()
				if not IsValid(ent) then return end
				
				ent:Remove()
			end)
			
			local ef = EffectData()
			ef:SetOrigin(ent:GetPos())
			ef:SetAngles(ent:GetAngles())
			ef:SetStart(Vector(0, 255, 255))
			util.Effect("effect_ringhp", ef)
			
			local phys = ent:GetPhysicsObject()
			
			if IsValid(phys) then
				phys:AddAngleVelocity(VectorRand() * 360)
			end
		end)
	end,
	
	attack = function(ply, pos)
	end
})