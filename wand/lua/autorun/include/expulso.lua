//Expulso

AddCSLuaFile()

hp_mstick.RegisterMagic("expulso", {
	name = "Expulso",
	delay = 3,
	cmd = "expulso_hp",
	codeauthor = "HK47",
	desc = "makes boom",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetOwner(ply)
		spell:Spawn()
		
		//settings
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
	end,
	
	attack = function(ply, pos)
		local ef = EffectData()
		ef:SetOrigin(pos.HitPos)
		util.Effect("Explosion", ef)
		//util.Effect("effect_explodehp", ef)
		
		util.ScreenShake(pos.HitPos, 20, 20, 1, 2000)
		util.BlastDamage(ply, ply, pos.HitPos, 200, 500)
	end
})
