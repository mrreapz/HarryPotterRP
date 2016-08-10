//Dragoner

AddCSLuaFile()

hp_mstick.RegisterMagic("dragoner", {
	name = "Dragoner",
	delay = 2,
	cmd = "dragoner_hp",
	codeauthor = "HK47",
	nodefault = true,
	noreturn = true,
	adminonly = true,
	desc = "makes boom with big damage",
	
	throwprop = function(ply)
		local tr = util.TraceLine {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 100,
			filter = ply
		}
	
		local ef = EffectData()
		ef:SetOrigin(tr.HitPos)
		ef:SetAngles(ply:EyeAngles())
		ef:SetStart(Vector(255, 150, 0))
		ef:SetScale(0)
		util.Effect("effect_ringhp", ef)
	
		if CLIENT then return end
	
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetAngles(ply:EyeAngles())
		spell:SetOwner(ply)
		spell:Spawn()
		
		timer.Create("ringsSpell" .. spell:EntIndex(), 0.15, 0, function()
			if not IsValid(spell) then timer.Stop("ringsSpell" .. spell:EntIndex()) return end
			
			spell:EmitSound("phx/explode0" .. math.random(1, 5) .. ".wav", 200, 500)
			
			local ef = EffectData()
			ef:SetOrigin(spell:GetPos())
			ef:SetAngles(spell:GetAngles())
			ef:SetScale(0.5)
			ef:SetStart(Vector(255, 150, 0))
			util.Effect("effect_ringhp", ef)
		end)
		
		//settings
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
		spell:SetNWVector("SpellColor", Vector(150, 255, 55))
		spell:SetNWFloat("SpellSize", 4)
		spell:SetNWBool("SpellShake", true)
	end,
	
	attack = function(ply, pos)
		util.BlastDamage(ply, ply, pos.HitPos, 200, 800)
		
		local ef = EffectData()
		ef:SetOrigin(pos.HitPos)
		util.Effect("explosion", ef)
		ef:SetAngles(pos.HitNormal:Angle())
		ef:SetStart(Vector(255, 150, 0))
		ef:SetScale(3)
		util.Effect("effect_ringhp", ef)
	end
})