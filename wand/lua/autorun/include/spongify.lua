//Spongify

AddCSLuaFile()

hp_mstick.RegisterMagic("spongify", {
	name = "Spongify",
	delay = 2.2,
	cmd = "spongify_hp",
	codeauthor = "HK47",
	desc = "jump",
	
	throwprop = function(ply)
		if ply:IsOnGround() then ply:SetVelocity(Vector(0, 0, 1000) + ply:GetAimVector() * 500) end
	end,
	
	attack = function(ply, pos)
	end
})