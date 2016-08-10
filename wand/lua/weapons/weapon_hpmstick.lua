//Harry potter magic stick

AddCSLuaFile()

SWEP.PrintName			= "Wand"			
SWEP.Author				= "HK47"
SWEP.Slot				= 3
SWEP.SlotPos			= 1

SWEP.Base				= "weapon_base"
SWEP.Category			= "Harry Potter"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false

SWEP.ViewModel = "models/mstick/c_magstick.mdl"
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"

SWEP.DrawAmmo = true

SWEP.Weight				= 1
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.ShowWorldModel = false
SWEP.WandModel = "models/mstick/w_magshp.mdl"

SWEP.UseHands = true

SWEP.BobScale = 4

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-7, 0, -10), angle = Angle(40, 40, 40) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 40) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 40, -40) },
	["ValveBiped.Bip01_R_Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -14, 0) },
	["ValveBiped.Bip01_R_Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -16, -5) }
}

if SERVER then
	util.AddNetworkString("setMagicTypeHP")
	util.AddNetworkString("stop_create_spell")
elseif CLIENT then
	function chat_error_hp(text)
		chat.AddText(Color(255, 0, 0), "ERROR: " .. text)
	end

	surface.CreateFont("MagicStickFont1", {
		font = "Segoe UI",
		size = ScrH() / 20,
		weight = 0,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	})
	
	surface.CreateFont("MagicStickFont2", {
		font = "Segoe UI",
		size = ScrH() / 55,
		weight = 0,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	})

	surface.CreateFont("MagicStickFont3", {
		font = "Segoe UI",
		size = ScrH() / 40,
		weight = 0,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	})

	
	SWEP.VElements = {
		["s"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 2.5, -13.5), size = { x = 0, y = 0 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
		["m"] = { type = "Model", model = SWEP.WandModel, bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2, 1.55, 3), angle = Angle(-165, 0, 0), size = Vector(0.82, 0.82, 0.82), color = Color(255, 255, 255, 255), surpresslightning = false, material = "mstick/w_magshp", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["m"] = { type = "Model", model = SWEP.WandModel, bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 1.557, 2.596), angle = Angle(180, 0, 0), size = Vector(0.82, 0.82, 0.82), color = Color(255, 255, 255, 255), surpresslightning = false, material = "mstick/w_magshp", skin = 0, bodygroup = {} }
	}
end

function SWEP:Initialize()
	self:SetHoldType("melee")

	if SERVER then
		self:SetNWFloat("MStickMag", 1)
		self:SetNWBool("ValidEff", false)
		
		//waiting for valid owner
		timer.Simple(0.1, function()
			local name = file.Read("harry_potter/last_spell.txt", "DATA")
					
			for k, v in pairs(hp_mstick.GetMagic()) do
				if name == v.name then
					if file.Exists("harry_potter_cfg/" .. v.cmd .. ".txt", "DATA") and not self.Owner:IsAdmin() then self.Owner:ChatPrint("You're not admin!") return end
					
					self:SetNWFloat("MStickMag", k)
					break
				end
			end
		
			//set up admin spells information
			local text = ""
			
			for k, v in pairs(hp_mstick.GetMagic()) do
				if file.Exists("harry_potter_cfg/" .. v.cmd .. ".txt", "DATA") then
					text = text .. v.name .. ", "
				end
			end
			
			text = string.SetChar(text, string.len(text) - 1, "")
		
			net.Start("set_adminonly_spells_hp")
				net.WriteString(text)
			net.Send(self.Owner)
		end)
	elseif CLIENT then
		self.Window = nil
		
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements)
		self:CreateModels(self.WElements)

		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)

				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					vm:SetColor(Color(255,255,255,1))
					vm:SetMaterial("Debug/hsv")			
				end
			end
		end
	end
end

function SWEP:PrimaryAttack()
	local tab = hp_mstick.GetMagic()
	local mag = tab[self:GetNWFloat("MStickMag")]
	
	if self.Owner:GetNWBool("SpellStopSay") then return end
	if self.Owner:GetNWBool("SpellMimbleWimble") then self.Owner:SetNWFloat("SpellCount", math.random(1, #tab)) mag = tab[self.Owner:GetNWFloat("SpellCount")] end
	
	self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	self:SetNextPrimaryFire(CurTime() + mag.delay)
	
	if SERVER and file.Exists("harry_potter_cfg/" .. mag.cmd .. ".txt", "DATA") and not self.Owner:IsAdmin() then 
		self.Owner:ChatPrint("You're not admin!") 
		
		net.Start("stop_create_spell")
		net.Send(self.Owner)
		
		return 
	end
	
	if CLIENT then
		local no = false
		
		net.Receive("stop_create_spell", function() no = true end)
		
		if no then return end
	end
	
	self.Weapon:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 100, 130)
	
	if not GetConVar("hp_nosayspell"):GetBool() and SERVER then
		RunConsoleCommand(self.Owner and 'say', mag.name .. '!')
	end

	if not mag.noreturn and CLIENT then return end
	
	local tab = hp_mstick.GetMagic()
	local mag = tab[self:GetNWFloat("MStickMag")]
	
	if self.Owner:GetNWBool("SpellMimbleWimble") then mag = tab[self.Owner:GetNWFloat("SpellCount")] end
	
	if mag.haveValidEff then self:SetNWBool("ValidEff", true) end
	
	mag.throwprop(self.Owner)
end

function SWEP:SecondaryAttack()
end

function SWEP:DrawHUD()
	if SERVER then return end
	if not GetConVar("hp_enablehud"):GetBool() then return end
	
	local tab = hp_mstick.GetMagic()
	local mag = tab[self:GetNWFloat("MStickMag")]
	
	if not mag then return end
	
	surface.SetDrawColor(Color(0, 0, 0))
	surface.DrawOutlinedRect(ScrW() / 4.1, ScrH() / 1.1, ScrW() / 2.4, ScrH() / 20)
	
	draw.DrawText("CURRENT SPELL: " .. string.upper(mag.name), "MagicStickFont1", (ScrW() / 4) + math.cos(CurTime() * 6)*2, (ScrH() / 1.1) + math.sin(CurTime() * 3), Color(0, 0, 0))
	draw.DrawText("CURRENT SPELL: " .. string.upper(mag.name), "MagicStickFont1", ScrW() / 4, ScrH() / 1.1, Color(255, 255, 255))
end

function SWEP:Holster()
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
		
		local tab = hp_mstick.GetMagic()
		local mag = tab[self:GetNWFloat("MStickMag")]
		
		if mag.name then file.Write("harry_potter/last_spell.txt", mag.name) end
	end
	
	return true
end

function SWEP:OnRemove()
	if CLIENT then
		if self.Window and IsValid(self.Window) then
			self.Window:Close()
			self.Window = nil
		end
	end

	self:Holster()
end

function SWEP:HUDShouldDraw(name)
	if SERVER then return end
	
	if name == "CHudCrosshair" and self.Window and IsValid(self.Window) then return false end
	return true
end

//set up some stuff
if CLIENT then SWEP.Delay = 0 SWEP.SpriteSize = 0 end

function SWEP:Think()
	if self:GetNWBool("ValidEff") then
		local tab = hp_mstick.GetMagic()
		local mag = tab[self:GetNWFloat("MStickMag")]
			
		if mag.TimeSprite and CLIENT then
			self.SpriteSize = math.random(18, 22)
			local col = self.Owner:GetNWVector("SpellColor")
			self.VElements["s"].color = Color(col.x, col.y, col.z, 255)
		end
			
		mag.valideff(self.Owner)
	end

	if CLIENT then
		if self.SpriteSize > 0 then
			self.SpriteSize = math.Approach(self.SpriteSize, 0, 0.2)
		end
		
		self.VElements["s"].size.x = self.SpriteSize
		self.VElements["s"].size.y = self.SpriteSize
		
		if self.Owner:KeyPressed(IN_ATTACK) and CurTime() > self.Delay then
			local tab = hp_mstick.GetMagic()
			local mag = tab[self:GetNWFloat("MStickMag")]
		
			self.Delay = CurTime() + mag.delay
			self.SpriteSize = 20 
			
			if not IsValid(self.Weapon) then return end
			
			local col = self.Owner:GetNWVector("SpriteColorHP")
			self.VElements["s"].color = Color(col.x, col.y, col.z, 255)
		end
	
		if self.Owner:KeyPressed(IN_ATTACK2) then
			if not self.Window then
				self.Favourite = {}
				
				local spells = hp_mstick.GetMagic()
				
				for k, v in pairs(spells) do
					if file.Exists("harry_potter/" .. v.name .. ".txt", "DATA") then
						table.insert(self.Favourite, v.name)
					end
				end
			
				self.Window = vgui.Create("DFrame")
				self.Window:Center()
				self.Window:SetSize(608, 450)
				self.Window:SetTitle(" ")
				self.Window:ShowCloseButton(false)
				
				local alph = 0
				
				self.Window:MakePopup()
				//self.Window:SetDraggable(false)
				self.Window.Paint = function()
					if self.Window and IsValid(self.Window) then
						if alph < 200 then alph = alph + 3 end
					
						local w = self.Window:GetWide()
						local t = self.Window:GetTall()
					
						draw.RoundedBox(0, 0, 0, w, t, Color(0, 0, 0, alph))
					end
				end
				
				timer.Create("open_help_window", 2, 1, function()
					if self.Window and IsValid(self.Window) then
						local helpw = vgui.Create("DFrame", self.Window)
						helpw:SetSize(195, 50)
						helpw:ShowCloseButton(false)
						local x, y = self.Window:GetPos()
						helpw:SetPos(x + 410, y - 50)
						helpw:SetTitle("You need a help? Press Help button")
						helpw:MakePopup()
						helpw.Paint = function()
							local w = helpw:GetWide()
							local t = helpw:GetTall()
							
							local x1, y1 = helpw:GetPos()
							
							draw.RoundedBox(0, 0, 0, w, t - 20, Color(0, 0, 0, alph))
							
							surface.SetDrawColor(Color(255, 0, 0, 255))
							surface.DrawOutlinedRect(0, 0, w, t - 20)
							surface.DrawPoly( triangle )
						end
						
						timer.Create("close_help_window", 3, 1, function()
							if helpw and IsValid(helpw) then
								helpw:Close()
							end
						end)
					end
				end)
				
				local Credits = vgui.Create("DButton", self.Window)
				Credits:SetPos(580, 10)
				Credits:SetSize(20, 20)
				Credits:SetColor(Color(255, 255, 255))
				Credits:SetText("?")
				Credits:SetFont("MagicStickFont2")
				Credits.DoClick = function()
					local Cred = vgui.Create("DFrame")
					Cred:SetSize(300, 120)
					Cred:Center()
					Cred:SetTitle("Credits")
					Cred:MakePopup()
					Cred.Paint = function()
						local w = Cred:GetWide()
						local t = Cred:GetTall()
						
						draw.RoundedBox(0, 0, 0, w, t, Color(0, 0, 0, alph))
					end
					
					local lab = vgui.Create("DLabel", Cred)
					lab:SetPos(12.5, 30)
					lab:SetText("Made by kekc\nTesters: RAWR Garry, Commander_Shepard, Black \n \nSpecial thanks to Mr. Mind for idea!")
					lab:SizeToContents()
				end
				Credits.Paint = function()
					local w = Credits:GetWide()
					local t = Credits:GetTall()
					
					draw.RoundedBox(0, 0, 0, w, t, Color(100, 255, 100, alph * 0.7))
				end
				
				local help = vgui.Create("DButton", self.Window)
				help:SetPos(530, 10)
				help:SetSize(40, 20)
				help:SetText("Help")
				help:SetFont("MagicStickFont2")
				help:SetColor(Color(255, 255, 255))
				help.DoClick = function()
					local helpm = vgui.Create("DFrame")
					helpm:SetSize(260, 560)
					helpm:Center()
					helpm:SetTitle("Help menu")
					helpm:MakePopup()
					helpm.Paint = function()
						local w = helpm:GetWide()
						local t = helpm:GetTall()
						
						draw.RoundedBox(0, 0, 0, w, t, Color(0, 0, 0, alph))
					end
					
					local img = vgui.Create("HTML", helpm)
					img:SetPos(10, 360)
					img:SetSize(240, 190)
					img:OpenURL("http://cs618727.vk.me/v618727158/16c3b/cUYFF0xjC1Q.jpg")
					
					local lab = vgui.Create("DLabel", helpm)
					lab:SetPos(12.5, 30)
					lab:SetText("For admins:\n \nIf you want make spell admin only\ntype /adminonly_hp spellaname_hp into chat\n \nIf you want make spell non admin type\n/unadminonly_hp spellname_hp\n \nIf this commands does nothing\ntype /(un)adminonly_hp spellname_hp\n \nFor other players:\n \nFast FAQ\n \nQ: What is FAVOURITE SPELLS tab?\nA: Here is your favourite spells\nwhere you can add your fav. spells\n \nQ: How can i add spell to my fav. list?\nA: Type /addfav spellname_hp into chat\n \nQ: When i changed server fav spells will be\nremoved?\nA: No, it works everywhere")
					lab:SizeToContents()
					lab:SetColor(Color(255, 255, 255))
				end
				help.Paint = function()
					local w = help:GetWide()
					local t = help:GetTall()
					
					draw.RoundedBox(0, 0, 0, w, t, Color(100, 255, 100, alph * 0.7))
				end
				
				local btn = vgui.Create("DButton", self.Window)
				btn:SetPos(480, 10)
				btn:SetSize(40, 20)
				btn:SetText("X")
				btn:SetFont("MagicStickFont2")
				btn:SetColor(Color(255, 255, 255))
				btn.DoClick = function()
					if self.Window and IsValid(self.Window) then self.Window:Close() self.Window = nil else chat_error_hp("Window is not valid!") end
				end
				btn.Paint = function()
					local w = btn:GetWide()
					local t = btn:GetTall()
					
					draw.RoundedBox(0, 0, 0, w, t, Color(255, 100, 100, alph * 0.7))
				end
				
				local btn = vgui.Create("DButton", self.Window)
				btn:SetPos(320, 10)
				btn:SetSize(150, 20)
				btn:SetText("Admin only spells")
				btn:SetFont("MagicStickFont2")
				btn:SetColor(Color(255, 255, 255))
				btn.DoClick = function()
					if ADMIN_ONLY_SPELLS_HARRY_POTTER_WAND then
						chat.AddText(Color(0, 255, 0), "Admin only spells: " .. ADMIN_ONLY_SPELLS_HARRY_POTTER_WAND)
					else
						chat_error_hp("ADMIN_ONLY_SPELLS_HARRY_POTTER_WAND is not valid!")
					end
				end
				btn.Paint = function()
					local w = btn:GetWide()
					local t = btn:GetTall()
					
					draw.RoundedBox(0, 0, 0, w, t, Color(255, 100, 100, alph * 0.7))
				end
				
				local mg = vgui.Create("DListView", self.Window)
				mg:SetPos(12.5, 35)
				mg:SetSize(275, 330)
				mg:AddColumn("Spell name")
				mg.Paint = function() 
					local w = mg:GetWide()
					local t = mg:GetTall()
					
					draw.RoundedBox(0, 0, 0, w, t, Color(200, 250, 255, alph * 0.5))
				end
				
				//lab
				local num = 0
				
				for k, v in pairs(hp_mstick.GetMagic()) do
					if not v.nodefault then num = num + 1 end
				end
				
				local lab = vgui.Create("DLabel", self.Window)
				lab:SetPos(60, 370)
				lab:SetText("DEFAULT SPELLS (" .. num .. ")")
				lab:SetFont("Trebuchet24")
				lab:SizeToContents()
				
				for k, v in pairs(hp_mstick.GetMagic()) do
					if not v.nodefault then
						mg:AddLine(v.name, "")
					end
				end
				
				local desc = vgui.Create("DButton", self.Window)
				desc:SetPos(12.5, 400)
				desc:SetSize(585, 40)
				desc:SetText("Spells descritions")
				desc:SetFont("MagicStickFont3")
				desc.DoClick = function()
					desc:SetDisabled(true)
					///////////////////////////////////////////////////////////
					//description
					local win3 = vgui.Create("DFrame", self.Window)
					local x, y = self.Window:GetPos()
					win3:SetPos(x - 150, y - 250)
					win3:ShowCloseButton(false)
					win3:SetTitle("Spells description")
					win3:SetSize(758, 240)
					//win3:SetDraggable(false)
					win3:MakePopup()
					win3.Paint = function()
						if win3 and IsValid(win3) then
							local w = win3:GetWide()
							local t = win3:GetTall()
						
							draw.RoundedBox(0, 0, 0, w, t, Color(0, 0, 0, alph))
						end
					end
					
					local lab = vgui.Create("DLabel", win3)
					lab:SetPos(12.5, 150)
					lab:SetText("Click on line to get descrition")
					lab:SetFont("Trebuchet24")
					lab:SizeToContents()
					
					local spels = vgui.Create("DListView", win3)
					spels:SetPos(12.5, 25)
					spels:SetSize(708, 120)
					spels:AddColumn("Spell name")
					spels.Paint = function() 
						local w = spels:GetWide()
						local t = spels:GetTall()
						
						draw.RoundedBox(0, 0, 0, w, t, Color(200, 255, 255, alph * 0.5))
					end
					
					for k, v in pairs(hp_mstick.GetMagic()) do
						spels:AddLine(v.name)
					end
					
					spels.OnClickLine = function(parent, line, isselected)
						for k, v in pairs(hp_mstick.GetMagic()) do
							if line:GetValue(1) == v.name then
								local text = "<NODESCRITION>"
							
								if v.desc then 
									text = "Command: " .. v.cmd .. "\n" .. v.name .. " - " .. v.desc
								end
							
								lab:SetText(text)
								lab:SizeToContents()
								break
							end
						end
					end
					/////////////////////////////////////////////////////////////
					/////////////////////////////////////////////////////////////
					/////////////////////////////////////////////////////////////
				end
				desc.Paint = function()
					local w = desc:GetWide()
					local t = desc:GetTall()
					
					draw.RoundedBox(0, 0, 0, w, t, Color(100, 255, 100, alph * 0.7))
				end
				
				mg.OnClickLine = function(parent, line, isselected)
					self.Window:Close()
					self.Window = nil
					
					if not self.Weapon or not self then return end
					
					net.Start("setMagicTypeHP")
						net.WriteEntity(self)
						net.WriteString(line:GetValue(1))
					net.SendToServer()
				end
				
				//no default spells
				local mg2 = vgui.Create("DListView", self.Window)
				mg2:SetPos(320, 35)
				mg2:SetSize(275, 330)
				mg2:AddColumn("Spell name")
				mg2.Paint = function() 
					local w = mg:GetWide()
					local t = mg:GetTall()
					
					draw.RoundedBox(0, 0, 0, w, t, Color(200, 255, 255, alph * 0.5))
				end
				
				//lab
				local num = 0
				
				for k, v in pairs(hp_mstick.GetMagic()) do
					if v.nodefault then num = num + 1 end
				end
				
				local lab = vgui.Create("DLabel", self.Window)
				lab:SetPos(350, 370)
				lab:SetText("NOT DEFAULT SPELLS (" .. num .. ")")
				lab:SetFont("Trebuchet24")
				lab:SizeToContents()
				
				for k, v in pairs(hp_mstick.GetMagic()) do
					if v.nodefault then
						mg2:AddLine(v.name, "")
					end
				end
				
				mg2.OnClickLine = function(parent, line, isselected)
					self.Window:Close()
					self.Window = nil
					
					if not self.Weapon or not self then return end
					
					net.Start("setMagicTypeHP")
						net.WriteEntity(self)
						net.WriteString(line:GetValue(1))
					net.SendToServer()
				end
				
				local num = 0
				
				for k, v in pairs(self.Favourite) do
					num = num + 1
				end
				
				local win2 = vgui.Create("DFrame", self.Window)
				local x, y = self.Window:GetPos()
				win2:SetPos(x - 150, y)
				win2:ShowCloseButton(false)
				win2:SetTitle("FAVOURITE SPELLS (" .. num .. ")")
				win2:SetSize(150, 400)
				//win2:SetDraggable(false)
				win2:MakePopup()
				win2.Paint = function()
					if win2 and IsValid(win2) then
						local w = win2:GetWide()
						local t = win2:GetTall()
					
						draw.RoundedBox(0, 0, 0, w, t, Color(0, 0, 0, alph))
					end
				end
				
				local lab = vgui.Create("DLabel", win2)
				lab:SetPos(10, 370)
				lab:SetText("Total spells: " .. #hp_mstick.GetMagic())
				lab:SetFont("Trebuchet24")
				lab:SizeToContents()
				
				local mg3 = vgui.Create("DListView", win2)
				mg3:SetPos(12.5, 35)
				mg3:SetSize(125, 330)
				mg3:AddColumn("Spell name")
				mg3.Paint = function() 
					local w = mg:GetWide()
					local t = mg:GetTall()
					
					draw.RoundedBox(0, 0, 0, w, t, Color(200, 255, 255, alph * 0.5))
				end
				
				for k, v in pairs(self.Favourite) do
					mg3:AddLine(v)
				end
				
				mg3.OnClickLine = function(parent, line, isselected)
					self.Window:Close()
					self.Window = nil
					
					if not self.Weapon or not self then return end
					
					net.Start("setMagicTypeHP")
						net.WriteEntity(self)
						net.WriteString(line:GetValue(1))
					net.SendToServer()
				end
			end
		end
	else
		net.Receive("setMagicTypeHP", function()
			local wep = net.ReadEntity()
			local name = net.ReadString()
				
			for k, v in pairs(hp_mstick.GetMagic()) do
				if name == v.name then
					if file.Exists("harry_potter_cfg/" .. v.cmd .. ".txt", "DATA") and not wep.Owner:IsAdmin() then wep.Owner:ChatPrint("You're not admin!") return end
					
					if hp_mstick.GetMagic()[wep:GetNWFloat("MStickMag")].holster_func then hp_mstick.GetMagic()[wep:GetNWFloat("MStickMag")].holster_func(wep.Owner) end
					
					local tab = hp_mstick.GetMagic()
					local mag = tab[wep:GetNWFloat("MStickMag")]
					
					if wep:GetNWBool("ValidEff") and mag.StopUse then 
						mag.validoff(wep.Owner)
						wep:SetNWBool("ValidEff", false)
					end
						
					wep:SetNWFloat("MStickMag", k)
					wep.Owner:ChatPrint(v.name)
					break
				end
			end
		end)
	end
end







if CLIENT then

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then
			
			// we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}

			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			// when the weapon is dropped
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			// Technically, if there exists an element with the same name as a bone
			// you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r // Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		// Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				// make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			// !! WORKAROUND !! //
			// We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			// !! ----------- !! //
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				// !! ----------- !! //
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	/**************************
		Global utility code
	**************************/

	// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	// Does not copy entities of course, only copies their reference.
	// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end