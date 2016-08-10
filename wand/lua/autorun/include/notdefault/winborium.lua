//Winborium

AddCSLuaFile()

hp_mstick.RegisterMagic("winborium", {
	name = "Winborium",
	delay = 0.18,
	cmd = "winborium_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "very dangerous spell",
	
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
		
		ply:TakeDamage(1)
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		if IsValid(ent) and (ent:IsPlayer() or ent:IsNPC()) then
			ent:EmitSound("npc/antlion/attack_single1.wav", 500, 100)
			ent:SetVelocity(Vector(0, 0, 1000))
			
			timer.Create("effect_glows" .. ent:EntIndex(), 0.1, 10, function()
				if not IsValid(ent) then return end
				
				local ef = EffectData()
				ef:SetOrigin(ent:GetPos())
				util.Effect("effect_glowshp", ef)
			end)
			
			timer.Create("kill_player_" .. ent:EntIndex(), 1.1, 1, function()
				if not IsValid(ent) then return end
				
				util.ScreenShake(ent:GetPos(), 30, 30, 2, 5000)
				
				local ef = EffectData()
				ef:SetOrigin(ent:GetPos())
				util.Effect("effect_big_bloodhp", ef)
				
				ent:EmitSound("physics/body/body_medium_break4.wav", 500, 100)
				if ent:IsPlayer() then ent:KillSilent() else ent:Remove() end
			end)
		end
	end
})