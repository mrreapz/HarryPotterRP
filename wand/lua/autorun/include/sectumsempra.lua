//Sectumsempra

AddCSLuaFile()

local function Die(ent)
	ent:TakeDamage(math.random(20, 30))
	local ef = EffectData()
	ef:SetOrigin(ent:GetPos() + Vector(0, 0, 50))
	util.Effect("effect_bloodhp", ef)
end

hp_mstick.RegisterMagic("sectumsempra", {
	name = "Sectumsempra",
	delay = 2.5,
	cmd = "sectumsempra_hp",
	codeauthor = "HK47",
	desc = "kills your enemy in 3 seconds",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetOwner(ply)
		spell:Spawn()
		
		//settings
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
		spell:SetNWVector("SpellColor", Vector(255, 0, 0))
		spell:SetNWFloat("SpellSize", 2.5)
	end,
	
	attack = function(ply, pos)
		local ent = pos.HitEntity
		
		local npcs = {
			"npc_metropolice",
			"CombinePrison",
			"PrisonShotgunner",
			"ShotgunSoldier",
			"npc_stalker",
			"CombineElite", 
			"npc_combine_s",
			"npc_monk",
			"npc_alyx",
			"npc_barney",
			"npc_citizen",
			"npc_magnusson",
			"npc_kleiner",
			"npc_mossman",
			"npc_eli",
			"npc_gman",
			"Medic",
			"npc_odessa",
			"Rebel",
			"Refugee",
			"VortigauntUriah",
			"npc_vortigaunt",
			"VortigauntSlave",
			"npc_breen",
			"npc_zombie",
			"npc_antlion",
			"npc_poisonzombie",
			"npc_fastzombie",
			"npc_zombie_torso",
			"npc_fastzombie_torso",
			"npc_zombine",
			"npc_crow",
			"npc_pigeon",
			"npc_seagull"
		}
		
		if IsValid(ent) then		
			if ent:IsPlayer() then
				Die(ent)
				timer.Create("Die", 1, 4, function()
					if not IsValid(ent) then return end
							
					Die(ent)
				end)
			elseif ent:IsNPC() then
				for k, v in pairs(npcs) do
					if ent:GetClass() == v then
						Die(ent)
						timer.Create("Die", 1, 4, function()
							if not IsValid(ent) then return end
							
							Die(ent)
						end)
						
						break
					end
				end
			end
		end
	end
})