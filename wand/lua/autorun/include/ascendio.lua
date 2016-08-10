//Ascendio

AddCSLuaFile()

hp_mstick.RegisterMagic("ascendio", {
	name = "Ascendio",
	delay = 3,
	cmd = "ascendio_hp",
	codeauthor = "HK47",
	desc = "pushes you out from water",
	
	throwprop = function(ply)
		if ply:WaterLevel() > 0 then
			ply:SetVelocity(Vector(0, 0, 1500))
			ply:ViewPunch(Angle(5, 0, 0))
		end
	end,
	
	attack = function(ply, pos)
	end
})
