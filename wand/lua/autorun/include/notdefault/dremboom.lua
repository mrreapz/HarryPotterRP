//Dremboom

AddCSLuaFile()

hp_mstick.RegisterMagic("dremboom", {
	name = "Dremboom",
	delay = 2,
	cmd = "dremboom_hp",
	codeauthor = "HK47",
	nodefault = true,
	noreturn = true,
	adminonly = true,
	desc = "makes very big boom with very big damage",
	
	throwprop = function(ply)
		local tr = util.TraceLine {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 100,
			filter = ply
		}
	
		local ef = EffectData()
		ef:SetOrigin(tr.HitPos)
		ef:SetAngles(ply:EyeAngles())
		ef:SetStart(Vector(0, 150, 255))
		util.Effect("effect_ringhp", ef)
	
		if CLIENT then return end
	
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetAngles(ply:EyeAngles())
		spell:SetOwner(ply)
		spell:Spawn()
		
		timer.Create("ringsSpell" .. spell:EntIndex(), 0.15, 0, function()
			if not IsValid(spell) then timer.Stop("ringsSpell" .. spell:EntIndex()) return end
			
			spell:EmitSound("phx/explode0" .. math.random(1, 5) .. ".wav", 200, 500)
			
			local ef = EffectData()
			ef:SetOrigin(spell:GetPos())
			ef:SetAngles(spell:GetAngles())
			ef:SetScale(0.5)
			ef:SetStart(Vector(0, 150, 255))
			util.Effect("effect_ringhp", ef)
		end)
		
		//settings
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
		spell:SetNWVector("SpellColor", Vector(0, 150, 255))
		spell:SetNWFloat("SpellSize", 4)
		spell:SetNWBool("SpellShake", true)
	end,
	
	attack = function(ply, pos)
		local i = 10
		
		util.ScreenShake(pos.HitPos, 200, 200, 2, 10000)
		
		timer.Simple(0.2, function()
			local ent = ents.Create("prop_physics")
			ent:SetPos(pos.HitPos)
			ent:SetModel("models/props_junk/sawblade001a.mdl")
			ent:Spawn()
			ent:SetNoDraw(true)
			ent:GetPhysicsObject():EnableMotion(false)
			ent:SetSolid(SOLID_NONE)
			
			ent:EmitSound("ambient/explosions/explode_6.wav", 120, 110)
			ent:EmitSound("ambient/explosions/explode_8.wav", 100, 110)
			ent:EmitSound("ambient/explosions/explode_5.wav", 100, 110)
			
			timer.Simple(0.2, function() if not IsValid(ent) then return end ent:Remove() end)
		end)
	
		timer.Create("fireline" .. math.random(1, 500), 0.005, 150, function()
			i = i + 15
			
			util.BlastDamage(ply, ply, pos.HitPos, i, 10)
		end)
		
		local ef = EffectData()
		ef:SetOrigin(pos.HitPos)
		util.Effect("explosion", ef)
		
		ef:SetAngles(pos.HitNormal:Angle())
		ef:SetStart(Vector(0, 150, 255))
		ef:SetScale(4)
		util.Effect("effect_ringhp", ef)
		
		ef:SetNormal(pos.HitNormal)
		util.Effect("effect_soexplodehp", ef)
		util.Effect("effect_bigexplodehp", ef)
	end
})