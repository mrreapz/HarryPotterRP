//Protego

AddCSLuaFile()

hp_mstick.RegisterMagic("protego", {
	name = "Protego",
	delay = 1.3,
	cmd = "protego_hp",
	codeauthor = "HK47",
	noreturn = true,
	desc = "throws spells | shield spell",
	
	throwprop = function(ply)
		local tr = util.TraceLine {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 60,
			filter = ply
		}
		
		ply:EmitSound("phx/explode0" .. math.random(1, 6) .. ".wav", 100, 200)
		
		local ef = EffectData()
		ef:SetOrigin(tr.HitPos)
		ef:SetAngles(ply:EyeAngles())
		ef:SetStart(Vector(150, 255, 255)) //color
		ef:SetScale(1)
		util.Effect("effect_ringhp", ef)
		
		if CLIENT then return end
		
		local unforgivables = {
			"Avada kedavra",
			"Crucio",
			"Imperius"
		}
		
		for k, v in pairs(ents.FindInSphere(ply:GetPos(), 370)) do
			local ent = v
		
			if IsValid(ent) and ent:GetClass() == "entity_spell_fly" then
				for k, v in pairs(unforgivables) do
					if ent:GetNWString("SpellName") == v then return end
					
					ent:Remove()
				end
			end
		end
	end,
	
	attack = function(ply, pos)
	end
})