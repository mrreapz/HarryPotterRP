//Mostro

AddCSLuaFile()

hp_mstick.RegisterMagic("mostro", {
	name = "Mostro",
	delay = 0.22,
	cmd = "mostro_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "attack spell",
	
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
		spell:SetNWVector("SpellColor", Vector(0, 0, 255))
		spell:SetNWFloat("SpellSize", 0)
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		if IsValid(ent) then
			ent:TakeDamage(15, ply, ply)
		end
	end
})