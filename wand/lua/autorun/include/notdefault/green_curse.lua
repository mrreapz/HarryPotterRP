//Green curse

AddCSLuaFile()

hp_mstick.RegisterMagic("green_curse", {
	name = "Green curse",
	delay = 1,
	cmd = "green_curse_hp",
	codeauthor = "HK47",
	nodefault = true,
	desc = "makes zombie spawner, counter spell - Anti curse",
	
	throwprop = function(ply)
		local vector = ply:GetAimVector()
	
		local spell = ents.Create("entity_spell_fly")
		local ang = ply:EyeAngles()
		spell:SetPos(ply:GetShootPos() + ang:Right() * 15 + vector * 8 - ang:Up() * 5)
		spell:SetAngles(ply:EyeAngles())
		spell:SetOwner(ply)
		spell:Spawn()
		
		//settings
		spell:SetNWFloat("SpellType", ply:GetActiveWeapon():GetNWFloat("MStickMag"))
		spell:SetNWVector("SpellColor", Vector(50, 255, 50))
		spell:SetNWFloat("SpellSize", 1)
	end,
	
	attack = function(ply, pos)
		local p = pos.HitPos
		
		ply.Next_spawn_zombie_hp = 0
		
		hook.Add("Think", "zombie_spawner_hp" .. ply:EntIndex(), function()
			if not IsValid(ply) then hook.Remove("Think", "zombie_spawner_hp" .. ply:EntIndex()) return end
			
			for k, v in pairs(ents.FindInSphere(p, 600)) do
				if v:GetNWBool("spell_antizombiesp") then
					util.ScreenShake(p, 20, 20, 3, 4000)
					v:EmitSound("phx/explode0" .. math.random(1, 5) .. ".wav", 100, 110)
					
					hook.Remove("Think", "zombie_spawner_hp" .. ply:EntIndex())
				end
			end
			
			if CurTime() > ply.Next_spawn_zombie_hp then
				local ef = EffectData()
				ef:SetOrigin(p)
				util.Effect("effect_green_smoke_hp", ef)
				
				local s = p + Vector(0, 0, 10)
				local vec = VectorRand()
				vec.z = 0
				
				local tr = util.TraceLine {
					start = s,
					endpos = s + (vec * 120),
					filter = NULL
				}
				
				local zombies = {
					"npc_fastzombie",
					"npc_zombie",
					"npc_poisonzombie"
				}
				
				local ent = ents.Create(table.Random(zombies))
				ent:SetPos(tr.HitPos)
				ent:Spawn()
				
				ply.Next_spawn_zombie_hp = CurTime() + 1
			end
		end)
	end
})