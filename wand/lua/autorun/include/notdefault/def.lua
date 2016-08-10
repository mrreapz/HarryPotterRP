//Def

AddCSLuaFile()

hp_mstick.RegisterMagic("def", {
	name = "Def",
	delay = 2.5,
	cmd = "def_hp",
	codeauthor = "HK47",
	nodefault = true,
	adminonly = true,
	desc = "strips your enemy's weapons",
	
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
		spell:SetNWVector("SpellColor", Vector(80, 50, 50))
		spell:SetNWFloat("SpellSize", 0)
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		if IsValid(ent) and ent:IsPlayer() and ent:Alive() then
			for k, v in pairs(ent:GetWeapons()) do
				ent:DropWeapon(v)
			end
			
			ent:SetVelocity(Vector(0, 0, 600))
		end
	end
})