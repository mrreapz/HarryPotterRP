//Arresto Momentum

AddCSLuaFile()

hp_mstick.RegisterMagic("arresto_momentum", {
	name = "Arresto Momentum",
	delay = 0.8,
	cmd = "arresto_momentum_hp",
	codeauthor = "HK47",
	desc = "changes speed on that you're looking object",
	
	throwprop = function(ply)
		local tr = util.TraceHull {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 4000,
			filter = ply,
			mins = Vector(-30, -30, -30),
			maxs = Vector(30, 30, 30)
		}
		
		local ent = tr.Entity
		
		if tr.Hit and IsValid(ent) and IsValid(ent:GetPhysicsObject()) and not ent:IsPlayer() and not ent:IsNPC() then
			ent:GetPhysicsObject():SetVelocity(Vector(0, 0, 0))
		end
	end,
	
	attack = function(ply, pos)
	end
})