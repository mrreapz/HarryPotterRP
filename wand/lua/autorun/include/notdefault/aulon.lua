//Aulon

AddCSLuaFile()

hp_mstick.RegisterMagic("aulon", {
	name = "Aulon",
	delay = 0.65,
	cmd = "aulon_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "water spell | makes so much water and extinguish somethings",
	
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
		spell:SetNWVector("SpellColor", Vector(150, 255, 255))
		spell:SetNWFloat("SpellSize", 0)
	end,
	
	attack = function(ply, pos)
		local spellpos = pos.HitPos
		local time = 1
			
		timer.Create("watersplashes" .. ply:EntIndex(), 0.1, 8, function()
			time = time + 270
			
			for k, v in pairs(ents.FindInSphere(pos.HitPos, time)) do
				if v:IsOnFire() then v:Extinguish() end
			end
			
			for i = 1, 45 do
				local ef = EffectData()
				ef:SetStart(spellpos + Vector(math.sin(i * 8) * time, math.cos(i * 8) * time, 0))
				ef:SetOrigin(spellpos + Vector(math.sin(i * 8) * time, math.cos(i * 8) * time, 0))
				ef:SetScale(60 + time / 20)
				util.Effect("watersplash", ef)
			end
		end)
	end
})