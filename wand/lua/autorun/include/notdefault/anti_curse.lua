//Anti curse

AddCSLuaFile()

hp_mstick.RegisterMagic("anti_curse", {
	name = "Anti curse",
	delay = 1,
	cmd = "anti_curse_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "removes green curse smoke",
	
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
		spell:SetNWVector("SpellColor", Vector(255, 255, 255))
		spell:SetNWFloat("SpellSize", 6)
		spell:SetNWBool("spell_antizombiesp", true)
	end,
	
	attack = function(ply, pos)
	end
})