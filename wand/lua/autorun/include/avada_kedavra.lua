//Avada kedavra

AddCSLuaFile()

hp_mstick.RegisterMagic("avada_kedavra", {
	name = "Avada kedavra",
	delay = 2,
	cmd = "avada_kedavra_hp",
	codeauthor = "HK47",
	adminonly = true,
	desc = "kills enemy",
	
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
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		if ent:IsPlayer() then
			ent:Kill()
		elseif ent:IsNPC() then
			ent:Fire("sethealth", "0", 0)
		end
	end
})
