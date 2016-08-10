//Motus

AddCSLuaFile()

hp_mstick.RegisterMagic("motus", {
	name = "Motus",
	delay = 1.4,
	cmd = "motus_hp",
	codeauthor = "HK47",
	nodefault = true,
	adminonly = true,
	desc = "teleport and kills your enemy",
	
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
		spell:SetNWVector("SpellColor", VectorRand() * 255)
		spell:SetNWFloat("SpellSize", 5)
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		if IsValid(ent) and ent:IsPlayer() or ent:IsNPC() then
			ent:SetPos(VectorRand() * 20000)
			
			timer.Create("kill_ent" .. ent:EntIndex(), 2, 1, function()
				if not IsValid(ent) then return end
				
				if ent:IsPlayer() then ent:Kill() else ent:Fire("sethealth", "0", 0) end
			end)
		end
	end
})