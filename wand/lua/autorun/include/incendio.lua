//Incendio

AddCSLuaFile()

hp_mstick.RegisterMagic("incendio", {
	name = "Incendio",
	delay = 1,
	cmd = "incendio_hp",
	codeauthor = "HK47",
	desc = "ignites anything",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetOwner(ply)
		spell:Spawn()
		
		//settings
		spell:SetNWVector("SpellColor", Vector(255, 190, 0))
		spell:SetNWFloat("SpellLife", 0.4)
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		if IsValid(ent) then ent:Ignite(8, 50) end
	end
})
