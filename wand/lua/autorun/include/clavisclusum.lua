//Clavisclusum

AddCSLuaFile()

hp_mstick.RegisterMagic("clavisclusum", {
	name = "Clavisclusum",
	delay = 1.5,
	cmd = "alohomora_hp",
	codeauthor = "HK47",
	desc = "makes shield from alohomora | counter spell",
	
	throwprop = function(ply)
		local tr = util.TraceLine {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 80,
			filter = ply
		}
		
		ply:EmitSound("phx/explode0" .. math.random(1, 6) .. ".wav", 100, 200)
		
		local ent = tr.Entity
		
		if IsValid(ent) and (ent:GetClass() == "keypad" or ent:GetClass() == "keypad_wire") then
			ent:SetNWBool("SpellClosedMagic", true)
		end
	end,
	
	attack = function(ply, pos)
	end
})