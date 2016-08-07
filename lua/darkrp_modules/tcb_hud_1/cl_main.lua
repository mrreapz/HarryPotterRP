/*---------------------------------------------------------------------------
	
	Creator: TheCodingBeast - TheCodingBeast.com
	This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
	To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/
	
---------------------------------------------------------------------------*/

local hideHUDElements = {
		--DarkRP hud
        ["DarkRP_HUD"] = true,
        ["DarkRP_EntityDisplay"] = false,
        ["DarkRP_ZombieInfo"] = false,
        ["DarkRP_LocalPlayerHUD"] = true,
        ["DarkRP_Agenda"] = false,
		["DarkRP_Hungermod"] = true,
		--Default hud
		["CHudHealth"] = true,
		["CHudBattery"] = true,
		["CHudSuitPower"] = true
}
hook.Add("HUDShouldDraw", "HideDefaultDarkRPHud", function(name)
        if hideHUDElements[name] then return false end
end)

/*---------------------------------------------------------------------------
Hud Settings
---------------------------------------------------------------------------*/

local HUD 	= {}

HUD.Width 	= 400
HUD.Height 	= 125

HUD.X = "left" 			-- left / center / right
HUD.Y = "bottom"; 		-- bottom / center / top

HUD.HealthColor = Color(255, 0, 0, 150)
HUD.ArmorColor 	= Color(0, 150, 255, 150)

HUD.ShowLicenseWanted = false  	-- true / false

-- Language

HUD.Wallet 	= "Galleons"
HUD.Salary 	= "Salary"
HUD.Health 	= "Health"
HUD.Armor 	= "Edginess"

HUD.License1= "No License"
HUD.License2= "License"

HUD.Wanted1	= "Not Wanted"
HUD.Wanted2 = "Wanted"

/*---------------------------------------------------------------------------
Hud Settings Process
---------------------------------------------------------------------------*/

local Border = 15

if HUD.X == "left" then
	HUD.PosX = Border
elseif HUD.X == "center" then
	HUD.PosX = ScrW() / 2 - HUD.Width / 2
elseif HUD.X == "right" then
	HUD.PosX = ScrW() - Border
else
	HUD.PosX = Border
end

if HUD.Y == "bottom" then
	HUD.PosY = ScrH() - HUD.Height - Border
elseif HUD.Y == "center" then
	HUD.PosY = ScrH() / 2 - HUD.Height / 2
elseif HUD.Y == "top" then
	if HUD.ShowLicenseWanted == true then
		HUD.PosY = Border + 24
	else
		HUD.PosY = Border
	end
else
	HUD.PosY = ScrH() - Border
end

/*---------------------------------------------------------------------------
Base
---------------------------------------------------------------------------*/

local function formatNumber(n)
	if not n then return "" end
	if n >= 1e14 then return tostring(n) end
	n = tostring(n)
	local sep = sep or ","
	local dp = string.find(n, "%.") or #n+1
	for i=dp-4, 1, -3 do
		n = n:sub(1, i) .. sep .. n:sub(i+1)
	end
	return n
end

local function HudBase()
	draw.RoundedBox(6, HUD.PosX, HUD.PosY, HUD.Width, HUD.Height, Color(0, 0, 0, 200))
	
	surface.SetFont("TCBFont")
end

local function HudArmor()
	draw.RoundedBox(6, HUD.PosX+5, HUD.PosY+HUD.Height-24-5, HUD.Width-10, 24, Color(0, 0, 0, 200))
	
	local Armor = LocalPlayer():Armor() or 0
	local FullArmor = LocalPlayer():Armor() or 0
	if Armor < 0 then Armor = 0 elseif Armor > 100 then Armor = 100 end
	
	if Armor != 0 then
		draw.RoundedBox(6, HUD.PosX+5+2, HUD.PosY+HUD.Height-24-5+2, (HUD.Width-10-4) * Armor / 100, 24-4, HUD.ArmorColor)
	end
	
	draw.DrawText(HUD.Armor..": "..FullArmor, "TCBFont", HUD.PosX+HUD.Width/2+1, HUD.PosY+HUD.Height-24-5+3+1, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.DrawText(HUD.Armor..": "..FullArmor, "TCBFont", HUD.PosX+HUD.Width/2, HUD.PosY+HUD.Height-24-5+3, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local function HudHealth()
	draw.RoundedBox(6, HUD.PosX+5, HUD.PosY+HUD.Height-48-10, HUD.Width-10, 24, Color(0, 0, 0, 200))
	
	local Health = LocalPlayer():Health() or 0
	local FullHealth = LocalPlayer():Health() or 0
	if Health < 0 then Health = 0 elseif Health > 100 then Health = 100 end
	local DrawHealth = math.Min(Health/GAMEMODE.Config.startinghealth, 1)
	
	if Health != 0 then
		draw.RoundedBox(6, HUD.PosX+5+2, HUD.PosY+HUD.Height-48-10+2, (HUD.Width-10-4) * DrawHealth, 24-4, HUD.HealthColor)
	end
	
	draw.DrawText(HUD.Health..": "..FullHealth, "TCBFont", HUD.PosX+HUD.Width/2+1, HUD.PosY+HUD.Height-48-10+3+1, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.DrawText(HUD.Health..": "..FullHealth, "TCBFont", HUD.PosX+HUD.Width/2, HUD.PosY+HUD.Height-48-10+3, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local function HudName()
	draw.RoundedBox(6, HUD.PosX+5, HUD.PosY+HUD.Height-72-15, HUD.Width/2-10, 24, Color(0, 0, 0, 200))

	local DrawName = LocalPlayer():Nick() or ""
	local namew,nameh = surface.GetTextSize(DrawName)
	while namew > (HUD.Width/2-10) do
		DrawName = string.sub(DrawName, 1, DrawName:len()-6).."..."
		namew,nameh = surface.GetTextSize(DrawName)
	end
	
	draw.DrawText(DrawName, "TCBFont", HUD.PosX+5+HUD.Width/4-7.5+1, HUD.PosY+HUD.Height-72-15+3+1, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.DrawText(DrawName, "TCBFont", HUD.PosX+5+HUD.Width/4-7.5, HUD.PosY+HUD.Height-72-15+3, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local function HudJob()
	draw.RoundedBox(6, HUD.PosX+5+HUD.Width/2, HUD.PosY+HUD.Height-72-15 , HUD.Width/2-10, 24, Color(0, 0, 0, 200))
	
	local DrawJob = LocalPlayer():getDarkRPVar("job") or ""
	local jobw,jobh = surface.GetTextSize(DrawJob)
	while jobw > (HUD.Width/2-10) do
		DrawJob = string.sub(DrawJob, 1, DrawJob:len()-6).."..."
		jobw,jobh = surface.GetTextSize(DrawJob)
	end

	draw.DrawText(DrawJob, "TCBFont", HUD.PosX+5+HUD.Width/2+HUD.Width/4-7.5+1, HUD.PosY+HUD.Height-72-15+3+1, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.DrawText(DrawJob, "TCBFont", HUD.PosX+5+HUD.Width/2+HUD.Width/4-7.5, HUD.PosY+HUD.Height-72-15+3, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local function HudMoney()
	draw.RoundedBox(6, HUD.PosX+5, HUD.PosY+HUD.Height-96-20 , HUD.Width/2-10, 24, Color(0, 0, 0, 200))
	
	local DrawMoney = HUD.Wallet..": £"..formatNumber(LocalPlayer():getDarkRPVar("money") or 0)
	local moneyw,moneyh = surface.GetTextSize(DrawMoney)
	while moneyw > (HUD.Width/2-10) do
		DrawMoney = string.sub(DrawMoney, 1, DrawMoney:len()-6).."..."
		moneyw,moneyh = surface.GetTextSize(DrawMoney)
	end
	
	draw.DrawText(DrawMoney, "TCBFont", HUD.PosX+5+HUD.Width/4-7.5+1, HUD.PosY+HUD.Height-96-15-2+1, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.DrawText(DrawMoney, "TCBFont", HUD.PosX+5+HUD.Width/4-7.5, HUD.PosY+HUD.Height-96-15-2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local function HudSalary()
	draw.RoundedBox(6, HUD.PosX+5+HUD.Width/2, HUD.PosY+HUD.Height-96-20 , HUD.Width/2-10, 24, Color(0, 0, 0, 200))

	local DrawSalary = HUD.Salary..": £"..formatNumber(LocalPlayer():getDarkRPVar("salary") or 0)
	local salaryw,salaryh = surface.GetTextSize(DrawSalary)
	while salaryw > (HUD.Width/2-10) do
		DrawSalary = string.sub(DrawSalary, 1, DrawSalary:len()-6).."..."
		salaryw,salaryh = surface.GetTextSize(DrawSalary)
	end
	
	draw.DrawText(DrawSalary, "TCBFont", HUD.PosX+5+HUD.Width/2+HUD.Width/4-7.5+1, HUD.PosY+HUD.Height-96-15-2+1, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.DrawText(DrawSalary, "TCBFont", HUD.PosX+5+HUD.Width/2+HUD.Width/4-7.5, HUD.PosY+HUD.Height-96-15-2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local function HudLicense()
	draw.RoundedBoxEx(6, HUD.PosX+HUD.Width/4-50, HUD.PosY-24, 100, 24, Color(0, 0, 0, 200), true, true, false, false)
	if LocalPlayer():getDarkRPVar("HasGunlicense") then
		draw.DrawText(HUD.License2, "TCBFont", HUD.PosX+HUD.Width/4+1, HUD.PosY-24+4+1, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.DrawText(HUD.License2, "TCBFont", HUD.PosX+HUD.Width/4, HUD.PosY-24+4, Color(0, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	else
		draw.DrawText(HUD.License1, "TCBFont", HUD.PosX+HUD.Width/4+1, HUD.PosY-24+4+1, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.DrawText(HUD.License1, "TCBFont", HUD.PosX+HUD.Width/4, HUD.PosY-24+4, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end

local function HudWanted()
	draw.RoundedBoxEx(6, HUD.PosX+HUD.Width-HUD.Width/4-50, HUD.PosY-24, 100, 24, Color(0, 0, 0, 200), true, true, false, false)
	if LocalPlayer():getDarkRPVar("wanted") then
		draw.DrawText(HUD.Wanted2, "TCBFont", HUD.PosX+HUD.Width-HUD.Width/4+1, HUD.PosY-24+4+1, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.DrawText(HUD.Wanted2, "TCBFont", HUD.PosX+HUD.Width-HUD.Width/4, HUD.PosY-24+4, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	else
		draw.DrawText(HUD.Wanted1, "TCBFont", HUD.PosX+HUD.Width-HUD.Width/4+1, HUD.PosY-24+4+1, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.DrawText(HUD.Wanted1, "TCBFont", HUD.PosX+HUD.Width-HUD.Width/4, HUD.PosY-24+4, Color(0, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)	end
end

local function HudClass()
	local currentJob = LocalPlayer():getDarkRPVar("Job")
	local houseMessage = ""

	if currentJob == TEAM_SLYTHERIN then
		houseMessage = houseClass[house.slytherin]

	elseif currentJob == TEAM_RAVENCLAW then
		houseMessage = houseClass[house.ravenclaw]

	elseif currentJob == TEAM_HUFFLEPUFF then
		houseMessage = houseClass[house.hufflepuff]

	elseif currentJob == TEAM_GRYFFINDOR then 
		houseMessage = houseClass[house.gryffindor]

    end
	--TODO: generate color based on LocalPlayer():getDarkRPVar("Job")
	draw.RoundedBoxEx(6, HUD.PosX+5, HUD.PosY+24, HUD.Width-10, 24, Color(255, 204, 102, 128), true, true, false, false)
	draw.DrawText(houseMessage, "TCBFont", HUD.PosX+5+HUD.Width/2+1, HUD.PosY+HUD.Height+24+3+1, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.DrawText(houseMessage, "TCBFont", HUD.PosX+5+HUD.Width/2, HUD.PosY+HUD.Height+24+3, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

/*---------------------------------------------------------------------------
HUD Draw
---------------------------------------------------------------------------*/
local function DrawTCB()
	
	HudBase()
	
	HudHealth()	
	HudArmor()
	
	HudName()
	HudJob()
	
	HudMoney()
	HudSalary()

	HudClass()
	
	if HUD.ShowLicenseWanted == true then
	HudLicense()
	HudWanted()
	end
	
end
hook.Add("HUDPaint", "DrawTCB", DrawTCB)


/*---------------------------------------------------------------------------
HUD ConVars
---------------------------------------------------------------------------*
local HUDWidth
local HUDHeight

local Color = Color
local cvars = cvars
local DarkRP = DarkRP
local CurTime = CurTime
local draw = draw
local GetConVar = GetConVar
local IsValid = IsValid
local Lerp = Lerp
local localplayer
local math = math
local pairs = pairs
local ScrW, ScrH = ScrW, ScrH
local SortedPairs = SortedPairs
local string = string
local surface = surface
local table = table
local timer = timer
local tostring = tostring

CreateClientConVar("weaponhud", 0, true, false)

local function ReloadConVars()
	HUDWidth = (GetConVar("HudW") or  CreateClientConVar("HudW", 240, true, false)):GetInt()
	HUDHeight = (GetConVar("HudH") or CreateClientConVar("HudH", 115, true, false)):GetInt()

	if not cvars.GetConVarCallbacks("HudW", false) and not cvars.GetConVarCallbacks("HudH", false) then
		cvars.AddChangeCallback("HudW", function() timer.Simple(0,ReloadConVars) end)
		cvars.AddChangeCallback("HudH", function() timer.Simple(0,ReloadConVars) end)
	end
end
ReloadConVars()

local Scrw, Scrh, RelativeX, RelativeY
/*---------------------------------------------------------------------------
HUD Seperate Elements
---------------------------------------------------------------------------*/

local function Agenda()
	local ply = LocalPlayer()

	local agenda = ply:getAgendaTable()
	if not agenda then return end

	draw.RoundedBox(10, 10, 10, 460, 110, Color(0, 0, 0, 155))
	draw.RoundedBox(10, 12, 12, 456, 106, Color(51, 58, 51,100))
	draw.RoundedBox(10, 12, 12, 456, 20, Color(0, 0, 70, 100))

	draw.DrawNonParsedText(agenda.Title, "DarkRPHUD1", 30, 12, Color(255, 0, 0, 255), 0)

	local text = ply:getDarkRPVar("agenda") or ""

	text = text:gsub("//", "\n"):gsub("\\n", "\n")
	text = DarkRP.textWrap(text, "DarkRPHUD1", 440)
	draw.DrawNonParsedText(text, "DarkRPHUD1", 30, 35, Color(255, 255, 255, 255), 0)
end

local VoiceChatTexture = surface.GetTextureID("voice/icntlk_pl")
local function DrawVoiceChat()
	if localplayer.DRPIsTalking then
		local chbxX, chboxY = chat.GetChatBoxPos()

		local Rotating = math.sin(CurTime()*3)
		local backwards = 0
		if Rotating < 0 then
			Rotating = 1-(1+Rotating)
			backwards = 180
		end
		surface.SetTexture(VoiceChatTexture)
		surface.SetDrawColor(Color(140,0,0,180))
		surface.DrawTexturedRectRotated(ScrW() - 100, chboxY, Rotating*96, 96, backwards)
	end
end

CreateConVar("DarkRP_LockDown", 0, {FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE})
local function LockDown()
	local chbxX, chboxY = chat.GetChatBoxPos()
	if util.tobool(GetConVarNumber("DarkRP_LockDown")) then
		local cin = (math.sin(CurTime()) + 1) / 2
		local chatBoxSize = math.floor(ScrH() / 4)
		draw.DrawNonParsedText(DarkRP.getPhrase("lockdown_started"), "ScoreboardSubtitle", chbxX, chboxY + chatBoxSize, Color(cin * 255, 0, 255 - (cin * 255), 255), TEXT_ALIGN_LEFT)
	end
end

local Arrested = function() end

usermessage.Hook("GotArrested", function(msg)
	local StartArrested = CurTime()
	local ArrestedUntil = msg:ReadFloat()

	Arrested = function()
		if CurTime() - StartArrested <= ArrestedUntil and localplayer:getDarkRPVar("Arrested") then
		draw.DrawNonParsedText(DarkRP.getPhrase("youre_arrested", math.ceil(ArrestedUntil - (CurTime() - StartArrested))), "DarkRPHUD1", ScrW()/2, ScrH() - ScrH()/12, Color(255, 255, 255, 255), 1)
		elseif not localplayer:getDarkRPVar("Arrested") then
			Arrested = function() end
		end
	end
end)

local AdminTell = function() end

usermessage.Hook("AdminTell", function(msg)
	timer.Destroy("DarkRP_AdminTell")
	local Message = msg:ReadString()

	AdminTell = function()
		draw.RoundedBox(4, 10, 10, ScrW() - 20, 100, Color(0, 0, 0, 200))
		draw.DrawNonParsedText(DarkRP.getPhrase("listen_up"), "GModToolName", ScrW() / 2 + 10, 10, Color(255, 255, 255, 255), 1)
		draw.DrawNonParsedText(Message, "ChatFont", ScrW() / 2 + 10, 80, Color(200, 30, 30, 255), 1)
	end

	timer.Create("DarkRP_AdminTell", 10, 1, function()
		AdminTell = function() end
	end)
end)

/*---------------------------------------------------------------------------
Drawing the HUD elements such as Health etc.
---------------------------------------------------------------------------*/
local function DrawHUD()
	localplayer = localplayer and IsValid(localplayer) and localplayer or LocalPlayer()
	if not IsValid(localplayer) then return end

	Scrw, Scrh = ScrW(), ScrH()
	RelativeX, RelativeY = 0, Scrh

	Agenda()
	DrawVoiceChat()
	LockDown()

	Arrested()
	AdminTell()
end

/*---------------------------------------------------------------------------
Entity HUDPaint things
---------------------------------------------------------------------------*/
local Page = Material("icon16/page_white_text.png")
local function DrawPlayerInfo(ply)
	local pos = ply:EyePos()

	pos.z = pos.z + 10 -- The position we want is a bit above the position of the eyes
	pos = pos:ToScreen()
	pos.y = pos.y - 50 -- Move the text up a few pixels to compensate for the height of the text

	if GAMEMODE.Config.showname and not ply:getDarkRPVar("wanted") then
		draw.DrawNonParsedText(ply:Nick(), "DarkRPHUD2", pos.x + 1, pos.y + 1, Color(0, 0, 0, 255), 1)
		draw.DrawNonParsedText(ply:Nick(), "DarkRPHUD2", pos.x, pos.y, team.GetColor(ply:Team()), 1)
	end

	if GAMEMODE.Config.showhealth and not ply:getDarkRPVar("wanted") then
		draw.DrawNonParsedText(DarkRP.getPhrase("health", ply:Health()), "DarkRPHUD2", pos.x + 1, pos.y + 21, Color(0, 0, 0, 255), 1)
		draw.DrawNonParsedText(DarkRP.getPhrase("health", ply:Health()), "DarkRPHUD2", pos.x, pos.y + 20, Color(255, 255, 255, 200), 1)
	end

	if GAMEMODE.Config.showjob then
		local teamname = team.GetName(ply:Team())
		draw.DrawNonParsedText(ply:getDarkRPVar("job") or teamname, "DarkRPHUD2", pos.x + 1, pos.y + 41, Color(0, 0, 0, 255), 1)
		draw.DrawNonParsedText(ply:getDarkRPVar("job") or teamname, "DarkRPHUD2", pos.x, pos.y + 40, Color(255, 255, 255, 200), 1)
	end

	if ply:getDarkRPVar("HasGunlicense") then
		surface.SetMaterial(Page)
		surface.SetDrawColor(255,255,255,255)
		surface.DrawTexturedRect(pos.x-16, pos.y + 60, 32, 32)
	end
end

local function DrawWantedInfo(ply)
	if not ply:Alive() then return end

	local pos = ply:EyePos()
	if not pos:isInSight({localplayer, ply}) then return end

	pos.z = pos.z + 14
	pos = pos:ToScreen()

	if GAMEMODE.Config.showname then
		draw.DrawNonParsedText(ply:Nick(), "DarkRPHUD2", pos.x + 1, pos.y + 1, Color(0, 0, 0, 255), 1)
		draw.DrawNonParsedText(ply:Nick(), "DarkRPHUD2", pos.x, pos.y, team.GetColor(ply:Team()), 1)
	end

	local wantedText = DarkRP.getPhrase("wanted", tostring(ply:getDarkRPVar("wantedReason")))

	draw.DrawNonParsedText(wantedText, "DarkRPHUD2", pos.x, pos.y - 40, Color(255, 255, 255, 200), 1)
	draw.DrawNonParsedText(wantedText, "DarkRPHUD2", pos.x + 1, pos.y - 41, Color(255, 0, 0, 255), 1)
end

/*---------------------------------------------------------------------------
The Entity display: draw HUD information about entities
---------------------------------------------------------------------------*/
local function DrawEntityDisplay()
	local shootPos = localplayer:GetShootPos()
	local aimVec = localplayer:GetAimVector()

	for k, ply in pairs(players or player.GetAll()) do
		if not ply:Alive() or ply == localplayer then continue end
		local hisPos = ply:GetShootPos()
		if ply:getDarkRPVar("wanted") then DrawWantedInfo(ply) end

		if GAMEMODE.Config.globalshow then
			DrawPlayerInfo(ply)
		-- Draw when you're (almost) looking at him
		elseif not GAMEMODE.Config.globalshow and hisPos:DistToSqr(shootPos) < 160000 then
			local pos = hisPos - shootPos
			local unitPos = pos:GetNormalized()
			if unitPos:Dot(aimVec) > 0.95 then
				local trace = util.QuickTrace(shootPos, pos, localplayer)
				if trace.Hit and trace.Entity ~= ply then return end
				DrawPlayerInfo(ply)
			end
		end
	end

	local tr = localplayer:GetEyeTrace()

	if IsValid(tr.Entity) and tr.Entity:isKeysOwnable() and tr.Entity:GetPos():Distance(localplayer:GetPos()) < 200 then
		tr.Entity:drawOwnableInfo()
	end
end

/*---------------------------------------------------------------------------
Drawing death notices
---------------------------------------------------------------------------*/
function GAMEMODE:DrawDeathNotice(x, y)
	if not GAMEMODE.Config.showdeaths then return end
	self.BaseClass:DrawDeathNotice(x, y)
end

/*---------------------------------------------------------------------------
Display notifications
---------------------------------------------------------------------------*/
local function DisplayNotify(msg)
	local txt = msg:ReadString()
	GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
	surface.PlaySound("buttons/lightswitch2.wav")

	-- Log to client console
	print(txt)
end
usermessage.Hook("_Notify", DisplayNotify)

/*---------------------------------------------------------------------------
Disable players names popping up when looking at them
---------------------------------------------------------------------------*/
function GAMEMODE:HUDDrawTargetID()
    return false
end

/*---------------------------------------------------------------------------
Actual HUDPaint hook
---------------------------------------------------------------------------*/
function GAMEMODE:HUDPaint()
	DrawHUD()
	DrawEntityDisplay()

	self.BaseClass:HUDPaint()
end
