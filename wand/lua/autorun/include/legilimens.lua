//Legilimens

AddCSLuaFile()

if SERVER then
	util.AddNetworkString("client_hooks_hp2")
	util.AddNetworkString("client_hooks_hp_remove2")
end

local function Exit(ply)
	hook.Remove("PlayerDeath", "hp_leg_checkdie" .. ply:EntIndex()) //removing hooks
	hook.Remove("PlayerDisconnected", "hp_leg_checkdis" .. ply:EntIndex())
	hook.Remove("Think", "hp_leg_checkdis" .. ply:EntIndex())
	
	net.Start("client_hooks_hp_remove2") //removing client hooks
		net.WriteEntity(ply)
	net.Send(ply)
	
	ply:SetMoveType(MOVETYPE_WALK)
	ply:ChatPrint("You have lost cam over a player | npc")
	
	ply.Leghp = false
	if IsValid(ply.LegEnt) then ply.LegEnt.Leghp = false end //ply.ControlledEnt is ENT(ent) that was controlled by us ENT.IsControlledhp is variable that check controll
	ply.LegEnt = nil
end

hp_mstick.RegisterMagic("legilimens", {
	name = "Legilimens",
	delay = 3,
	cmd = "legilimens_hp",
	codeauthor = "HK47",
	desc = "makes your spectate about your enemy",
	
	throwprop = function(ply)
		if ply:KeyPressed(IN_ATTACK) then
			if ply.IsControllinghp then ply:ChatPrint("Please destroy your imperius effect!") return end
		
			if ply.Leghp then //exit
				Exit(ply)
				
				return
			end
		
			local tr = util.TraceHull {
				start = ply:GetShootPos(),
				endpos = ply:GetShootPos() + ply:GetAimVector() * 1300,
				filter = ply,
				mins = Vector(-10, -10, -10),
				maxs = Vector(10, 10, 10)
			}
			
			local ent = tr.Entity
			
			if IsValid(ent) then
				if ent:IsPlayer() then
					if ent.Leghp then ply:ChatPrint("This player cant be controlled!") return end //dont need controll this player again
					if ply.Leghp then return end //player cant controll >1 players
					
					ply:ChatPrint("You have got cam over a player")
					
					ply:SetMoveType(MOVETYPE_NONE)
					
					hook.Add("PlayerDeath", "hp_leg_checkdie" .. ply:EntIndex(), function(victim, inflictor, attacker)
						if victim == ply then
							Exit(ply)
						end
					end)
					
					hook.Add("PlayerDisconnected", "hp_leg_checkdis" .. ply:EntIndex(), function(pl)
						if pl == ent then
							Exit(ply)
						end
						
						if pl == ply then
							hook.Remove("PlayerDeath", "hp_leg_checkdie" .. ply:EntIndex()) //removing hooks
							hook.Remove("PlayerDisconnected", "hp_leg_checkdis" .. ply:EntIndex())
						
							ent.Leghp = false
						end
					end)
					
					net.Start("client_hooks_hp2")
						net.WriteEntity(ply)
						net.WriteEntity(ent)
					net.Send(ply)
					
					//variables for controll
					ply.Leghp = true
					ply.LegEnt = ent
					ent.Leghp = true
				end
				
				if ent:IsNPC() then
					if ent.Leghp then ply:ChatPrint("This player cant be controlled!") return end //dont need controll this player again
					if ply.Leghp then return end //player cant controll >1 players
					
					ply:ChatPrint("You have got cam over a npc")
					
					ply:SetMoveType(MOVETYPE_NONE)
					
					hook.Add("PlayerDeath", "hp_leg_checkdie" .. ply:EntIndex(), function(victim, inflictor, attacker)
						if victim == ply then
							Exit(ply)
						end
					end)
					
					hook.Add("Think", "hp_leg_checkdis" .. ply:EntIndex(), function()
						if not IsValid(ent) then
							Exit(ply)
						end
						
						if not IsValid(ply) then
							hook.Remove("PlayerDeath", "hp_leg_checkdie" .. ply:EntIndex()) //removing hooks
							hook.Remove("PlayerDisconnected", "hp_leg_checkdis" .. ply:EntIndex())
							hook.Remove("Think", "hp_leg_checkdis" .. ply:EntIndex())
						
							ent.Leghp = false
						end
					end)
					
					net.Start("client_hooks_hp2")
						net.WriteEntity(ply)
						net.WriteEntity(ent)
					net.Send(ply)
					
					//variables for controll
					ply.Leghp = true
					ply.LegEnt = ent
					ent.Leghp = true
				end
			end
		end
	end,
	
	attack = function(ply, pos)
	end
})