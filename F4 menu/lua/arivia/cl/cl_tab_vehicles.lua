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

local PANEL = {}

function PANEL:Init()

    local Property = self

    Property:Dock( FILL )
    Property.Paint = function() end
    
    Property.Scroll = vgui.Create( "DScrollPanel", Property )
    Property.Scroll:GetVBar():Remove()

    Property.Scroll.VBar = vgui.Create("AriviaDVScrollBar", Property)
    Property.Scroll.VBar.Content = Property.Scroll
    Property.Scroll.VBar:Dock(LEFT)
    Property.Scroll.VBar:DockMargin(0, 7, 0, 5)

    Property.Value = nil

    Property.Scroll.PerformLayout = function( self )

        local Wide = self:GetWide()
        local YPos = 0

        self:Rebuild()

        self.VBar:SetUp( self:GetTall(), self.pnlCanvas:GetTall() )
        YPos = self.VBar:GetOffset()
            
        self.pnlCanvas:SetPos( 0, YPos )
        self.pnlCanvas:SetWide( Wide )

        self:Rebuild()
    end

    Property.Scroll:Dock( LEFT )
    Property.Scroll:DockMargin( 5, 5, 4, 0 )
    Property.Scroll:SetWide( ( Property:GetParent():GetWide() - Property:GetParent():GetWide() / 3 ) + 9 )
    Property.Scroll:GetVBar():ConstructScrollbarGUI()

    Property.Categories = {}

    local function GenerateCategory(name)

        for k, v in pairs( Property.Categories ) do
            if v.Title == name then return v end
        end

        local AriviaCategory = vgui.Create("AriviaCategory", Property.Scroll)
        AriviaCategory:Dock( TOP )
        AriviaCategory:DockMargin( 0, 5, 0, 0 )
        AriviaCategory:HeaderTitle( name )

        table.insert( Property.Categories, AriviaCategory )

        AriviaCategory.List = vgui.Create( "DIconLayout", AriviaCategory )
        AriviaCategory.List:SetLayoutDir( TOP )
        AriviaCategory.List:Dock( LEFT )
        AriviaCategory.List:DockMargin( 6, 5, 0, 0 )
        AriviaCategory.List:SetSize( Property:GetParent():GetWide() - Property:GetParent():GetWide() / 3 + 9, 65 )
        AriviaCategory.List.Paint = function( panel, w, h ) end
        AriviaCategory.List:SetSpaceY( 5 )
        AriviaCategory.List:SetSpaceX( 5 )

        return AriviaCategory

    end

    for i = 0, 0 do
        for k, v in ipairs( CustomVehicles ) do

            if !AriviaAllowVehiclePurchase(v) then continue end

            if !Property.Value then
                Property.Value = v
            end

            if v.category then
                AriviaCategory = GenerateCategory( v.category )
            else
                AriviaCategory = GenerateCategory( Arivia.Language.CategoryOther )
            end

            local ListItem = vgui.Create("DButton")
            ListItem:SetSize((Property:GetParent():GetWide() / 3) - 4, 60)
            ListItem:SetText("")
            ListItem.oldpaint = ListItem.Paint
            ListItem.DoClick = function()
                Property.Value = v
                Property.Value.Key = 1
                if istable(Property.Value.model) then
                    Property.Item.ModelObject:SetModel(Property.Value.model[Property.Value.Key])
                else
                    Property.Item.ModelObject:SetModel(Property.Value.model)
                end
                Property.Item.ModelObject:InvalidateLayout()
                Property.Item.ButtonAction:InvalidateLayout()
            end

            function ListItem:Paint( w, h )

                local itemUnavailable = false

                local color = Arivia.TabEntities.buttonColor
                local txtColor = textNormal
                if ListItem:IsHovered() or ListItem:IsDown() then 
                    color = Arivia.TabEntities.buttonHoverColor
                    txtColor = textHover
                end

                local objectName = v.name

                if Arivia.TruncateEnabled then
                    local maxW = Arivia.TruncateLength or 170
                    surface.SetFont("AriviaFontObjectListName")
                    local fw,fh = surface.GetTextSize(objectName)
                    if fw > maxW then
                        objectName = string.sub(objectName, 1, objectName:len()-3).."..."
                    end
                end

               -----------------------------------------------------------------
                -- SUPPORT FOR LEVELING SYSTEM
                -----------------------------------------------------------------

                if Arivia.TabVehicles.xpsystemEnabled and LevelSystemConfiguration then
                    local itemLevel = v.level or v.lvl
                    if itemLevel == nil or !itemLevel then 
                        levelText = Arivia.Language.NoLevel
                    elseif itemLevel != nil then 
                        levelText = Arivia.Language.Level .. " " .. itemLevel
                    end
                end

                -----------------------------------------------------------------
                -- SUPPORT FOR PRESTIGE SCRIPT
                -- https://scriptfodder.com/scripts/view/390
                -----------------------------------------------------------------

                if LevelSystemPrestigeConfiguration and Arivia.TabVehicles.prestigeEnabled then
                    local itemPrestige = v.prestige
                    if itemPrestige == nil or !itemPrestige then 
                        prestigeText = Arivia.Language.NoPrestige
                    elseif itemPrestige != nil then 
                        prestigeText = Arivia.Language.Prestige .. " " .. itemPrestige
                    end
                end

                local itemCount = v.max
                if itemCount == 0 then itemCount = Arivia.Language.JobMaxUnlimited end

                local originNameX = Arivia.Settings.ItemnameH or 23
                if (Arivia.TabVehicles.xpsystemEnabled and ( LevelSystemConfiguration ) ) or (Arivia.TabVehicles.prestigeEnabled and ( LevelSystemPrestigeConfiguration or v.prestige ) )  then
                    originNameX = 11
                end

                draw.RoundedBox( 0, 0, 0, w, h, color )
                surface.SetDrawColor( 255, 255, 255, 20 )

                draw.NoTexture()
                draw.Circle( w - 30, 30, 22, 22 )

                draw.DrawText( objectName, "AriviaFontObjectListName", 65, originNameX, Arivia.TabVehicles.nameColor or Color( 255, 240, 244 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

                if Arivia.TabVehicles.xpsystemEnabled then
                    if LevelSystemConfiguration then
                        draw.DrawText( levelText, "AriviaFontObjectLevel", 65, 35, Color( 255, 240, 244, 100 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                        if Arivia.TabVehicles.prestigeEnabled and LevelSystemPrestigeConfiguration then
                            draw.DrawText( prestigeText, "AriviaFontObjectLevel", 140, 35, Color( 255, 240, 244, 100 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                        end
                    end
                elseif Arivia.TabVehicles.prestigeEnabled then
                    if LevelSystemPrestigeConfiguration then
                        draw.DrawText( prestigeText, "AriviaFontObjectLevel", 65, 35, Color( 255, 240, 244, 100 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                    end
                end

                draw.DrawText( GAMEMODE.Config.currency .. v.price, "AriviaFontObjectPrice", w - 31, 19, Color(255, 255, 255, 120), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

                -----------------------------------------------------------------
                -- itemUnavailable - CHECK PLAYER LEVEL
                -----------------------------------------------------------------
                if Arivia.TabVehicles.xpsystemEnabled then
                    local itemLevel = v.level or v.lvl
                    local PlayerLevel = LocalPlayer():getDarkRPVar('level') or 0
                    if itemLevel != nil and itemLevel then 
                        if itemLevel >  PlayerLevel then
                            itemUnavailable = true
                        end
                    end
                end

                -----------------------------------------------------------------
                -- itemUnavailable - CHECK PLAYER PRESTIGE
                -----------------------------------------------------------------
                if LevelSystemConfiguration and v.prestige then
                    local itemPrestige = v.prestige
                    local PlayerPrestigeAmount = LocalPlayer():getDarkRPVar('prestige') or 0
                    if itemPrestige != nil then
                        if itemPrestige >  PlayerPrestigeAmount then
                            itemUnavailable = true
                        end
                    end
                end

                -----------------------------------------------------------------
                -- itemUnavailable - CHECK PLAYER CAN AFFORD
                -----------------------------------------------------------------
                if ( v.price > LocalPlayer():getDarkRPVar("money") ) then
                    itemUnavailable = true
                end

                -----------------------------------------------------------------
                -- itemUnavailable - DARKEN BOX IF TRUE
                -----------------------------------------------------------------
                if Arivia.TabWeapons.unavailableDarken and itemUnavailable then
                    draw.RoundedBox( 0, 0, 0, w, h, Arivia.TabWeapons.unavailableColor )
                end

            end

            local PlayerModel = vgui.Create("DModelPanel", ListItem)
            PlayerModel.LayoutEntity = function() return end

            local tmodel
            if istable(v.model) then
                tmodel = v.model[1]
            else
                tmodel = v.model
            end

            if isstring(tmodel) then
                PlayerModel:SetModel(tmodel)
            else
                PlayerModel:SetModel("models/error.mdl")
            end
            
            if !IsValid(PlayerModel.Entity) then continue end

            PlayerModel:SetPos( 0, 0 )
            PlayerModel:SetSize(60, 60)
            PlayerModel:SetFOV( 66 )
            PlayerModel:SetCamPos( Vector( 100, 90, 65 ) )
            PlayerModel:SetLookAt( Vector (9, 9, 15 ) )

            AriviaCategory.List:Add(ListItem)
            AriviaCategory:AddNewChild(ListItem)

            PlayerModel.Paint = function (self, w, h)

                if ( !IsValid( self.Entity ) ) then return end

                local x, y = self:LocalToScreen( 0, 0 )

                self:LayoutEntity( self.Entity )

                local ang = self.aLookAngle
                if ( !ang ) then
                    ang = (self.vLookatPos-self.vCamPos):Angle()
                end

                cam.Start3D( self.vCamPos, ang, self.fFOV, x, y, w, h, 5, self.FarZ )

                render.SuppressEngineLighting( true )
                render.SetLightingOrigin( self.Entity:GetPos() )
                render.ResetModelLighting( self.colAmbientLight.r/255, self.colAmbientLight.g/255, self.colAmbientLight.b/255 )
                render.SetColorModulation( self.colColor.r/255, self.colColor.g/255, self.colColor.b/255 )
                render.SetBlend( self.colColor.a/255 )

                for i = 0, 6 do
                    local col = self.DirectionalLight[ i ]
                    if ( col ) then
                        render.SetModelLighting( i, col.r / 255, col.g / 255, col.b / 255 )
                    end
                end

                self:DrawModel()

                render.SuppressEngineLighting( false )
                cam.End3D()

                self.LastPaint = RealTime()

            end

        end
    end

    for k, v in pairs(Property.Categories) do
        v:SetupChildren()
    end

    Property.Item = vgui.Create("DPanel", self)
    Property.Item:SetSize(Property:GetParent():GetWide() * 0.33 - 25, Property.Scroll:GetTall())
    Property.Item:Dock(RIGHT)
    Property.Item:DockMargin(2, 7, 0, 0)
    Property.Item.Paint = function(self, w, h)
        draw.RoundedBox(0, 2.5, 2.5, w - 6.5, h, Color(5, 5, 5, 200))
    end

    Property.Item.Title = vgui.Create("DLabel", Property.Item)
    Property.Item.Title:Dock(TOP)
    Property.Item.Title:SetText("")
    Property.Item.Title:DockMargin(0, 0, 0, 0)
    Property.Item.Title:SetContentAlignment(7)
    Property.Item.Title:SetSize(Property.Item:GetWide() - 20, 40)
    Property.Item.Title.Paint = function(slf, w, h)
        draw.SimpleText(Property.Value.name, "AriviaFontCategoryName", w / 2, 20, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    Property.Item.ModelObject = vgui.Create("DModelPanel", Property.Item)
    Property.Item.ModelObject:SetSize( Property.Item:GetWide() / 2, self:GetTall() + 160 )
    Property.Item.ModelObject:Dock(TOP)
    Property.Item.ModelObject:SetCamPos(Vector(170, -50, 70))
    Property.Item.ModelObject:SetLookAt(Vector(0, 0, 10))
    Property.Item.ModelObject:SetFOV(80)
    Property.Item.ModelObject:SetAmbientLight( Color( 255, 255, 255, 255 ) )
    Property.Item.ModelObject:SetModel(Property.Value.model)

    Property.Item.Scroll = vgui.Create( "DScrollPanel", Property.Item )
    Property.Item.Scroll:SetSize( Property.Item:GetWide() - 10, 230)
    Property.Item.Scroll.VBar:ConstructScrollbarGUI()
    Property.Item.Scroll:Dock(FILL)
    Property.Item.Scroll:DockPadding(5, 5, 5, 5)
    Property.Item.Scroll:DockMargin(5, 0, 0, 0)
    Property.Item.Scroll.Paint = function(self, w, h) end

    if Arivia.CustomEntityDescriptionsEnabled then

        Property.Item.Description = vgui.Create( "DLabel", Property.Item.Scroll )
        Property.Item.Description:Dock(FILL)
        Property.Item.Description:DockMargin(20, 20, 20, 10)
        Property.Item.Description:SetFont("AriviaFontItemInformation")
        Property.Item.Description:SetAutoStretchVertical(true)
        Property.Item.Description:SetWrap(true)
        Property.Item.Description:SetSize(40, 200)
        Property.Item.Description.PerformLayout = function()

            local entityName = Property.Value.name
            local text = "Entity '" .. entityName .. "' does not yet have a description!\n\nPlease set one inside the DarkRP /config/addentities.lua file for description, or alternatively use Arivia.CustomEntityDescriptions in /arivia/sh/sh_config.php for ease of use!\n\n\n"
            Property.Item.Description:SetText( Arivia.CustomEntityDescriptions[entityName] and Arivia.CustomEntityDescriptions[entityName] .. "\n\n\n" or text )

        end

    end

    Property.Item.ButtonAction = vgui.Create("DButton", Property.Item)
    Property.Item.ButtonAction:Dock(BOTTOM)
    Property.Item.ButtonAction:DockMargin(10, 5, 10, 5)
    Property.Item.ButtonAction:SetText("")
    Property.Item.ButtonAction.Text = ""
    Property.Item.ButtonAction:SetSize(Property.Item:GetWide(), 40)
    Property.Item.ButtonAction:SetVisible(true)
    Property.Item.ButtonAction.PerformLayout = function()
        if AriviaAllowEntityPurchase(Property.Value) then
            Property.Item.ButtonAction.Text = string.upper( Arivia.Language.MakePurchase .. ": " .. GAMEMODE.Config.currency .. Property.Value.price )
            Property.Item.ButtonAction.DoClick = function() 
                RunConsoleCommand("darkrp", "buyvehicle", Property.Value.name)
            end
        else
            Property.Item.ButtonAction.Text = string.upper( Arivia.Language.CannotPurchase )
            Property.Item.ButtonAction.DoClick = function() end
        end
    end
    
    Property.Item.ButtonAction.Paint = function(self, w, h)

        local buttonColor
        local EntityStatus = Property.Item.ButtonAction.Text or ""

        if AriviaAllowEntityPurchase(Property.Value) then
            buttonColor = Color( 72, 112, 58, 255 )
        else
            buttonColor = Color( 124, 51, 50, 190 )
        end

        -----------------------------------------------------------------
        -- CHECK PLAYER LEVEL
        -----------------------------------------------------------------
        if Arivia.TabVehicles.xpsystemEnabled then
            local itemLevel = Property.Value.level
            local PlayerLevel = LocalPlayer():getDarkRPVar('level') or 0
            if itemLevel != nil and itemLevel then 
                if itemLevel >  PlayerLevel then
                    buttonColor = Arivia.TabEntities.unavailableColor
                    EntityStatus = string.upper(Arivia.Language.InsufficientLevel)
                end
            end
        end

        -----------------------------------------------------------------
        -- CHECK PLAYER PRESTIGE
        -----------------------------------------------------------------
        if LevelSystemConfiguration and Property.Value.prestige then
            local PlayerPrestigeAmount = LocalPlayer():getDarkRPVar('prestige') or 0
            if Property.Value.prestige != nil then
                if Property.Value.prestige >  PlayerPrestigeAmount then
                    buttonColor = Arivia.TabEntities.unavailableColor
                    EntityStatus = string.upper(Arivia.Language.NotEnoughPrestige)
                end
            end
        end

        draw.RoundedBox( 0, 0, 0, w, h, buttonColor )
        draw.SimpleText( EntityStatus, "AriviaFontCloseGUI", w / 2, h / 2, Color(230, 230, 230, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

    end

end

vgui.Register("AriviaTabVehicles", PANEL, "DPanel")