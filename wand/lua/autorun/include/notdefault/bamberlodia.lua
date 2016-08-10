//Bamberlodia

AddCSLuaFile()

hp_mstick.RegisterMagic("bamberlodia", {
	name = "Bamberlodia",
	delay = 1.5,
	cmd = "bamberlodia_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "makes objects invisible on 2 seconds",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetOwner(ply)
		spell:Spawn()
		
		//settings
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
		spell:SetNWVector("SpellColor", Vector(255, 0, 255))
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		if IsValid(ent) and IsValid(ent:GetPhysicsObject()) then
			if ent:GetNWBool("magic_bamber") then return end
			
			ent:SetNWBool("magic_bamber", true)
		
			ent:GetPhysicsObject():EnableGravity(false)
			ent:GetPhysicsObject():ApplyForceCenter(Vector(0, 0, ent:GetPhysicsObject():GetMass() * 2))
			
			local A = 1
		
			hook.Add("Think", "SetVelOfS" .. ent:EntIndex(), function()
				if not IsValid(ent) then hook.Remove("Think", "SetVelOfS" .. ent:EntIndex()) return end
				
				A = math.Approach(A, 0, 0.055)
				
				ent:SetModelScale(A, 0)
			end)
			
			timer.Create("end_this_shit" .. ent:EntIndex(), 2, 1, function()
				if not IsValid(ent) then return end
				
				ent:SetNWBool("magic_bamber", false)
				
				local ef = EffectData()
				ef:SetOrigin(ent:GetPos())
				//ef:SetAngles(Angle(0, 0, 0))
				util.Effect("effect_expl2_hp", ef)
			
				ent:GetPhysicsObject():EnableGravity(true)
				ent:SetModelScale(1, 0)
				ent:EmitSound("phx/explode03.wav", 100, 120)
				
				local tes = ents.Create("point_tesla")
				tes:SetPos(ent:GetPos() + Vector(0, 0, -20))
				tes:SetKeyValue("thick_min", "0.05")
				tes:SetKeyValue("thick_max", "0.1")
				tes:SetKeyValue("lifetime_min", "0.2")
				tes:SetKeyValue("lifetime_max", "0.5")
				tes:SetKeyValue("interval_min", "0.1")
				tes:SetKeyValue("interval_max", "0.2")
				tes:SetKeyValue("beamcount_min", "10")
				tes:SetKeyValue("beamcount_max", "20")
				tes:SetKeyValue("m_flRadius", "200")
				tes:SetKeyValue("texture", "effects/laser1.vmt")
				tes:SetKeyValue("m_Color", "0 255 255")
				tes:Spawn()
				tes:Fire("DoSpark", "1", 0.01)
				
				hook.Remove("Think", "SetVelOfS" .. ent:EntIndex())
			end)
		end
	end
})
