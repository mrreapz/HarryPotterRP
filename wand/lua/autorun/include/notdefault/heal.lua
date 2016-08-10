//Heal

AddCSLuaFile()

hp_mstick.RegisterMagic("heal", {
	name = "Heal",
	delay = 1,
	cmd = "heal_hp",
	codeauthor = "HK47",
	nodefault = true,
	noreturn = true,
	desc = "heals all players around you",
	
	throwprop = function(ply)
		for k, v in pairs(ents.FindInSphere(ply:GetPos(), 300)) do
			if IsValid(v) and v:IsPlayer() then
				if SERVER then
					local healamount = math.min(v:GetMaxHealth(), v:Health() + 20)
					v:SetHealth(healamount)
					
					v:EmitSound("garrysmod/save_load1.wav")
				end
				
				local ef = EffectData()
				ef:SetOrigin(v:GetPos())
				util.Effect("effect_heal_hp", ef)
			end
		end
		
		ply:EmitSound("hl1/fvox/bell.wav")
	end,
	
	attack = function(ply, pos)
	end
})