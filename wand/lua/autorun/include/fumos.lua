//Fumos

AddCSLuaFile()

hp_mstick.RegisterMagic("fumos", {
	name = "Fumos",
	delay = 4,
	cmd = "fumos_hp",
	codeauthor = "HK47",
	noreturn = true,
	desc = "makes smoke",
	
	throwprop = function(ply)
		local tr = util.TraceLine {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 100,
			filter = ply
		}
		
		ply:EmitSound("ambient/fire/ignite.wav", 100, 200)
		
		local ef = EffectData()
		ef:SetOrigin(tr.HitPos)
		ef:SetStart(Vector(50, 50, 50))
		util.Effect("effect_smokehp", ef)
	end,
	
	attack = function(ply, pos)
	end
})