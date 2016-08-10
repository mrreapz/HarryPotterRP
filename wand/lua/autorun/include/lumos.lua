//Lumos

AddCSLuaFile()

hp_mstick.RegisterMagic("lumos", {
	name = "Lumos",
	delay = 1,
	cmd = "lumos_hp",
	codeauthor = "HK47",
	haveValidEff = true,
	StopUse = true,
	TimeSprite = true,
	desc = "makes light",
	
	throwprop = function(ply) end,
	
	valideff = function(ply)
		ply:SetNWVector("SpellColor", Vector(0, 150, 255))
	
		if CLIENT then
			local dlight = DynamicLight(ply:EntIndex())
			dlight.Pos = ply:GetActiveWeapon():GetPos()
			dlight.r = 0
			dlight.g = 150
			dlight.b = 255
			dlight.Brightness = 1
			dlight.Size = math.random(300, 400)
			dlight.Decay = 1
			dlight.DieTime = CurTime() + 0.1
			dlight.Style = 0
		end
	end,
	
	attack = function(ply, pos) end,
	
	validoff = function(ply)
		
	end
})
