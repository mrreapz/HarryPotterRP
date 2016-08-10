//Wingardium Leviosa

AddCSLuaFile()

local function closeMagic(ply)
	if IsValid(ply) then
		ply.hp_InWingardium = false
	end
	
	if timer.Exists("stop_lev_hp" .. ply:EntIndex()) then timer.Destroy("stop_lev_hp" .. ply:EntIndex()) end
	hook.Remove("Think", "levitation_hp" .. ply:EntIndex())
end

hp_mstick.RegisterMagic("wingardium_leviosa", {
	name = "Wingardium Leviosa",
	delay = 0.5,
	cmd = "wingardium_leviosa_hp",
	codeauthor = "HK47",
	desc = "wingardiuuum leviooooosaaaaaa | levitation",

	holster_func = function(ply)
		closeMagic(ply)
	end,
	
	throwprop = function(ply)
		if ply:KeyPressed(IN_ATTACK) and not ply.hp_InWingardium then
			local distance_tr = 1200
			
			local tr = util.TraceHull {
				start = ply:GetShootPos(),
				endpos = ply:GetShootPos() + ply:GetAimVector() * distance_tr,
				filter = ply,
				mins = Vector(-20, -20, -20),
				maxs = Vector(20, 20, 20)
			}
			
			local ent = tr.Entity
			
			if IsValid(ent) and IsValid(ent:GetPhysicsObject()) and not ent:IsPlayer() and not ent:IsNPC() then
				ply.hp_InWingardium = true //static shit
				distance_tr = ply:GetPos():Distance(ent:GetPos()) // changes distance_tr
				
				if not ply.firstuse then ply:ChatPrint("R/E keys - move object") end
				ply.firstuse = true // print this shit one time
				
				hook.Add("Think", "levitation_hp" .. ply:EntIndex(), function()
					if not IsValid(ent) then closeMagic(ply) return end
					if not IsValid(ply) or not ply:Alive() then closeMagic(ply) return end
					if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() != "weapon_hpmstick" then closeMagic(ply) return end
					
					if ply:KeyDown(IN_USE) then
						if distance_tr < 3000 then distance_tr = distance_tr + 15 end
					end
				
					if ply:KeyDown(IN_RELOAD) then
						if distance_tr > 200 then distance_tr = distance_tr - 15 end
					end
				
					local tr = util.TraceLine {
						start = ply:GetShootPos(),
						endpos = ply:GetShootPos() + ply:GetAimVector() * distance_tr,
						filter = { ent, ply }
					}
						
					ent:GetPhysicsObject():ApplyForceCenter(((tr.HitPos - ent:GetPos()) - ent:GetPhysicsObject():GetVelocity()) * ent:GetPhysicsObject():GetMass())
				end)
				
				timer.Create("stop_lev_hp" .. ply:EntIndex(), 20, 1, function()
					closeMagic(ply)
				end)
			end
		elseif ply:KeyPressed(IN_ATTACK) and ply.hp_InWingardium then
			closeMagic(ply)
		end
	end,
	
	attack = function(ply, pos)
	end
})