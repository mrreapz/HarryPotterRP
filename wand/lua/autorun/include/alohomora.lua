//Alohomora

AddCSLuaFile()

hp_mstick.RegisterMagic("alohomora", {
	name = "Alohomora",
	delay = 1.5,
	cmd = "alohomora_hp",
	codeauthor = "HK47",
	desc = "opens doors",
	
	throwprop = function(ply)
		local tr = util.TraceLine {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 70,
			filter = ply
		}
		
		ply:EmitSound("phx/explode0" .. math.random(1, 6) .. ".wav", 100, 200)
		
		local ent = tr.Entity
		
		if IsValid(ent) then ent:Input("Open") end
		
		if ent.isFadingDoor and ent.fadeActivate and not ent:GetNWBool("SpellClosedMagic") then //DarkRP door
			if not ent.fadeActive then
				ent:fadeActivate()
				
				timer.Simple(5, function() if ent.fadeActive then ent:fadeDeactivate() end end)
			end
		end
		
		if IsValid(ent) and (ent:GetClass() == "keypad" or ent:GetClass() == "keypad_wire") and not ent:GetNWBool("SpellClosedMagic") then
			ent:Process(true)
		end
	end,
	
	attack = function(ply, pos)
	end
})