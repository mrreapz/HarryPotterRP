//Maf

AddCSLuaFile()

hp_mstick.RegisterMagic("maf", {
	name = "Maf",
	delay = 6,
	cmd = "maf_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "kills everything",
	
	throwprop = function(ply)
		for k, v in pairs(ents.GetAll()) do
			if v:IsPlayer() then v:Kill() end
			if v:IsNPC() then v:Fire("sethealth", "0", 0) end
		end
	end,
	
	attack = function(ply, pos)
	end
})