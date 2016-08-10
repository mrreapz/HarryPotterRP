//Flarus

AddCSLuaFile()

hp_mstick.RegisterMagic("flarus", {
	name = "Flarus",
	delay = 1,
	cmd = "flarus_hp",
	codeauthor = "HK47",
	noreturn = true,
	nodefault = true,
	desc = "pushes all around you",
	
	throwprop = function(ply)
		local tr = util.TraceLine {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 60,
			filter = ply
		}
		
		ply:EmitSound("phx/explode0" .. math.random(1, 6) .. ".wav", 100, 200)
		
		local ef = EffectData()
		ef:SetOrigin(tr.HitPos)
		ef:SetAngles(ply:EyeAngles())
		ef:SetStart(Vector(255, 255, 255)) //color
		ef:SetScale(1)
		util.Effect("effect_ringhp", ef)
		
		ply:ViewPunch(Angle(-10, 0, 0))
		
		if CLIENT then return end
		
		for k, v in pairs(ents.FindInSphere(ply:GetPos(), 130)) do
			if v:IsPlayer() or v:IsNPC() then
				if v != ply then v:SetVelocity(((v:GetPos() - ply:GetPos()):GetNormal() * 500) + Vector(0, 0, 300)) end
			else
				if IsValid(v:GetPhysicsObject()) then v:GetPhysicsObject():SetVelocity(((v:GetPos() - ply:GetPos()):GetNormal() * 800) + Vector(0, 0, 400)) end
			end
		end
	end,
	
	attack = function(ply, pos)
	end
})