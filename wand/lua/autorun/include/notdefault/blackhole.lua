//Black hole

AddCSLuaFile()

hp_mstick.RegisterMagic("Black hole", {
	name = "Black hole",
	delay = 2.5,
	cmd = "black_hole_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "makes black hole",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetAngles(ply:EyeAngles())
		spell:SetOwner(ply)
		spell:Spawn()
		
		//settings
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
		spell:SetNWVector("SpellColor", Vector(150, 150, 255))
		spell:SetNWFloat("SpellSize", 5)
	end,
	
	attack = function(ply, pos)
		//if hook.Exists("Think", "make_black_hole_hp" .. ply:EntIndex()) then return end
	
		hook.Add("Think", "make_black_hole_hp" .. ply:EntIndex(), function()
			for k, v in pairs(ents.FindInSphere(pos.HitPos, 850)) do
				if IsValid(v:GetPhysicsObject()) and not v:IsPlayer() and not v:IsNPC() then v:GetPhysicsObject():SetVelocity(-(v:GetPos() - pos.HitPos) * 300) end
				if v:IsPlayer() or v:IsNPC() then v:SetVelocity(-(v:GetPos() - pos.HitPos) * 700)  end
				
				if (IsValid(v:GetPhysicsObject()) or v:IsPlayer() or v:IsNPC()) and v:GetPos():Distance(pos.HitPos) <= 100 then
					if not v:IsPlayer() then v:Remove() else v:KillSilent() end
				end
			end
			
			local ef = EffectData()
			ef:SetOrigin(pos.HitPos)
			util.Effect("effect_blackhole_hp", ef)
		end)
		
		timer.Create("delete_black_hole_hp" .. ply:EntIndex(), 5, 1, function()
			hook.Remove("Think", "make_black_hole_hp" .. ply:EntIndex())
		end)
	end
})