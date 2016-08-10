//Reducto

AddCSLuaFile()

hp_mstick.RegisterMagic("reducto", {
	name = "Reducto",
	delay = 2,
	cmd = "reducto_hp",
	codeauthor = "HK47",
	desc = "makes boom only on the objects",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetOwner(ply)
		spell:Spawn()
		
		//settings
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
		spell:SetNWVector("SpellColor", Vector(0, 255, 255))
	end,
	
	attack = function(ply, pos)
		if pos.HitEntity:IsWorld() then return else pos = pos.HitEntity:GetPos() end
		
		local ef = EffectData()
		ef:SetOrigin(pos)
		ef:SetMagnitude(20)
		ef:SetScale(20)
		util.Effect("Explosion", ef)
		util.Effect("HelicopterMegaBomb", ef)
		//util.Effect("effect_explodehp", ef)
		
		util.ScreenShake(pos, 40, 40, 1, 2500)
		util.BlastDamage(ply, ply, pos, 80, 100)
	end
})