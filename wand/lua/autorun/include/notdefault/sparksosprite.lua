//Sparksosprite

AddCSLuaFile()

hp_mstick.RegisterMagic("sparksosprite", {
	name = "Sparksosprite",
	delay = 0.3,
	cmd = "sparksosprite_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "makes lighting",
	
	throwprop = function(ply)
		timer.Create("make_lighting_" .. ply:EntIndex(), 0.01, 50, function()
			if IsValid(ply) then
				for i = 1, 5 do
					local ef = EffectData()
					ef:SetEntity(ply)
					ef:SetAttachment(1)
					ef:SetStart(Vector(0, 150, 255)) //color
					util.Effect("effect_lighting_hp", ef)
				end
			end
		end)
		
		local tr = util.TraceHull {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 450,
			filter = ply,
			mins = Vector(-20, -20, -20),
			maxs = Vector(20, 20, 20)
		}
		
		local ent = tr.Entity
		
		if IsValid(ent) then ent:TakeDamage(10) end
	end,
	
	attack = function(ply, pos)
	end
})