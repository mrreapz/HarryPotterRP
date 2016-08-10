//Forbefire

AddCSLuaFile()

hp_mstick.RegisterMagic("forbefire", {
	name = "Forbefire",
	delay = 1.4,
	cmd = "forbefire_hp",
	codeauthor = "HK47",
	nodefault = true,
	adminonly = true,
	desc = "makes boom with big damage",
	
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
		spell:SetNWVector("SpellColor", Vector(150, 255, 55))
		spell:SetNWFloat("SpellSize", 4)
	end,
	
	attack = function(ply, pos)
		util.BlastDamage(ply, ply, pos.HitPos, 200, 800)
		//util.ScreenShake(pos.HitPos, 20, 20, 3, 4000)
		
		timer.Simple(0.2, function()
			local ent = ents.Create("prop_physics")
			ent:SetPos(pos.HitPos)
			ent:SetModel("models/props_junk/sawblade001a.mdl")
			ent:Spawn()
			ent:SetNoDraw(true)
			ent:GetPhysicsObject():EnableMotion(false)
			ent:SetSolid(SOLID_NONE)
			
			ent:EmitSound("phx/explode0" .. math.random(1, 5) .. ".wav", 100, 110)
			
			timer.Simple(0.2, function() if not IsValid(ent) then return end ent:Remove() end)
		end)
		
		local ef = EffectData()
		ef:SetOrigin(pos.HitPos)
		ef:SetAngles(pos.HitNormal:Angle())
		ef:SetNormal(pos.HitNormal)
		util.Effect("effect_soexplodehp", ef)
	end
})