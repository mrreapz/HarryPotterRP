//Faaf Maxima

AddCSLuaFile()

hp_mstick.RegisterMagic("faaf_maxima", {
	name = "Faaf Maxima",
	delay = 1.2,
	cmd = "faaf_maxima_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "makes rings, makes big damage in this rings",
	
	throwprop = function(ply)
		ply.count_kolca = 0
	
		timer.Create("make_kolca_" .. ply:EntIndex(), 0.08, 15, function()
			if IsValid(ply) then
				ply.count_kolca = ply.count_kolca + 60
			
				local tr = util.TraceLine {
					start = ply:GetShootPos(),
					endpos = ply:GetShootPos() + ply:GetAimVector() * ply.count_kolca,
					filter = ply
				}
				
				ply:EmitSound("phx/explode0" .. math.random(1, 6) .. ".wav", 100, 200)
				
				local ef = EffectData()
				ef:SetOrigin(tr.HitPos)
				ef:SetAngles(ply:EyeAngles())
				ef:SetStart(Vector(0, 255, 0)) //color
				ef:SetScale(3)
				util.Effect("effect_ringhp", ef)
				
				local ent = tr.Entity
				if IsValid(ent) then ent:TakeDamage(20) end
			end
		end)
	end,
	
	attack = function(ply, pos)
	end
})