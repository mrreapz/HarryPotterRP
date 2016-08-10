//Fireball

AddCSLuaFile()

hp_mstick.RegisterMagic("fireball", {
	name = "Fireball",
	delay = 0.8,
	cmd = "fireball_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "makes fireball",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetAngles(ply:EyeAngles())
		spell:SetOwner(ply)
		spell:Spawn()
		spell:Ignite(30)
		
		//settings
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
		spell:SetNWVector("SpellColor", Vector(255, 150, 0))
		spell:SetNWFloat("SpellSize", -2)
	end,
	
	attack = function(ply, pos)
		for k, v in pairs(ents.FindInSphere(pos.HitPos, 40)) do
			if IsValid(v) then v:Ignite(10) end
		end
	end
})