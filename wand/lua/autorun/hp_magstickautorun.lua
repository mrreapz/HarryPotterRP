require("hp_mstick")
AddCSLuaFile()

include("include/rictusempra.lua")
include("include/everte_statum.lua")
include("include/avada_kedavra.lua")
include("include/avis.lua")
include("include/accio.lua")
include("include/lumos.lua")
include("include/episkey.lua")
include("include/crucio.lua")
include("include/ascendio.lua")
include("include/petrificus_totalus.lua")
include("include/expulso.lua")
include("include/bombardo.lua")
include("include/waddiwasi.lua")
include("include/bombardo_max.lua")
include("include/verdimillious.lua")
include("include/vulnera_sanentur.lua")
include("include/incendio.lua")
include("include/expelliarmus.lua")
include("include/confringo.lua")
include("include/arresto_momentum.lua")
include("include/reducto.lua")
include("include/sectumsempra.lua")
include("include/engorgio.lua")
include("include/fumos.lua")
include("include/tarantallegra.lua")
include("include/reducio.lua")
include("include/protego.lua")
include("include/imperius.lua")
include("include/stupefy.lua")
include("include/alohomora.lua")
include("include/clavisclusum.lua")
include("include/conjunctivitus.lua")
include("include/wingardium_leviosa.lua")
include("include/legilimens.lua")
include("include/protego_totalum.lua")
include("include/mimble_wimble.lua")
include("include/salvio_gexia.lua")
include("include/castrare_depingitur.lua")
include("include/slagus_erectos.lua")
include("include/impedimenta.lua")
include("include/aguamenti.lua")
include("include/spongify.lua")
include("include/apparition.lua")

//not default spells

include("include/notdefault/dragoner.lua")
include("include/notdefault/forbefire.lua")
include("include/notdefault/fireball.lua")
include("include/notdefault/timesum.lua")
include("include/notdefault/dremboom.lua")
include("include/notdefault/punch.lua")
include("include/notdefault/speedavec.lua")
include("include/notdefault/flarus.lua")
include("include/notdefault/stonemani.lua")
include("include/notdefault/armageddon.lua")
include("include/notdefault/stonestorm.lua")
include("include/notdefault/walkspeeden.lua")
include("include/notdefault/sportal.lua")
include("include/notdefault/bamberlodia.lua")
include("include/notdefault/perfectium.lua")
include("include/notdefault/firegate.lua")
include("include/notdefault/gonfiare.lua")
include("include/notdefault/def.lua")
include("include/notdefault/mostro.lua")
include("include/notdefault/sparksosprite.lua")
include("include/notdefault/faaf.lua")
include("include/notdefault/faaf_maxima.lua")
include("include/notdefault/storm.lua")
include("include/notdefault/motus.lua")
include("include/notdefault/secare.lua")
include("include/notdefault/green_curse.lua")
include("include/notdefault/anti_curse.lua")
include("include/notdefault/erucae.lua")
include("include/notdefault/blackrow.lua")
include("include/notdefault/heal.lua")
include("include/notdefault/dwisp.lua")
include("include/notdefault/vimaeris.lua")
include("include/notdefault/aulon.lua")
include("include/notdefault/signal.lua")
include("include/notdefault/shield.lua")
include("include/notdefault/speedom.lua")
include("include/notdefault/maf.lua")
include("include/notdefault/winborium.lua")
include("include/notdefault/blackhole.lua")
include("include/notdefault/stors.lua")

if SERVER then
	util.AddNetworkString("server_say_spell_fav")
	util.AddNetworkString("server_say_rem_spell_fav")
	util.AddNetworkString("server_say_spell_clear")
	util.AddNetworkString("set_adminonly_spells_hp")
	
	if not file.Exists("harry_potter_cfg", "DATA") then
		file.CreateDir("harry_potter_cfg")
	end
elseif CLIENT then
	CreateClientConVar("hp_enablehud", "1", true, false)
	CreateClientConVar("hp_enablefulldraw", "1", true, false)
	
	CreateClientConVar("hp_ap_r", "1", true, false)
	CreateClientConVar("hp_ap_g", "1", true, false)
	CreateClientConVar("hp_ap_b", "1", true, false)
	CreateClientConVar("hp_ap_a", "255", true, false)

	local function WandSettings(p)
		p:AddControl("Label", { Text = "Client settings" })
		p:AddControl("CheckBox", { Label = "Enable HUD", Command = "hp_enablehud"})
		p:AddControl("CheckBox", { Label = "Enable spell draw", Command = "hp_enablefulldraw"})
		p:AddControl("Color", {
			Label = "Apparition smoke color",
			Red = "hp_ap_r",
			Blue = "hp_ap_b",
			Green = "hp_ap_g",
			Alpha = "hp_ap_a",
			ShowHSV = 1,
			ShowRGB = 1,
			Multiplier = 255
		})
	end

	hook.Add("PopulateToolMenu", "magwand_kekc_menu", function() spawnmenu.AddToolMenuOption("Utilities", "Magic Wand", "MagicWand", "Configuration", "", "", WandSettings) end)

	if not file.Exists("harry_potter", "DATA") then
		file.CreateDir("harry_potter")
	end
end

if not GetConVar("hp_nosayspell") then
	CreateConVar("hp_nosayspell", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "People gonna say spell?")
end

function findSpell(name)
	for k, v in pairs(hp_mstick.GetMagic()) do
		if string.lower(name) == v.cmd then
			return v
		end
	end
	
	return false
end

hook.Add("PlayerSay", "server_check_fav", function(ply, text, team)
	if CLIENT then return end
	
	if string.lower(string.sub(text, 1, 13)) == "/adminonly_hp" then
		if ply:IsAdmin() then
			local v = findSpell(string.sub(text, 15))
		
			if v then
				if not file.Exists("harry_potter_cfg/" .. v.cmd .. ".txt", "DATA") then
					file.Write("harry_potter_cfg/" .. v.cmd .. ".txt", "void")
					ply:ChatPrint("Done!")
						
					local text = ""
						
					for k, z in pairs(hp_mstick.GetMagic()) do
						if file.Exists("harry_potter_cfg/" .. z.cmd .. ".txt", "DATA") then
							text = text .. z.name .. "\n"
						end
					end
					
					net.Start("set_adminonly_spells_hp")
						net.WriteString(text)
					net.Broadcast()
				else 
					ply:ChatPrint("This spell is already admin only!") 
				end
			end
		else
			ply:ChatPrint("You're not admin!")
		end
	end
	
	if string.lower(string.sub(text, 1, 15)) == "/unadminonly_hp" then
		if ply:IsAdmin() then
			local v = findSpell(string.sub(text, 17))
		
			if v then
				if file.Exists("harry_potter_cfg/" .. v.cmd .. ".txt", "DATA") then
					file.Delete("harry_potter_cfg/" .. v.cmd .. ".txt")
					ply:ChatPrint("Done!")
						
					local text = ""
						
					for k, v in pairs(hp_mstick.GetMagic()) do
						if file.Exists("harry_potter_cfg/" .. v.cmd .. ".txt", "DATA") then
							text = text .. v.name .. "\n"
						end
					end
						
					net.Start("set_adminonly_spells_hp")
						net.WriteString(text)
					net.Broadcast()
				else 
					ply:ChatPrint("This spell is not admin only!") 
				end
			end
		else
			ply:ChatPrint("You're not admin!")
		end
	end
	
	if string.lower(string.sub(text, 1, 7)) == "/addfav" then
		local v = findSpell(string.sub(text, 9))
	
		if v then
			net.Start("server_say_spell_fav")
				net.WriteString(v.name)
				net.WriteEntity(ply)
			net.Send(ply)
		end
	end
	
	if string.lower(string.sub(text, 1, 9)) == "/clearfav" then
		net.Start("server_say_spell_clear")
			net.WriteEntity(ply)
		net.Send(ply)
	end
	
	if string.lower(string.sub(text, 1, 10)) == "/removefav" then
		local v = findSpell(string.sub(text, 12))
	
		if v then
			net.Start("server_say_rem_spell_fav")
				net.WriteString(v.name)
				net.WriteEntity(ply)
			net.Send(ply)
		end
	end
end)

if CLIENT then	
	ADMIN_ONLY_SPELLS_HARRY_POTTER_WAND = nil

	net.Receive("set_adminonly_spells_hp", function()
		local spells = net.ReadString()
		
		if not spells or spells == "" then spells = "No admin spells!" end
		
		print("You received admin spells information!")
		
		ADMIN_ONLY_SPELLS_HARRY_POTTER_WAND = spells
	end)

	net.Receive("server_say_spell_fav", function()
		local spell = net.ReadString()
		local ply = net.ReadEntity()
		local wep = ply:GetActiveWeapon()
		
		if file.Exists("harry_potter/" .. spell .. ".txt", "DATA") then ply:ChatPrint("This spell is already in your favourite list!") return end
		
		file.Write("harry_potter/" .. spell .. ".txt", spell)
		
		ply:ChatPrint("Done!")
	end)
	
	net.Receive("server_say_rem_spell_fav", function()
		local spell = net.ReadString()
		local ply = net.ReadEntity()
		local wep = ply:GetActiveWeapon()
		
		if not file.Exists("harry_potter/" .. spell .. ".txt", "DATA") then ply:ChatPrint("Can't find... try again!") return end
		
		if file.Exists("harry_potter/" .. spell .. ".txt", "DATA") then
			file.Delete("harry_potter/" .. spell .. ".txt")
		end
		
		ply:ChatPrint("Done!")
	end)
	
	net.Receive("client_hooks_hp_remove", function()
		local ply = net.ReadEntity()
	
		hook.Remove("CalcView", "hp_imperius_view" .. ply:EntIndex())
		hook.Remove("ShouldDrawLocalPlayer", "hp_imperius_sh" .. ply:EntIndex())
	end)
	
	net.Receive("client_conj_hp", function()
		local ply = net.ReadEntity()
	
		hook.Add("RenderScreenspaceEffects", "client_render_hp" .. ply:EntIndex(), function()
			local tab = {}
			tab["$pp_colour_addr"] = 0
			tab["$pp_colour_addg"] = 0
			tab["$pp_colour_addb"] = 0
			tab["$pp_colour_brightness"] = 0
			tab["$pp_colour_contrast"] = 0
			tab["$pp_colour_colour"] = 0
			tab["$pp_colour_mulr"] = 0
			tab["$pp_colour_mulg"] = 0
			tab["$pp_colour_mulb"] = 0
		 
			DrawColorModify(tab)
		end)
		
		timer.Simple(2, function()
			hook.Remove("RenderScreenspaceEffects", "client_render_hp" .. ply:EntIndex())
		end)
	end)
	
	net.Receive("client_hooks_hp", function()
		local ply = net.ReadEntity()
		local ent = net.ReadEntity()
	
		hook.Add("CalcView", "hp_imperius_view" .. ply:EntIndex(), function()
			if not IsValid(ent) then hook.Remove("CalcView", "hp_imperius_view" .. ply:EntIndex()) return end
		
			local view = {}

			local head = ent:LookupAttachment("eyes")
			
			if not head then
				head = ent:LookupAttachment("Eye")
				
				if not head then
					head = ent:LookupAttachment("anim_attachment_head")
				end
			end
			
			local at = ent:GetAttachment(head)
			
			local pos
			
			if at and at.Pos then
				pos = at.Pos
			else
				pos = ent:GetPos() + Vector(0, 0, 75)
			end
			
			view.origin = pos
			view.angles = ent:EyeAngles()
			view.fov = 90
				 
			return view
		end)
				
		hook.Add("ShouldDrawLocalPlayer", "hp_imperius_sh" .. ply:EntIndex(), function(ply)
			return true
		end)
	end)
	
	//legilimens
	net.Receive("client_hooks_hp_remove2", function()
		local ply = net.ReadEntity()
	
		hook.Remove("CalcView", "hp_leg_view" .. ply:EntIndex())
		hook.Remove("ShouldDrawLocalPlayer", "hp_leg_sh" .. ply:EntIndex())
	end)
	
	net.Receive("client_hooks_hp2", function()
		local ply = net.ReadEntity()
		local ent = net.ReadEntity()
	
		hook.Add("CalcView", "hp_leg_view" .. ply:EntIndex(), function()
			if not IsValid(ent) then hook.Remove("CalcView", "hp_leg_view" .. ply:EntIndex()) return end
		
			local view = {}

			local head = ent:LookupAttachment("eyes")
			
			if not head then
				head = ent:LookupAttachment("Eye")
				
				if not head then
					head = ent:LookupAttachment("anim_attachment_head")
				end
			end
			
			local at = ent:GetAttachment(head)
			local pos
			
			if at and at.Pos then
				pos = at.Pos
			else
				pos = ent:GetPos() + Vector(0, 0, 75)
			end
			
			view.origin = pos
			view.angles = ent:EyeAngles()
			view.fov = 90
				 
			return view
		end)
				
		hook.Add("ShouldDrawLocalPlayer", "hp_leg_sh" .. ply:EntIndex(), function(ply)
			return true
		end)
	end)
end
