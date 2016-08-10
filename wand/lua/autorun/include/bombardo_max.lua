//Bombardo Maxima

AddCSLuaFile()

hp_mstick.RegisterMagic("bombardo_max", {
	name = "Bombardo Maxima",
	delay = 2,
	cmd = "bombardo_max_hp",
	codeauthor = "HK47",
	desc = "makes boom with ultra damage",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetOwner(ply)
		spell:Spawn()
		
		//settings
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
		spell:SetNWBool("SpellNoDraw", true)
	end,
	
	attack = function(ply, pos)
		local ef = EffectData()
		ef:SetOrigin(pos.HitPos)
		ef:SetMagnitude(20)
		ef:SetScale(20)
		util.Effect("Explosion", ef)
		util.Effect("HelicopterMegaBomb", ef)
		//util.Effect("effect_explodehp", ef)
		
		util.ScreenShake(pos.HitPos, 20, 20, 1, 2500)
		util.BlastDamage(ply, ply, pos.HitPos, 230, 300)
	end
})
