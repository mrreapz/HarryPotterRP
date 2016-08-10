AddCSLuaFile()
module("hp_mstick", package.seeall)

local magics = {}

if SERVER then
	util.AddNetworkString( "set_adminonly_spells_hp" )
end

function RegisterMagic(name, tab)
	table.insert(magics, tab)
	
	if tab.fulladminonly and SERVER then
		if not file.Exists("harry_potter_cfg/" .. tab.cmd .. ".txt", "DATA") then
			file.Write("harry_potter_cfg/" .. tab.cmd .. ".txt", "void")
			
			local text = ""
			
			for k, v in pairs(hp_mstick.GetMagic()) do
				if file.Exists("harry_potter_cfg/" .. v.cmd .. ".txt", "DATA") then
					text = text .. v.name .. "\n"
				end
			end
			
			net.Start("set_adminonly_spells_hp")
				net.WriteString(text)
			net.Broadcast()
		end
	end
	
	/*concommand.Add(tab.cmd, function(caller)
		if caller:IsPlayer() then
			for k, v in pairs(magics) do
				if tab.cmd == v.cmd then
					if SERVER then
						if file.Exists("harry_potter_cfg/" .. v.cmd .. ".txt", "DATA") and not caller:IsAdmin() then caller:ChatPrint("You're not admin!") return end
					
						local mag = tab[caller:GetActiveWeapon():GetNWFloat("MStickMag")]
					
						if caller:GetActiveWeapon():GetNWBool("ValidEff") and v.StopUse then 
							mag.validoff(caller)
							caller:GetActiveWeapon():SetNWBool("ValidEff", false)
						end
					
						caller:GetActiveWeapon():SetNWFloat("MStickMag", k)
						caller:ChatPrint(v.name)
						break
					end
				end
			end
		end
	end)*/
end

function GetMagic()
	return magics
end

print("Harry potter magic stick has been loaded")