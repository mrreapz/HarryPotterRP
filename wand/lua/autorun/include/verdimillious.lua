//Verdimillious

AddCSLuaFile()

hp_mstick.RegisterMagic("verdimillious", {
	name = "Verdimillious",
	delay = 1.4,
	cmd = "verdimillious_hp",
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
		spell:SetNWVector("SpellColor", Vector(0, 255, 0))
		spell:SetNWFloat("SpellLife", 0.6)
		spell:SetNWFloat("SpellSize", 4)
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		if ent:IsPlayer() or ent:IsNPC() then
			ent:TakeDamage(math.random(10, 25), ply, ply)
		end
	end
})
