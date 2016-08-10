//Expelliarmus

AddCSLuaFile()

hp_mstick.RegisterMagic("expelliarmus", {
	name = "Expelliarmus",
	delay = 2,
	cmd = "expelliarmus_hp",
	codeauthor = "HK47",
	desc = "disarms enemy",

	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetOwner(ply)
		spell:Spawn()
		
		//settings
		spell:SetNWVector("SpellColor", Vector(255, 150, 0))
		spell:SetNWFloat("SpellLife", 1.5)
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		if ent:IsPlayer() then
			ent:DropWeapon(ent:GetActiveWeapon())
			ent:SetVelocity(((ent:GetPos() - pos.HitPos):GetNormal() * 1200) + Vector(0, 0, 350))
		elseif ent:IsNPC() then
			ent:SetVelocity(((ent:GetPos() - pos.HitPos):GetNormal() * 1200) + Vector(0, 0, 350))
		end
	end
})
