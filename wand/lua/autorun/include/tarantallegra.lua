//Tarantallegra

AddCSLuaFile()

hp_mstick.RegisterMagic("tarantallegra", {
	name = "Tarantallegra",
	delay = 2,
	cmd = "tarantallegra_hp",
	codeauthor = "HK47",
	desc = "makes your enemy dance",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetOwner(ply)
		spell:Spawn()
		
		spell:GetPhysicsObject():SetVelocity(vector * 9999)
		
		timer.Create("speedSpell" .. spell:EntIndex(), 0.05, 0, function()
			if not IsValid(spell) then timer.Stop("speedSpell" .. spell:EntIndex()) return end
			
			spell:GetPhysicsObject():AddVelocity(vector * 9999)
		end)
		
		//settings
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
		spell:SetNWFloat("SpellSize", -2)
		spell:SetNWVector("SpellColor", Vector(0, 255, 0))
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		if CLIENT then return end
		
		if ent:IsPlayer() then
			ent:ConCommand("act dance")
		end
	end
})