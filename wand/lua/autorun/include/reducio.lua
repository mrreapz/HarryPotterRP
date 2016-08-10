//Reducio

AddCSLuaFile()

hp_mstick.RegisterMagic("reducio", {
	name = "Reducio",
	delay = 0.8,
	cmd = "reducio_hp",
	codeauthor = "HK47",
	desc = "makes anything little",
	
	throwprop = function(ply)
		local tr = util.TraceHull {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 1200,
			filter = ply,
			mins = Vector(-30, -30, -30),
			maxs = Vector(30, 30, 30)
		}
		
		local ent = tr.Entity
		
		if IsValid(ent) and IsValid(ent:GetPhysicsObject()) and not ent:IsPlayer() then
			ent:SetModelScale(ent:GetModelScale() - 0.02, 0)
		end
	end,
	
	attack = function(ply, pos)
	end
})