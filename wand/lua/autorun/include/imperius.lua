//Imperius

AddCSLuaFile()

if SERVER then
	util.AddNetworkString("client_hooks_hp")
	util.AddNetworkString("client_hooks_hp_remove")
end

local function Exit(ply)
	hook.Remove("PlayerDeath", "hp_imperius_checkdie" .. ply:EntIndex()) //removing hooks
	hook.Remove("PlayerSay", "hp_imperius_nosay" .. ply:EntIndex())
	hook.Remove("Think", "hp_imperius_control" .. ply:EntIndex())
	hook.Remove("PlayerDisconnected", "hp_imperius_checkdis" .. ply:EntIndex())
	ply.ControlledEnt:ConCommand("-forward")
	ply.ControlledEnt:ConCommand("-back")
	ply.ControlledEnt:ConCommand("-moveright")
	ply.ControlledEnt:ConCommand("-moveleft")
	ply.ControlledEnt:ConCommand("-jump")
	ply.ControlledEnt:ConCommand("-speed")
	ply.ControlledEnt:ConCommand("-attack")
	
	
	net.Start("client_hooks_hp_remove") //removing client hooks
		net.WriteEntity(ply)
	net.Send(ply)
	
	ply:SetWalkSpeed(200)
	ply:SetRunSpeed(400)
	ply:SetJumpPower(200)
	ply:ChatPrint("You have lost control over a player")
	
	ply.IsControllinghp = false
	ply.ControlledEnt.IsControlledhp = false //ply.ControlledEnt is ENT(ent) that was controlled by us ENT.IsControlledhp is variable that check controll
	ply.ControlledEnt = nil
end

hp_mstick.RegisterMagic("imperius", {
	name = "Imperius",
	delay = 3,
	cmd = "imperius_hp",
	codeauthor = "HK47",
	adminonly = true,
	desc = "controls your enemy",
	
	throwprop = function(ply)
		if ply:KeyPressed(IN_ATTACK) then
			if ply.Leghp then ply:ChatPrint("Please destroy your legilimens effect!") return end
		
			if ply.IsControllinghp then //exit
				Exit(ply)
				
				return
			end
		
			local tr = util.TraceHull {
				start = ply:GetShootPos(),
				endpos = ply:GetShootPos() + ply:GetAimVector() * 1500,
				filter = ply,
				mins = Vector(-10, -10, -10),
				maxs = Vector(10, 10, 10)
			}
			
			local ent = tr.Entity
			
			if IsValid(ent) and ent:IsPlayer() then
				if ent.IsControlledhp then ply:ChatPrint("This player is controlled!") return end //dont need controll this player again
				if ply.IsControllinghp then return end //player cant controll >1 players
				
				ply:ChatPrint("You have got controll over a player")
				
				ply:SetWalkSpeed(0)
				ply:SetRunSpeed(0)
				ply:SetJumpPower(0)
				ply:ConCommand("-forward")
				ply:ConCommand("-back")
				ply:ConCommand("-moveright")
				ply:ConCommand("-moveleft")
				ply:ConCommand("-jump")
				ply:ConCommand("-speed")
				ply:ConCommand("-attack")
				
				hook.Add("PlayerDeath", "hp_imperius_checkdie" .. ply:EntIndex(), function(victim, inflictor, attacker)
					if victim == ply then
						Exit(ply)
					end
				end)
				
				hook.Add("PlayerDisconnected", "hp_imperius_checkdis" .. ply:EntIndex(), function(pl)
					if pl == ent then
						Exit(ply)
					end
					
					if pl == ply then
						hook.Remove("PlayerDeath", "hp_imperius_checkdie" .. ply:EntIndex()) //removing hooks
						hook.Remove("PlayerSay", "hp_imperius_nosay" .. ply:EntIndex())
						hook.Remove("Think", "hp_imperius_control" .. ply:EntIndex())
						hook.Remove("PlayerDisconnected", "hp_imperius_checkdis" .. ply:EntIndex())
						ent:ConCommand("-forward")
						ent:ConCommand("-back")
						ent:ConCommand("-moveright")
						ent:ConCommand("-moveleft")
						ent:ConCommand("-jump")
						ent:ConCommand("-speed")
						ent:ConCommand("-attack")
					
						ent.IsControlledhp = false
					end
				end)
				
				timer.Simple(0.1, function()
					local str = ""
					
					hook.Add("PlayerSay", "hp_imperius_nosay" .. ply:EntIndex(), function(pl, text, team)
						if pl == ply then
							ent:ConCommand("say " .. text)
							str = text
							
							timer.Simple(0.2, function() str = "" end)
							
							return ""
						end
					
						if pl == ent then
							return str
						end
					end)
				end)
				
				hook.Add("Think", "hp_imperius_control" .. ply:EntIndex(), function()
					if not IsValid(ply.ControlledEnt) then return end
				
					ply.ControlledEnt:SetEyeAngles(ply:EyeAngles())
					
					if ply:KeyDown(IN_RELOAD) then
						ply.ControlledEnt:ConCommand("+attack")
					else
						ply.ControlledEnt:ConCommand("-attack")
					end
				
					if ply:KeyDown(IN_FORWARD) then
						ply.ControlledEnt:ConCommand("+forward")
					else
						ply.ControlledEnt:ConCommand("-forward")
					end
					
					if ply:KeyDown(IN_JUMP) then
						ply.ControlledEnt:ConCommand("+jump")
					else
						ply.ControlledEnt:ConCommand("-jump")
					end
					
					if ply:KeyDown(IN_SPEED) then
						ply.ControlledEnt:ConCommand("+speed")
					else
						ply.ControlledEnt:ConCommand("-speed")
					end
					
					if ply:KeyDown(IN_BACK) then
						ply.ControlledEnt:ConCommand("+back")
					else
						ply.ControlledEnt:ConCommand("-back")
					end
					
					if ply:KeyDown(IN_MOVERIGHT) then
						ply.ControlledEnt:ConCommand("+moveright")
					else
						ply.ControlledEnt:ConCommand("-moveright")
					end
					
					if ply:KeyDown(IN_MOVELEFT) then
						ply.ControlledEnt:ConCommand("+moveleft")
					else
						ply.ControlledEnt:ConCommand("-moveleft")
					end
				end)
				
				net.Start("client_hooks_hp")
					net.WriteEntity(ply)
					net.WriteEntity(ent)
				net.Send(ply)
				
				//variables for controll
				ply.IsControllinghp = true
				ply.ControlledEnt = ent
				ent.IsControlledhp = true
			end
		end
	end,
	
	attack = function(ply, pos)
	end
})