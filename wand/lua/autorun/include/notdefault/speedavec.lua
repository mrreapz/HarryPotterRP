//Speedavec

AddCSLuaFile()

hp_mstick.RegisterMagic("speedavec", {
	name = "Speedavec",
	delay = 1.2,
	cmd = "speedavec_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "moves you",
	
	throwprop = function(ply)
		ply:SetVelocity(ply:GetAimVector() * 800)
	end,
	
	attack = function(ply, pos)
	end
})