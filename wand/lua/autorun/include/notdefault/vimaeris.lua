//Vimaeris

AddCSLuaFile()

hp_mstick.RegisterMagic("vimaeris", {
	name = "Vimaeris",
	delay = 0.3,
	cmd = "vimaeris_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "push spell | throws away props in small radius",
	
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
		for k, v in pairs(ents.FindInSphere(pos.HitPos, 150)) do
			local p = v:GetPhysicsObject()
			
			if IsValid(p) then
				p:SetVelocity(VectorRand() * 1000 + vector_up * 1000)
			end
		end
	end
})