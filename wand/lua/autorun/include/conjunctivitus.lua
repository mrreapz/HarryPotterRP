//Conjunctivitus

AddCSLuaFile()

if SERVER then
	util.AddNetworkString("client_conj_hp")
end

hp_mstick.RegisterMagic("conjunctivitus", {
	name = "Conjunctivitus",
	delay = 1.1,
	cmd = "conjunctivitus_hp",
	codeauthor = "HK47",
	noreturn = true,
	desc = "makes the black screen for your enemy",
	
	throwprop = function(ply)
		local tr = util.TraceLine {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 1500,
			filter = ply
		}
		
		local ent = tr.Entity
		
		if IsValid(ent) and ent:IsPlayer() then
			if SERVER then
				net.Start("client_conj_hp")
					net.WriteEntity(ent)
				net.Send(ent)
			end
		end
	end,
	
	attack = function(ply, pos)
	end
})