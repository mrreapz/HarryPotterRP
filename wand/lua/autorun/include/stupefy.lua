//Stupefy

AddCSLuaFile()

hp_mstick.RegisterMagic("stupefy", {
	name = "Stupefy",
	delay = 0.8,
	cmd = "stupefy_hp",
	codeauthor = "HK47",
	desc = "paralyzes your enemy on 2 seconds",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetOwner(ply)
		spell:Spawn()
		
		//settings
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
		spell:SetNWFloat("SpellSize", 1)
		spell:SetNWVector("SpellColor", Vector(0, 150, 255))
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		if ent:IsPlayer() then
			ent:Lock()
			
			timer.Simple(2, function()
				if not IsValid(ent) then return end
			
				ent:UnLock()
			end)
		end
		
		if ent:IsNPC() then
			ent:AddRelationship("player D_FR 999")
			
			timer.Simple(2, function() if not IsValid(ent) then return end ent:AddRelationship("player D_HT 999") end)
		end
	end
})