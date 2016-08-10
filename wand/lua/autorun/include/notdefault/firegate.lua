//Firegate

AddCSLuaFile()

hp_mstick.RegisterMagic("firegate", {
	name = "Firegate",
	delay = 3,
	cmd = "firegate_hp",
	codeauthor = "HK47",
	nodefault = true,
	noreturn = true,
	adminonly = true,
	desc = "makes ring of fire",
	
	throwprop = function(ply)
		local tr = util.TraceLine {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 400,
			filter = ply
		}
	
		if SERVER then
			local ent = ents.Create("entity_fire_hp")
			ent:SetPos(tr.HitPos)
			ent:SetOwner(ply)
			ent:Spawn()
		end
		
		local ef = EffectData()
		ef:SetOrigin(tr.HitPos)
		util.Effect("effect_bigexplodehp", ef)
	end,
	
	attack = function(ply, pos)
	end
})