//Avis

AddCSLuaFile()

hp_mstick.RegisterMagic("avis", {
	name = "Avis",
	delay = 2,
	cmd = "avis_hp",
	codeauthor = "HK47",
	desc = "makes birds",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetOwner(ply)
		spell:Spawn()
		
		//settings
		spell:SetNWBool("SpellNoDraw", true)
		spell:SetNWFloat("SpellAlpha", 0)
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
	end,
	
	attack = function(ply, pos)
		local birds = {
			"npc_pigeon",
			"npc_seagull"
		}
		
		for i = 1, math.random(3, 5) do
			local ent = ents.Create(birds[math.random(1, #birds)])
			ent:SetPos(pos.HitPos + VectorRand() * 20)
			ent:Spawn()
			ent:SetColor(Color(math.random(0, 1) * 255, math.random(0, 1) * 255, math.random(0, 1) * 255, 255))
		end
	end
})
