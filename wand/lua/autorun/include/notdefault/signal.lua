//Signal

AddCSLuaFile()

hp_mstick.RegisterMagic("signal", {
	name = "Signal",
	delay = 1.2,
	cmd = "signal_hp",
	codeauthor = "HK47",
	nodefault = true,
	noreturn = true,
	desc = "makes row in the sky",
	
	throwprop = function(ply)
		local ef = EffectData()
		ef:SetEntity(ply)
		util.Effect("effect_blackrow_hp", ef)
	end,
	
	attack = function(ply, pos)
	end
})