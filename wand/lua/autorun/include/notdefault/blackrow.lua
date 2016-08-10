//Blackrow

AddCSLuaFile()

hp_mstick.RegisterMagic("blackrow", {
	name = "Blackrow",
	delay = 0.7,
	cmd = "blackrow_hp",
	codeauthor = "HK47",
	nodefault = true,
	noreturn = true,
	desc = "makes long black row with big damage in the end",
	
	throwprop = function(ply)
		local ef = EffectData()
		ef:SetEntity(ply)
		util.Effect("effect_blackrow_hp", ef)
		
		local tr = ply:GetEyeTrace()
		
		ef = EffectData()
		ef:SetOrigin(tr.HitPos)
		ef:SetAngles(tr.HitNormal:Angle())
		ef:SetStart(Vector(255, 255, 255))
		ef:SetScale(2)
		util.Effect("effect_ringhp", ef)
		
		ef = EffectData()
		ef:SetOrigin(tr.HitPos)
		ef:SetAngles(tr.HitNormal:Angle())
		ef:SetStart(Vector(255, 255, 255))
		ef:SetScale(4)
		util.Effect("effect_ringhp", ef)
		
		if SERVER then util.BlastDamage(ply, ply, tr.HitPos, 320, 500) end
	end,
	
	attack = function(ply, pos)
	end
})