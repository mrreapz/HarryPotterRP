//Confringo

AddCSLuaFile()

hp_mstick.RegisterMagic("confringo", {
	name = "Confringo",
	delay = 1.8,
	cmd = "confringo_hp",
	codeauthor = "HK47",
	desc = "makes boom with ignite everything in big distance",
	
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
		local ef = EffectData()
		ef:SetOrigin(pos.HitPos)
		ef:SetMagnitude(20)
		ef:SetScale(20)
		util.Effect("Explosion", ef)
		util.Effect("HelicopterMegaBomb", ef)
		//util.Effect("effect_explodehp", ef)
		
		for k, v in pairs(ents.FindInSphere(pos.HitPos, 300)) do
			if IsValid(v:GetPhysicsObject()) and not v:IsOnFire() then v:Ignite(10) end
		end
		
		util.ScreenShake(pos.HitPos, 40, 40, 1, 2500)
		util.BlastDamage(ply, ply, pos.HitPos, 240, 80)
	end
})
