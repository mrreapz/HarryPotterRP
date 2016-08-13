-----------------------------------------------------------------
-- @package     Arivia
-- @author      Richard
-- @build       v2.0.2
-- @release     07.14.2016
-- @owner       76561198035179751
-----------------------------------------------------------------
-- BY MODIFYING THIS FILE -- YOU UNDERSTAND THAT THE ABOVE 
-- MENTIONED AUTHORS CANNOT BE HELD RESPONSIBLE FOR ANY ISSUES
-- THAT ARISE. AS A CUSTOMER TO THE ORIGINAL PURCHASED COPY OF
-- THIS SCRIPT, YOU ARE ENTITLED TO STANDARD SUPPORT WHICH CAN
-- BE PROVIDED USING [SCRIPTFODDER.COM]. 
-- ONLY THE ORIGINAL PURCHASER OF THIS SCRIPT CAN RECEIVE SUPPORT.
-----------------------------------------------------------------

Arivia = Arivia or {}
Arivia.Language = Arivia.Language or {}

local PANEL = {}
local AriviaTickers = {}
local tabs = {}

-----------------------------------------------------------------
-- [ DISPLAY TICKER ]
-----------------------------------------------------------------

function Arivia:DisplayTicker(str, color)
    AriviaTickers.color = color
    AriviaTickers.CurrentAd = str
end

-----------------------------------------------------------------
-- [ NETWORK RECEIVERS ]
-----------------------------------------------------------------

net.Receive("AriviaSendTickerData", function(len)
    local vcol = net.ReadVector()
    Arivia:DisplayTicker(net.ReadString(), Color(vcol.x, vcol.y, vcol.z))
end)

-----------------------------------------------------------------
-- [ MATERIALS ]
-----------------------------------------------------------------

local ButtonClose = "arivia/arivia_button_close.png"
local ButtonSteam = "arivia/arivia_button_steam.png"

-----------------------------------------------------------------
-- [ SCROLLBAR PAINTING ]
-----------------------------------------------------------------

local META = FindMetaTable("Panel")

function META:ConstructScrollbarGUI()
    AriviaScrollbar = self

    AriviaScrollbar.Paint = function(AriviaScrollbar, w, h)
        surface.SetDrawColor(5, 5, 5, 200)
        surface.DrawRect(0, 0, w, h)
    end

    AriviaScrollbar.btnUp.Paint = function(AriviaScrollbar, w, h)
        surface.SetDrawColor(64, 105, 126, 190)
        surface.DrawRect(0, 0, w, h)
    end

    AriviaScrollbar.btnDown.Paint = function(AriviaScrollbar, w, h)
        surface.SetDrawColor(64, 105, 126, 190)
        surface.DrawRect(0, 0, w, h)
    end

    AriviaScrollbar.btnGrip.Paint = function(AriviaScrollbar, w, h)
        surface.SetDrawColor(52, 87, 104, 190)
        surface.DrawRect(0, 0, w, h)
    end
end

-----------------------------------------------------------------
-- [ DARKRP FUNCTIONS ]
-----------------------------------------------------------------

function AriviaAllowGunPurchase(ship)
    local ply = LocalPlayer()
    local playerJob = 1

    if IsValid(Arivia.Panel) then playerJob = Arivia.Panel.CurJob else playerJob = ply:Team() end

    if GAMEMODE.Config.restrictbuypistol and not table.HasValue(ship.allowed, playerJob) then return false, true end
    if ship.customCheck and not ship.customCheck(ply) then return false, true end
    local canbuy, suppress, message, price = hook.Call("canBuyPistol", nil, ply, ship)
    local cost = price or ship.getPrice and ship.getPrice(ply, ship.pricesep) or ship.pricesep
    --if not ply:canAfford(cost) then return false, false, cost end
    if canbuy == false then return false, suppress, cost end

    return true, nil, cost
end

function AriviaAllowEntityPurchase(item)
    local ply = LocalPlayer()
    local playerJob = 1

    if IsValid(Arivia.Panel) then playerJob = Arivia.Panel.CurJob else playerJob = ply:Team() end

    if istable(item.allowed) and not table.HasValue(item.allowed, playerJob) then return false, true end
    if item.customCheck and not item.customCheck(ply) then return false, true end
    local canbuy, suppress, message, price = hook.Call("canBuyCustomEntity", nil, ply, item)
    local cost = price or item.getPrice and item.getPrice(ply, item.price) or item.price
    --if not ply:canAfford(cost) then return false, false, cost end
    if canbuy == false then return false, suppress, cost end

    return true, nil, cost
end

function AriviaAllowAmmoPurchase(item)
    local ply = LocalPlayer()
    local playerJob = 1

    if IsValid(Arivia.Panel) then playerJob = Arivia.Panel.CurJob else playerJob = ply:Team() end

    if item.customCheck and not item.customCheck(ply) then return false, true end
    local canbuy, suppress, message, price = hook.Call("canBuyAmmo", nil, ply, item)
    local cost = price or item.getPrice and item.getPrice(ply, item.price) or item.price
    --if not ply:canAfford(cost) then return false, false, cost end
    if canbuy == false then return false, suppress, price end

    return true, nil, price
end

function AriviaAllowShipmentPurchase(ship)
    local ply = LocalPlayer()
    local playerJob = 1

    if IsValid(Arivia.Panel) then playerJob = Arivia.Panel.CurJob else playerJob = ply:Team() end

    if not table.HasValue(ship.allowed, playerJob) then return false, true end
    if ship.customCheck and not ship.customCheck(ply) then return false, true end
    local canbuy, suppress, message, price = hook.Call("canBuyShipment", nil, ply, ship)
    local cost = price or ship.getPrice and ship.getPrice(ply, ship.price) or ship.price
    --if not ply:canAfford(cost) then return false, false, cost end
    if canbuy == false then return false, suppress, cost end
    if ship.noship then return false end

    return true, nil, cost
end

function AriviaAllowJobSelection(job, maxTeamCheck)
    local ply = LocalPlayer()
    if maxTeamCheck and table.Count(team.GetPlayers(job.team)) >= (job.Max or 1337) then return false end
    if job.customCheck and not job.customCheck(ply) then return false end
    if job.admin == 1 and not (LocalPlayer():IsAdmin() or LocalPlayer():IsSuperAdmin()) then return false end

    return true
end

function AriviaAllowVehiclePurchase(item)
    local ply = LocalPlayer()
    local playerJob = 1

    if IsValid(Arivia.Panel) then playerJob = Arivia.Panel.CurJob else playerJob = ply:Team() end
    
    local cost = item.getPrice and item.getPrice(ply, item.price) or item.price
    if istable(item.allowed) and not table.HasValue(item.allowed, playerJob) then return false, true end
    if item.customCheck and not item.customCheck(ply) then return false, true end
    local canbuy, suppress, message, price = hook.Call("canBuyVehicle", nil, ply, item)
    cost = price or cost
    --if not ply:canAfford(cost) then return false, false, cost end
    if canbuy == false then return false, suppress, cost end

    return true, nil, cost
end

function AriviaAllowFoodPurchase(food)
    local ply = LocalPlayer()
    local playerJob = 1

    if (food.requiresCook == nil or food.requiresCook == true) and not ply:isCook() then return false, true end
    if food.customCheck and not food.customCheck(LocalPlayer()) then return false, false end

    if Arivia.TabFood.hideCannotBuy then
        if not ply:canAfford(food.price) then return false, false end
    end

    return true
end

function AriviaItemHidden(cantBuy, important)
    return cantBuy and (GAMEMODE.Config.hideNonBuyable or (important and GAMEMODE.Config.hideTeamUnbuyable))
end

-----------------------------------------------------------------
-- [ CLEAR PANELS ]
-----------------------------------------------------------------

function PANEL:ClearPanels()
    if IsValid(Arivia.PanelMain) then Arivia.PanelMain:SetVisible(false) end
    if IsValid(Arivia.PanelAdmins) then Arivia.PanelAdmins:SetVisible(false) end
    if IsValid(Arivia.PanelBrowser) then Arivia.PanelBrowser:SetVisible(false) end
    if IsValid(Arivia.PanelCommands) then Arivia.PanelCommands:SetVisible(false) end
end

-----------------------------------------------------------------
-- [ INITIALIZE PANEL ]
-----------------------------------------------------------------

function PANEL:Init()

    Arivia.Panel = self
    self.CurJob = LocalPlayer():Team() -- Citizen
    self.w, self.h = ScrW() * .8, ScrH() * .8
    self:SetSize(self.w, self.h)
    self:Center()
    self:MakePopup()
    self.Paint = function(self, w, h) end

    -----------------------------------------------------------------
    -- [ BACKGROUND CONTAINER ]
    ----------------------------------------------------------------- 

    if ( Arivia.Settings.BackgroundsEnabled or Arivia.Settings.LiveBackgroundsEnabled ) and ( Arivia.Settings.BackgroundsList or Arivia.Settings.LiveBackgroundsList ) then
        local sourceTable = Arivia.Settings.BackgroundsList
        if Arivia.Settings.LiveBackgroundsEnabled then
            sourceTable = Arivia.Settings.LiveBackgroundsList
        end
        self.dhtmlBackground = vgui.Create( "DHTML", self )
        self.dhtmlBackground:SetSize( ScrW(), ScrH() )
        self.dhtmlBackground:SetScrollbars( false )
        self.dhtmlBackground:SetVisible( true )
        self.dhtmlBackground:SetHTML(
        [[
            <body style="overflow: hidden; height: 100%; width: 100%; margin:0px;">
                <iframe frameborder="0" width="100%" height="100%" src="]] .. table.Random( sourceTable ) .. [["></iframe> 
            </body>
        ]])
        self.dhtmlBackground.Paint = function( self, w, h ) end
    end

    -----------------------------------------------------------------
    -- [ MAIN BACKGROUND FILTER ]
    -----------------------------------------------------------------

    if Arivia.Settings.BackgroundsEnabled and Arivia.Settings.BackgroundsList then
        self.DHTML_BackgroundFilter = vgui.Create( "DHTML", self.dhtmlBackground )
        self.DHTML_BackgroundFilter:SetSize( ScrW(), ScrH() )
        self.DHTML_BackgroundFilter:SetScrollbars( false )
        self.DHTML_BackgroundFilter:SetVisible( true )
        self.DHTML_BackgroundFilter.Paint = function( self, w, h )
            if Arivia.Settings.BackgroundsBlurEnabled then
                DrawBlurPanel(self, 3)
            end
            --draw.RoundedBox( 0, 0, w, h, Arivia.Settings.BackgroundsFilterColor or Color( 0, 0, 0, 230 ) )
        end
    end

    -----------------------------------------------------------------
    -- [ LEFT CONTAINER ]
    -----------------------------------------------------------------

    self.PanelLeft = vgui.Create("DPanel", self)
    self.PanelLeft:Dock(LEFT)
    self.PanelLeft:DockMargin(0, 0, 0, 0)
    self.PanelLeft:SetWide(200)
    self.PanelLeft.Paint = function(self, w, h) end

    -----------------------------------------------------------------
    -- [ LEFT TOP CONTAINER ]
    -----------------------------------------------------------------

    self.PanelLTop = vgui.Create("DPanel", self.PanelLeft)

    if ( Arivia.Settings.BackgroundsEnabled or Arivia.Settings.LiveBackgroundsEnabled ) and ( Arivia.Settings.BackgroundsList or Arivia.Settings.LiveBackgroundsList ) then
        self.PanelLTop:Dock(FILL)
    else
        self.PanelLTop:Dock(TOP)
    end

    self.PanelLTop:DockMargin(0, 0, 0, 0)
    self.PanelLTop:SetSize(200, 60)
    self.PanelLTop.Paint = function(self, w, h) end

    self.PanelLeftTabs = vgui.Create("DPanel", self.PanelLeft)
    self.PanelLeftTabs:Dock(TOP)
    self.PanelLeftTabs:DockMargin(0, 0, 0, 0)
    self.PanelLeftTabs:SetSize(200, 50)
    self.PanelLeftTabs.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Arivia.Settings.LeftTopPanelBackgroundColor or Color( 128, 0, 0, 250 ))
    end

    -----------------------------------------------------------------
    -- [ LEFT MIDDLE CONTAINER ]
    -----------------------------------------------------------------

    self.PanelLMiddle = vgui.Create("DPanel", self.PanelLeft)
    self.PanelLMiddle:Dock(FILL)
    self.PanelLMiddle:DockMargin(0, 0, 0, 0)
    self.PanelLMiddle:SetWide(200)
    self.PanelLMiddle.Paint = function(self, w, h)
        if Arivia.Settings.BackgroundsBlurEnabled then
            DrawBlurPanel(self, 3)
        end
        draw.RoundedBox(0, 0, 0, w, h, Arivia.Settings.LeftMidPanelBackgroundColor or Color( 0, 0, 0, 250 ))
    end

    -----------------------------------------------------------------
    -- [ HOME TAB CONTAINER ]
    -----------------------------------------------------------------

    self.PanelTabHome = vgui.Create("DPanel", self.PanelLMiddle)
    self.PanelTabHome:SetSize(200, 0)
    self.PanelTabHome:DockMargin(0, 0, 0, 0)
    self.PanelTabHome:Dock(LEFT)
    self.PanelTabHome.Paint = function(self, w, h) end

    -----------------------------------------------------------------
    -- [ INFO TAB CONTAINER ]
    -----------------------------------------------------------------

    self.PanelTabInfo = vgui.Create("DPanel", self.PanelLeft)
    self.PanelTabInfo:Dock(FILL)
    self.PanelTabInfo:DockMargin(0, 0, 0, 0)
    self.PanelTabInfo:SetWide(200)
    self.PanelTabInfo:SetVisible(false)
    self.PanelTabInfo.Paint = function(self, w, h) end

    -----------------------------------------------------------------
    -- [ INFO BUTTONS ]
    -----------------------------------------------------------------

    local i = 0

    for k, v in pairs(Arivia.Settings.InfoButtons) do

        if v.enabled then

            local mat = false

            self.ButtonInfo = vgui.Create("DButton", self.PanelTabInfo)
            self.ButtonInfo:SetText("")
            self.ButtonInfo:SetSize(190, 50)
            self.ButtonInfo:SetPos(5, 5 + i)
            if v.icon and Arivia.UseIconsWithInfo then
                mat = Material(v.icon, "noclamp smooth")
                self.ButtonInfo:SetSize(self.ButtonInfo:GetWide(), self.ButtonInfo:GetTall())
            end
            self.ButtonInfo.Paint = function(self, w, h)
                local color = v.buttonNormal
                local txtColor = v.textNormal

                if self:IsHovered() or self:IsDown() then
                    color = v.buttonHover
                    txtColor = v.textHover
                end

                surface.SetDrawColor(color)
                surface.DrawRect(0, 0, w, h)
                surface.SetDrawColor(Color(255, 255, 255, 255))
                surface.DrawLine(0, 15, 0, 0)
                surface.DrawLine(15, 0, 0, 0)
                surface.SetDrawColor(Color(255, 255, 255, 255))
                surface.DrawLine(w - 20, h - 1, w, h - 1)
                surface.DrawLine(w - 1, h, w - 1, h - 20)

                if Arivia.UseIconsWithInfo and mat then
                    surface.SetDrawColor(txtColor)
                    surface.SetMaterial(mat)
                    surface.DrawTexturedRect(6, 12, 24, 24)
                    draw.SimpleText(string.upper(v.name), "AriviaFontMenuItem", 36, self:GetTall() * .35, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    draw.SimpleText(string.upper(v.description), "AriviaFontMenuSubinfo", 36, self:GetTall() * .65, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                else
                    draw.SimpleText(string.upper(v.name), "AriviaFontMenuItem", 15, self:GetTall() * .35, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    draw.SimpleText(string.upper(v.description), "AriviaFontMenuSubinfo", 15, self:GetTall() * .65, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                end
            end

            self.ButtonInfo.DoClick = v.func
            i = i + 55

        end

    end

    -----------------------------------------------------------------
    -- [ BOTTOM CONTAINER ]
    -----------------------------------------------------------------

    self.PanelBottom = vgui.Create("DPanel", self.PanelLeft)
    self.PanelBottom:Dock(BOTTOM)
    self.PanelBottom:SetSize(200, 60)

    if Arivia.Settings.ClockEnabled then
        self.PanelBottom:SetVisible(true)
    else
        self.PanelBottom:SetVisible(false)
    end

    self.PanelBottom.Paint = function(self, w, h)
        DrawBlurPanel(self, 3)
        draw.RoundedBox(0, 0, 0, w, h, Color(128, 0, 0, 250))
        draw.SimpleText(os.date(Arivia.Settings.ClockFormat), "AriviaFontClock", w / 2, h / 2, Arivia.Settings.ClockColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    -----------------------------------------------------------------
    -- [ RIGHT CONTAINER ]
    -----------------------------------------------------------------

    self.PanelRight = vgui.Create("DPanel", self)
    self.PanelRight:Dock(FILL)
    self.PanelRight.Paint = function(self, w, h)
        if Arivia.Settings.BackgroundsBlurEnabled then
            DrawBlurPanel(self, 3)
        end

        draw.RoundedBox(0, 0, 0, w, h, Arivia.Settings.MiddlePanelBackgroundColor or Color( 16, 16, 16, 210 ))

        if Arivia.Settings.NetworkNameDisplayed then
            draw.SimpleText(Arivia.Settings.NetworkName, "AriviaFontNetworkName", w-10, 50, Arivia.Settings.NetworknameColor or Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        end
    end

    -----------------------------------------------------------------
    -- [ RIGHT TOP CONTAINER ]
    -----------------------------------------------------------------

    self.PanelRTop = vgui.Create("DPanel", self.PanelRight)
    self.PanelRTop:Dock(TOP)
    self.PanelRTop:DockMargin(5, 5, 5, 0)
    self.PanelRTop:SetTall(60)
    self.PanelRTop.Paint = function(self, w, h)
        draw.SimpleText(LocalPlayer():getDarkRPVar("job") or "", "AriviaFontServerInfo", 60, 20, Arivia.PlayerJobColor or Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(DarkRP.formatMoney(LocalPlayer():getDarkRPVar("money")), "AriviaFontPlayerWallet", 60, 40, Arivia.Settings.PlayerMoneyColor or Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    self.AvatarPlayer = vgui.Create("AvatarImage", self.PanelRTop)
    self.AvatarPlayer:SetSize(50, 50)
    self.AvatarPlayer:SetPos(6, 5)
    self.AvatarPlayer:SetPlayer(LocalPlayer(), 50)

    self.ButtonClose = vgui.Create("DButton", self)
    self.ButtonClose:SetColor(Color(255, 255, 255, 255))
    self.ButtonClose:SetFont("AriviaFontCloseGUI")
    self.ButtonClose:SetText("")
    self.ButtonClose.Paint = function()
        surface.SetDrawColor(Arivia.CloseButtonColor or Color(255, 255, 255, 255))
        surface.SetMaterial(Material(ButtonClose))
        surface.DrawTexturedRect(0, 10, 16, 16)
    end
    self.ButtonClose:SetSize(32, 32)
    self.ButtonClose:SetPos(self:GetWide() - 25, 0)
    self.ButtonClose.DoClick = function()
        if IsValid(self) then
            if Arivia.Settings.InitRegenPanel then
                self:Remove()
            else
                self:Hide()
            end
        end
    end

    self.Tab = 1
    self:UpdateTabs()
    self:UpdateAdmins()
    self:UpdateCommands()

    -----------------------------------------------------------------
    -- [ HOME BUTTON ]
    -----------------------------------------------------------------

    self.ButtonHome = vgui.Create("DButton", self.PanelLeftTabs)
    self.ButtonHome:Dock(LEFT)
    self.ButtonHome:DockMargin(2, 0, 0, 0)
    self.ButtonHome:SetSize(60, 40)
    self.ButtonHome:SetText("")
    self.ButtonHome:SetVisible(true)
    self.ButtonHome:SetTooltip(string.upper(Arivia.Language.TabMain))
    self.ButtonHome.Paint = function(self, w, h)
        local color = Color(60, 0, 0, 0)

        if self:IsHovered() or self:IsDown() then
            color = Color(100, 0, 0, 240)
        end

        draw.RoundedBox(0, 0, 0, w, h, color)
        draw.SimpleText(string.upper(Arivia.Language.TabMain), "AriviaFontButtonItem", self:GetWide() / 2, self:GetTall() / 2, txtColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    self.ButtonHome.DoClick = function()
        self.PanelTabInfo:SetVisible(false)
        self.PanelTabHome:SetVisible(true)
    end

    -----------------------------------------------------------------
    -- [ ACTION BUTTON ]
    -----------------------------------------------------------------

    self.ButtonActions = vgui.Create("DButton", self.PanelLeftTabs)
    self.ButtonActions:Dock(LEFT)
    self.ButtonActions:DockMargin(0, 0, 0, 0)
    self.ButtonActions:SetSize(60, 40)
    self.ButtonActions:SetText("")
    self.ButtonActions:SetVisible(true)
    self.ButtonActions:SetTooltip(string.upper(Arivia.Language.TabInfo))
    self.ButtonActions.Paint = function(self, w, h)
        local color = Color(60, 0, 0, 0)

        if self:IsHovered() or self:IsDown() then
            color = Color(100, 0, 0, 240)
        end

        draw.RoundedBox(0, 0, 0, w, h, color)
        draw.SimpleText(string.upper(Arivia.Language.TabInfo), "AriviaFontButtonItem", self:GetWide() / 2, self:GetTall() / 2, txtColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    self.ButtonActions.DoClick = function()
        self.PanelTabHome:SetVisible(false)
        self.PanelTabInfo:SetVisible(true)
    end

    -----------------------------------------------------------------
    -- [ COMMAND BUTTON ]
    -----------------------------------------------------------------

    self.ButtonCommands = vgui.Create("DButton", self.PanelLeftTabs)
    self.ButtonCommands:Dock(LEFT)
    self.ButtonCommands:DockMargin(0, 0, 17, 0)
    self.ButtonCommands:SetSize(78, 40)
    self.ButtonCommands:SetText("")
    self.ButtonCommands:SetVisible(true)
    self.ButtonCommands:SetTooltip(string.upper(Arivia.Language.TabCommands))
    self.ButtonCommands.Paint = function(self, w, h)
        local color = Color(60, 0, 0, 0)

        if self:IsHovered() or self:IsDown() then
            color = Color(100, 0, 0, 240)
        end

        draw.RoundedBox(0, 0, 0, w, h, color)
        draw.SimpleText(string.upper(Arivia.Language.TabCommands), "AriviaFontButtonItem", self:GetWide() / 2, self:GetTall() / 2, txtColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    self.ButtonCommands.DoClick = function()
        PANEL:ClearPanels()
        if IsValid(Arivia.PanelCommands) then Arivia.PanelCommands:SetVisible(true) end
    end

    -----------------------------------------------------------------
    -- [ OPEN EXTERNAL SOURCES ]
    -----------------------------------------------------------------

    function Arivia:OpenExternal( resourceTitle, resourceData, isText )
        Arivia.Panel:ClearPanels()
        Arivia.Panel:External(resourceTitle, resourceData, isText)
    end

    -----------------------------------------------------------------
    -- [ OPEN STAFF LIST ]
    -----------------------------------------------------------------

    function Arivia:OpenAdmins()
        Arivia.Panel:UpdateAdmins()
        Arivia.Panel:ClearPanels()
        if IsValid(Arivia.PanelAdmins) then Arivia.PanelAdmins:SetVisible(true) end
    end

    -----------------------------------------------------------------
    -- [ TICKER ]
    -----------------------------------------------------------------

    function Arivia:TickerLoader()
        local W, H = ScrW(), ScrH()

        if not (W) then timer.Simple(0.5, Load) return end

        local PanelTickerConst = vgui.Create("DPanel", panelBarTicker)

        if Arivia.TickerEnabled then
            PanelTickerConst:SetVisible(true)
        else
            PanelTickerConst:SetVisible(false)
        end

        PanelTickerConst:SetSize(W, H)
        PanelTickerConst:SetPos(1, 1)

        local LabelTickerData = vgui.Create("DLabel", PanelTickerConst)
        LabelTickerData:SetText("")

        if Arivia.TickerEnabled then
            LabelTickerData:SetVisible(true)
        else
            LabelTickerData:SetVisible(false)
        end

        LabelTickerData:SetFont("AriviaFontTicker")
        LabelTickerData:SetTextColor(AriviaTickers.color)
        PanelTickerConst.Alpha = 0
        PanelTickerConst.Paint = function(self)
            if (FrameTime() == 0) then return end
            if (IsValid(LocalPlayer():GetActiveWeapon())) and (LocalPlayer():GetActiveWeapon():GetClass() == "gmod_camera") then return end

            if (AriviaTickers.CurrentAd) then

                if not (LabelTickerData.Setup) then
                    LabelTickerData:SetText(AriviaTickers.CurrentAd)
                    LabelTickerData:SetTextColor(AriviaTickers.color)
                    LabelTickerData:SizeToContents()
                    LabelTickerData:SetPos(PanelTickerConst:GetWide() + 50, 2)
                    LabelTickerData.PosX, LabelTickerData.PosY = LabelTickerData:GetPos()
                    LabelTickerData.Setup = true
                end

                self.Alpha = math.Approach(self.Alpha, 1, FrameTime() * 500)
                draw.RoundedBox(4, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, self.Alpha))
                LabelTickerData.PosX = LabelTickerData.PosX - FrameTime() * Arivia.TickerSpeed
                LabelTickerData:SetPos(LabelTickerData.PosX, LabelTickerData.PosY)

                if (LabelTickerData.PosX + LabelTickerData:GetWide() < -50) then
                    AriviaTickers.CurrentAd = nil
                end

            elseif (self.Alpha > 0) then

                self.Alpha = math.Approach(self.Alpha, 0, FrameTime() * 500)
                if (self.Alpha == 0) then
                    LabelTickerData.Setup = false
                end

            end

        end

        AriviaTickers.VGUI = PanelTickerConst

    end

    timer.Simple(1, Arivia.TickerLoader)

end

function PANEL:UpdateAdmins()

    if IsValid(Arivia.PanelAdmins) then Arivia.PanelAdmins:Remove() end

    Arivia.PanelAdmins = vgui.Create("DPanel", self.PanelRight)
    Arivia.PanelAdmins:Dock(FILL)
    Arivia.PanelAdmins:DockMargin(10, 5, 10, 10)
    Arivia.PanelAdmins:SetVisible(false)
    Arivia.PanelAdmins.Paint = function(self, w, h)
        draw.SimpleText( Arivia.Language.OnlineStaff, "AriviaFontOnlineStaff", 0, 15, Arivia.Settings.NetworknameColor or Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.DrawLine(w - 5, 30, 0, 30)
    end

    self.LayoutStaffList = vgui.Create("DIconLayout", Arivia.PanelAdmins)
    self.LayoutStaffList:Dock(FILL)
    self.LayoutStaffList:DockMargin(0, 40, 0, 0)
    self.LayoutStaffList:SetPos(0, 0)
    self.LayoutStaffList:SetSpaceY(5)
    self.LayoutStaffList:SetSpaceX(5)

    local i = 0

    for k, v in ipairs(player.GetAll()) do

        if not table.HasValue(Arivia.Settings.StaffGroups, v:GetUserGroup()) then continue end

        if not v:SteamID() or v:SteamID() == "NULL" then
            playerSteamID = Arivia.Language.NoSteamID
        else
            playerSteamID = v:SteamID()
        end

        self.PanelStaffItem = self.LayoutStaffList:Add("DPanel")
        self.PanelStaffItem:SetSize(275, 72)
        self.PanelStaffItem.Paint = function(self, w, h)
            if Arivia.Settings.StaffCardBlur then DrawBlurPanel(self) end

            if Arivia.Settings.StaffCardBackgroundUseRankColor then
                draw.RoundedBox(5, 0, 0, w, h, Arivia.Settings.UserGroupColors[v:GetUserGroup()] and Arivia.Settings.UserGroupColors[v:GetUserGroup()] or Arivia.Settings.StaffCardBackgroundColor or Color( 0, 0, 0, 230 ))
            else
                draw.RoundedBox(5, 0, 0, w, h, Arivia.Settings.StaffCardBackgroundColor or Color( 0, 0, 0, 230 ))
            end
        end

        self.AvatarStaff = vgui.Create("AvatarImage", self.PanelStaffItem)
        self.AvatarStaff:SetSize(64, 64)
        self.AvatarStaff:SetPos(4, 4)
        self.AvatarStaff:SetPlayer(v, 64)

        self.LabelStaffNick = vgui.Create("DLabel", self.PanelStaffItem)
        self.LabelStaffNick:SetText(v:Nick())
        self.LabelStaffNick:SetPos(75, 5)
        self.LabelStaffNick:SetFont("AriviaFontCardPlayerName")
        self.LabelStaffNick:SetTextColor(Arivia.Settings.StaffCardNameColor or Color(255, 255, 255, 255))
        self.LabelStaffNick:SizeToContents()

        self.LabelStaffRank = vgui.Create("DLabel", self.PanelStaffItem)
        self.LabelStaffRank:SetText(Arivia.Settings.UserGroupTitles[v:GetUserGroup()] and Arivia.Settings.UserGroupTitles[v:GetUserGroup()] or v:GetUserGroup())
        self.LabelStaffRank:SetPos(75, 30)
        self.LabelStaffRank:SetFont("AriviaFontCardRank")
        self.LabelStaffRank:SetTextColor(Arivia.Settings.StaffCardRankColor or Color(255, 255, 255, 255))
        self.LabelStaffRank:SizeToContents()

        self.ButtonStaffProfile = vgui.Create("DButton", self.PanelStaffItem)
        self.ButtonStaffProfile:SetText("")
        self.ButtonStaffProfile:SetSize(190, 50)
        self.ButtonStaffProfile:SetPos(self.PanelStaffItem:GetWide() - 30, 0)
        self.ButtonStaffProfile:SetTooltip( Arivia.Language.ViewSteamProfile )
        self.ButtonStaffProfile.Paint = function(self, w, h)
            local staffSteamProfile = Material(ButtonSteam, "noclamp smooth")

            if v:IsPlayer() and IsValid(v) and not v:IsBot() then
                surface.SetDrawColor(Color(255, 255, 255, 255))
                surface.SetMaterial(staffSteamProfile)
                surface.DrawTexturedRect(3, 7, 19, 19)
            else
                surface.SetDrawColor(Color(255, 255, 255, 25))
                surface.SetMaterial(staffSteamProfile)
                surface.DrawTexturedRect(3, 7, 19, 19)
            end

            if self:IsHovered() or self:IsDown() then
                color = buttonHover
                txtColor = textHover
            end
        end
        self.ButtonStaffProfile.DoClick = function()
            if IsValid(v) then v:ShowProfile() end
        end

        i = i + 1

    end

end

function PANEL:External(resourceTitle, resourceData, isText)

    if IsValid(Arivia.PanelBrowser) then Arivia.PanelBrowser:Remove() end

    Arivia.PanelBrowser = vgui.Create( "DFrame", self.PanelRight )
    Arivia.PanelBrowser:Dock( FILL )
    Arivia.PanelBrowser:DockMargin(5,5,5,5)
    Arivia.PanelBrowser:ShowCloseButton(false)
    Arivia.PanelBrowser:SetTitle( "" )
    Arivia.PanelBrowser.Paint = function( self, w, h )
        surface.SetDrawColor( 0, 0, 0, 0 )
        draw.RoundedBox( 4, 0, 0, w, h, Arivia.Settings.BrowserColor or Color( 0, 0, 0, 240 ) )
        draw.DrawText( resourceTitle, "AriviaFontBrowserTitle", Arivia.PanelBrowser:GetWide() / 2, 8, Arivia.Settings.BrowserTitleTextColor or Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
    end

    if isText then

        self.DTextAnnEntry = vgui.Create( "DTextEntry", Arivia.PanelBrowser )
        self.DTextAnnEntry:SetMultiline( true )
        self.DTextAnnEntry:Dock(FILL)
        self.DTextAnnEntry:DockMargin(20, 20, 20, 20)
        self.DTextAnnEntry:SetDrawBackground( false )
        self.DTextAnnEntry:SetEnabled( true )
        self.DTextAnnEntry:SetVerticalScrollbarEnabled( true )
        self.DTextAnnEntry:SetFont( "AriviaFontStandardText" )
        self.DTextAnnEntry:SetText( resourceData )
        self.DTextAnnEntry:SetTextColor( Arivia.Settings.RulesTextColor or Color(255, 255, 255, 255) )

    else

        self.DHTMLWindow = vgui.Create( "DHTML", Arivia.PanelBrowser )
        self.DHTMLWindow:SetSize( ScrW() - 200, 300 )
        self.DHTMLWindow:DockMargin( 10, 10, 5, 10 )
        self.DHTMLWindow:Dock( FILL )

        if Arivia.Settings.BrowserControlsEnabled then
            self.DHTMLControlsBar = vgui.Create( "DHTMLControls", Arivia.PanelBrowser )
            self.DHTMLControlsBar:Dock( TOP )
            self.DHTMLControlsBar:SetWide( ScrW() - 200 )
            self.DHTMLControlsBar:SetPos( 0, 0 )
            self.DHTMLControlsBar:SetHTML( self.DHTMLWindow )
            self.DHTMLControlsBar.AddressBar:SetText( resourceData or Arivia.Script.Website )

            self.DHTMLWindow:MoveBelow( self.DHTMLControlsBar )
        end

        self.DHTMLWindow:OpenURL( resourceData or Arivia.Script.Website )

    end

end


function PANEL:UpdateCommands()

    if IsValid(Arivia.PanelCommands) then Arivia.PanelCommands:Remove() end

    Arivia.PanelCommands = vgui.Create("DPanel", self.PanelRight)
    Arivia.PanelCommands:Dock(FILL)
    Arivia.PanelCommands:DockMargin(10, 5, 10, 10)
    Arivia.PanelCommands:SetVisible(false)
    Arivia.PanelCommands.Paint = function(self, w, h)
        draw.SimpleText( "Commands", "AriviaFontOnlineStaff", 0, 15, Arivia.Settings.NetworknameColor or Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.DrawLine(w - 5, 30, 0, 30)
    end

    self.PanelCmds = vgui.Create( "AriviaCommand", Arivia.PanelCommands )
    self.PanelCmds:Dock( FILL )
    self.PanelCmds:SetVisible( true )

end

function PANEL:UpdateServers()

    if table.Count(Arivia.Servers) > 0 and Arivia.ServersEnabled then

        if IsValid(self.PanelAriviaServers) then self.PanelAriviaServers:Remove() end

        self.PanelAriviaServers = vgui.Create("DPanel", self.PanelRight)
        self.PanelAriviaServers:Dock(BOTTOM)
        self.PanelAriviaServers:SetTall(60)
        self.PanelAriviaServers.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 240))
            surface.SetDrawColor(Color(5, 5, 5, 255))
        end

        local buttonCount = 0

        for k, v in pairs(Arivia.Servers) do

            self.ButtonCustom = vgui.Create("DButton", self.PanelAriviaServers)
            self.ButtonCustom:SetText("")
            surface.SetFont("AriviaFontButtonItem")

            local sizex, sizey = surface.GetTextSize(string.upper(v.hostname))
            self.ButtonCustom:SetSize(sizex + 20, 60)
            self.ButtonCustom:Dock(LEFT)
            self.ButtonCustom:DockMargin(5, 0, 0, 0)
            local mat = false

            if v.icon and Arivia.UseServerIconsWithText then
                mat = Material(v.icon, "noclamp smooth")
                self.ButtonCustom:SetSize(self.ButtonCustom:GetWide() + 32, self.ButtonCustom:GetTall())
            elseif v.icon and Arivia.UseServerIconsOnly then
                mat = Material(v.icon, "noclamp smooth")
                self.ButtonCustom:SetSize(64, self.ButtonCustom:GetTall())
            end

            self.ButtonCustom.Paint = function(self, w, h)
                local color = Arivia.ServerButtonColor
                local txtColor = Arivia.ServerButtonTextColor

                if self:IsHovered() or self:IsDown() then
                    color = Arivia.ServerButtonHoverColor
                    txtColor = Arivia.ServerButtonHoverTextColor
                end

                surface.SetDrawColor(color)
                surface.DrawRect(0, 0, w, h)

                if Arivia.UseServerIconsWithText and mat then
                    surface.SetDrawColor(txtColor)
                    surface.SetMaterial(mat)
                    surface.DrawTexturedRect(5, 14, 32, 32)
                    draw.SimpleText(string.upper(v.hostname), "AriviaFontButtonItem", self:GetWide() / 2 + 16, self:GetTall() / 2, txtColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                elseif Arivia.UseServerIconsOnly and mat then
                    surface.SetDrawColor(txtColor)
                    surface.SetMaterial(mat)
                    surface.DrawTexturedRect(17, 14, 32, 32)
                else
                    draw.SimpleText(string.upper(v.hostname), "AriviaFontButtonItem", self:GetWide() / 2, self:GetTall() / 2, txtColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
            end

            self.ButtonCustom.DoClick = function()
                LocalPlayer():ConCommand("connect " .. v.ip)
            end

            buttonCount = buttonCount + 1
        end
    end

    if IsValid(panelBarTicker) then panelBarTicker:Remove() end 
    panelBarTicker = vgui.Create("DLabel", self.PanelRight)
    panelBarTicker:Dock(BOTTOM)
    panelBarTicker:SetTall(30)
    panelBarTicker:SetText("")

    if Arivia.TickerEnabled then
        panelBarTicker:SetVisible(true)
    else
        panelBarTicker:SetVisible(false)
    end

    panelBarTicker.Paint = function(self, w, h)
        draw.AriviaBox(0, 0, w, h, Color(0, 0, 0, 200))
        draw.AriviaBox(0, 0, w, 2, Color(0, 0, 0, 200))
    end
end

function PANEL:UpdateTabs()

    tabs = {}

    if IsValid(self.PanelTabHome) then self.PanelTabHome:Remove() end
    if IsValid(self.PanelTabInfo) then self.PanelTabInfo:SetVisible(false) end

    self.PanelTabHome = vgui.Create("DPanel", self.PanelLMiddle)
    self.PanelTabHome:SetSize(200, 0)
    self.PanelTabHome:DockMargin(0, 0, 0, 0)
    self.PanelTabHome:Dock(LEFT)
    self.PanelTabHome.Paint = function(self, w, h) end

    if IsValid(Arivia.PanelMain) then Arivia.PanelMain:Remove() end
    Arivia.PanelMain = vgui.Create("DPanel", self.PanelRight)
    Arivia.PanelMain:Dock(FILL)
    Arivia.PanelMain:SetSize(self:GetWide() - 215, 0)
    Arivia.PanelMain:DockMargin(5, 5, 5, 5)
    Arivia.PanelMain.Paint = function(self, w, h) end

    -----------------------------------------------------------------
    -- [ JOBS TAB ]
    -----------------------------------------------------------------

    self.Jobs = vgui.Create("AriviaTabJobs", Arivia.PanelMain)
    self:GenerateCategory(Arivia.TabJobs.name, Arivia.TabJobs.description, Arivia.TabJobs.icon, Arivia.TabJobs.buttonColor, Arivia.TabJobs.buttonHoverColor, self.Jobs)

    -----------------------------------------------------------------
    -- [ WEAPONS TAB ]
    -----------------------------------------------------------------
    local count = 0

    for k, v in pairs(CustomShipments) do
        if not AriviaAllowGunPurchase(v) and not Arivia.TabShipments.showUnavailableGuns then continue end
        if not (v.separate or v.noship) then continue end
        count = count + 1
    end

    if count != 0 then
        self.Weapons = vgui.Create("AriviaTabWeapons", Arivia.PanelMain)
        self:GenerateCategory(Arivia.TabWeapons.name, Arivia.TabWeapons.description, Arivia.TabWeapons.icon, Arivia.TabWeapons.buttonColor, Arivia.TabWeapons.buttonHoverColor, self.Weapons)
    end

    -----------------------------------------------------------------
    -- [ AMMO TAB ]
    -----------------------------------------------------------------

    if #GAMEMODE.AmmoTypes != 0 then
        self.Ammo = vgui.Create("AriviaTabAmmo", Arivia.PanelMain)
        self:GenerateCategory(Arivia.TabAmmo.name, Arivia.TabAmmo.description, Arivia.TabAmmo.icon, Arivia.TabAmmo.buttonColor, Arivia.TabAmmo.buttonHoverColor, self.Ammo)
    end

    -----------------------------------------------------------------
    -- [ FOOD TAB ]
    -----------------------------------------------------------------

    local foodCount = 0
    if FoodItems then
        for k, v in pairs(FoodItems) do
            self.Value = v
            if not AriviaAllowFoodPurchase(v) then continue end
            foodCount = foodCount + 1
        end
    end

    if foodCount != 0 then
        self.Food = vgui.Create("AriviaTabFood", Arivia.PanelMain)
        self:GenerateCategory(Arivia.TabFood.name, Arivia.TabFood.description, Arivia.TabFood.icon, Arivia.TabFood.buttonColor, Arivia.TabFood.buttonHoverColor, self.Food)
    end

    -----------------------------------------------------------------
    -- [ SHIPMENTS TAB ]
    -----------------------------------------------------------------

    count = 0

    for k, v in pairs(CustomShipments) do
        self.Value = v
        if not AriviaAllowShipmentPurchase(v) then continue end
        count = count + 1
    end

    if count != 0 then
        self.Ships = vgui.Create("AriviaTabShipments", Arivia.PanelMain)
        self:GenerateCategory(Arivia.TabShipments.name, Arivia.TabShipments.description, Arivia.TabShipments.icon, Arivia.TabShipments.buttonColor, Arivia.TabShipments.buttonHoverColor, self.Ships)
    end

    -----------------------------------------------------------------
    -- [ ENTITIES ]
    -----------------------------------------------------------------

    count = 0

    for k, v in pairs(DarkRPEntities) do
        if not AriviaAllowEntityPurchase(v) then continue end
        count = count + 1
    end

    if count != 0 then
        self.Ents = vgui.Create("AriviaTabEntities", Arivia.PanelMain)
        self:GenerateCategory(Arivia.TabEntities.name, Arivia.TabEntities.description, Arivia.TabEntities.icon, Arivia.TabEntities.buttonColor, Arivia.TabEntities.buttonHoverColor, self.Ents)
    end

    -----------------------------------------------------------------
    -- [ VEHICLE TAB ]
    -----------------------------------------------------------------

    local vehicleCount = 0
    if CustomVehicles then
        for k, v in pairs(CustomVehicles) do
            self.Value = v
            if not AriviaAllowVehiclePurchase(v) then continue end
            vehicleCount = vehicleCount + 1
        end
    end

    if vehicleCount != 0 then
        self.Vehicles = vgui.Create("AriviaTabVehicles", Arivia.PanelMain)
        self:GenerateCategory(Arivia.TabVehicles.name, Arivia.TabVehicles.description, Arivia.TabVehicles.icon, Arivia.TabVehicles.buttonColor, Arivia.TabVehicles.buttonHoverColor, self.Vehicles)
    end

    for k, v in pairs(tabs) do
        if IsValid(v) then v:SetVisible(false) end
    end

    if IsValid(tabs[self.Tab]) then
        tabs[self.Tab]:SetVisible(true)
    end

    self:UpdateServers()

end

function PANEL:GetCurrentTab()
    return self.Tab
end

-----------------------------------------------------------------
-- [ GENERATE NEW CATEGORY ]
-----------------------------------------------------------------

function PANEL:GenerateCategory(name, description, icon, buttoncolor, buttonhovercolor, panel)

    table.insert(tabs, panel)

    self.ButtonCategory = vgui.Create("DButton", self.PanelTabHome)
    self.ButtonCategory:SetSize(190, 50)
    self.ButtonCategory:DockMargin(5, 5, 5, 0)
    self.ButtonCategory:Dock(TOP)
    self.ButtonCategory:SetText("")
    self.ButtonCategory.DoClick = function()
        self.Tab = table.KeyFromValue(tabs, panel)
        self.ClearPanels()
        if IsValid(Arivia.PanelMain) then Arivia.PanelMain:SetVisible(true) end

        for k, v in pairs(tabs) do
            if IsValid(v) then
                v:SetVisible(false)
            end
        end
        if panel:IsValid() then panel:SetVisible(true) end
    end

    self.ButtonCategory.Paint = function(this, w, h)
        local buttonNormal = buttoncolor
        local buttonHover = buttonhovercolor
        local textNormal = Color(255, 255, 255, 255)
        local textHover = Color(255, 255, 255, 255)
        local material = Material(icon, "noclamp smooth")
        local color = buttonNormal
        local txtColor = textNormal

        if this:IsHovered() or this:IsDown() then
            color = buttonHover
            txtColor = textHover
        end

        surface.SetDrawColor(color)
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.DrawLine(0, 15, 0, 0)
        surface.DrawLine(15, 0, 0, 0)
        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.DrawLine(w - 20, h - 1, w, h - 1)
        surface.DrawLine(w - 1, h, w - 1, h - 20)
        surface.SetDrawColor(textNormal)
        surface.SetMaterial(material)
        surface.DrawTexturedRect(6, 12, 24, 24)
        draw.SimpleText(string.upper(name), "AriviaFontMenuItem", 36, this:GetTall() * .35, textNormal, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(string.upper(description), "AriviaFontMenuSubinfo", 36, this:GetTall() * .65, textNormal, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

    end

end

-----------------------------------------------------------------
--[ CHECK F4 KEYPRESS ]
-----------------------------------------------------------------

function PANEL:OnKeyCodePressed(keyCode)
    if keyCode == KEY_F4 then
        DarkRP.toggleF4Menu()
    end
end
vgui.Register("AriviaPanel", PANEL, "DPanel")

-----------------------------------------------------------------
--[ UPDATE ON JOB CHANGE ]
-----------------------------------------------------------------

hook.Add("OnPlayerChangedTeam", "AriviaTeamChanged", function(ply, old, new)

    if Arivia.Settings.InitRegenPanel then return end

    if IsValid( Arivia.Panel ) then
        Arivia.Panel.CurJob = new
        Arivia.Panel:UpdateTabs()
    end

end )

-----------------------------------------------------------------
--[ INITPOST ]
-----------------------------------------------------------------

hook.Add("InitPostEntity", "AriviaPanel", function()

    Arivia.Panel = nil

    -----------------------------------------------------------------
    --[ OPEN MENU ]
    -----------------------------------------------------------------
    function DarkRP.openF4Menu()
        if Arivia.Panel and IsValid(Arivia.Panel) then
            if Arivia.Settings.InitRegenPanel then
                Arivia.Panel = vgui.Create("AriviaPanel")
            else
                Arivia.Panel:Show()
            end

            Arivia.Panel:InvalidateLayout()
        else
            Arivia.Panel = vgui.Create("AriviaPanel")
        end
    end

    -----------------------------------------------------------------
    --[ CLOSE MENU ]
    -----------------------------------------------------------------
    function DarkRP.closeF4Menu()
        if Arivia.Panel then
            if Arivia.Settings.InitRegenPanel then
                Arivia.Panel:Remove()
            else
                Arivia.Panel:Hide()
            end
        end
    end

    -----------------------------------------------------------------
    -- [ TOGGLE MENU ]
    -----------------------------------------------------------------
    function DarkRP.toggleF4Menu()
        if not IsValid(Arivia.Panel) or not Arivia.Panel:IsVisible() then
            DarkRP.openF4Menu()
        else
            DarkRP.closeF4Menu()
        end
    end

    GAMEMODE.ShowSpare2 = DarkRP.toggleF4Menu

end)