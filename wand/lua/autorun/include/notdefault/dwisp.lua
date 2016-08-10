//Dwisp

AddCSLuaFile()

hp_mstick.RegisterMagic("dwisp", {
	name = "Dwisp",
	delay = 0.09,
	cmd = "dwisp_hp",
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
		spell:SetNWVector("SpellColor", Vector(200, 255, 100))
		spell:SetNWFloat("SpellSize", 0)
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		if IsValid(ent) then
			ent:TakeDamage(8, ply, ply)
		end
	end
})