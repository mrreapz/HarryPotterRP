//Rictusempra

AddCSLuaFile()

hp_mstick.RegisterMagic("rictusempra", {
	name = "Rictusempra",
	delay = 1,
	cmd = "rictusempra_hp",
	codeauthor = "HK47",
	desc = "attack spell",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetOwner(ply)
		spell:Spawn()
		
		//settings
		spell:SetNWVector("SpellColor", Vector(255, 0, 0))
		spell:SetNWFloat("SpellSize", 2)
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		if ent:IsPlayer() or ent:IsNPC() then
			ent:TakeDamage(math.random(5, 15), ply, ply)
		end
	end
})
