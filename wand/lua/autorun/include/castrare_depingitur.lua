//Castrare depingitur

AddCSLuaFile()

hp_mstick.RegisterMagic("castrare_depingitur", {
	name = "Castrare depingitur",
	delay = 1.5,
	cmd = "castrare_depingitur_hp",
	codeauthor = "HK47",
	desc = "stops your enemy makes spells on 3 seconds",
	
	throwprop = function(ply)
		local tr = util.TraceHull {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 2500,
			filter = ply,
			mins = Vector(-20, -20, -20),
			maxs = Vector(20, 20, 20)
		}
		
		ply:EmitSound("phx/explode0" .. math.random(1, 6) .. ".wav", 100, 200)
		
		local ent = tr.Entity
		
		if IsValid(ent) and ent:IsPlayer() then
			ent:SetNWBool("SpellStopSay", true)
			
			timer.Create("setstopsay" .. ent:EntIndex(), 3, 1, function() if IsValid(ent) then ent:SetNWBool("SpellStopSay", false) end end)
		end
	end,
	
	attack = function(ply, pos)
	end
})