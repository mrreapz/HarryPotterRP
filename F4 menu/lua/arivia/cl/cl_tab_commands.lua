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

    self.PanelAV = vgui.Create("DPanel", self)
    self.PanelAV:Dock(FILL)
    self.PanelAV:SetVisible(true)
    self.PanelAV.Paint = function(self, w, h) end

    local listControls = vgui.Create("DIconLayout", self.PanelAV)
    listControls:Dock(FILL)
    listControls:DockMargin(0, 50, 0, 0)
    listControls:SetPos(0, 0)
    listControls:SetSpaceY(5)
    listControls:SetSpaceX(5)

    for k, v in pairs( Arivia.Commands ) do

        if ( v.mayorOnly and not LocalPlayer():isMayor() ) then continue end
        if ( v.civilProtectionOnly and not LocalPlayer():isCP() ) then continue end

        if v.name == "Separator" then
            local PanelSeparator = listControls:Add( "DPanel" )
            PanelSeparator:SetSize(2, 2)
            PanelSeparator:Dock(TOP)
            PanelSeparator.Paint = function( self, w, h ) end 
            continue
        end

        local ButtonCommand = listControls:Add( "DButton" )
        ButtonCommand:SetSize( listControls:GetWide() / 2 - 47, 30 )
        ButtonCommand:SetText( "" )
        ButtonCommand:SetSize(120, 50)
        ButtonCommand.Paint = function(self, w, h)
            local color = v.buttonNormal or Color(72, 112, 58, 190)
            local txtColor = v.textNormal or Color(72, 112, 58, 190)
            local colorOutline = v.buttonOutline or Color(255, 255, 255, 50)

            if self:IsHovered() or self:IsDown() then
                color = v.buttonHover or Color(255, 255, 255, 255)
                txtColor = v.textHover or Color(255, 255, 255, 255)
            end

            draw.AriviaOutlinedBox(0, 0, w, h, color, colorOutline)

            draw.SimpleText(string.upper(v.name or ""), "AriviaFontButtonItem", self:GetWide() / 2, self:GetTall() / 2, txtColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        end
        ButtonCommand.DoClick = function()

            if v.argCount == 0 then
                RunConsoleCommand( "say", v.command )
                Arivia.Panel:Hide()
            else

                local FrameConfirmation = vgui.Create( "DFrame" )
                FrameConfirmation:SetSize( 300, 125 )
                FrameConfirmation:SetTitle( v.name )
                FrameConfirmation:SetVisible( true )
                FrameConfirmation:ShowCloseButton( true )
                FrameConfirmation:Center()
                FrameConfirmation:MakePopup()
                FrameConfirmation.Think = function()
                    if not ButtonCommand:IsVisible() then
                        FrameConfirmation:Close()
                    end
                end
                FrameConfirmation.Paint = function( self, w, h )
                    DrawBlurPanel(self)
                    draw.RoundedBox( 4, 0, 0, w, h, Color( 10, 10, 10, 230 ) )
                end

                local LabelArgument1 = vgui.Create( "DLabel", FrameConfirmation )
                LabelArgument1:SetSize( FrameConfirmation:GetWide() - 20, 25 )
                LabelArgument1:Dock(TOP)
                LabelArgument1:SetText( v.arg1 )

                local TextArgument1 = vgui.Create( "DTextEntry", FrameConfirmation )
                TextArgument1:SetSize( FrameConfirmation:GetWide() - 20, 25 )
                TextArgument1:Dock(TOP)
                TextArgument1:SetText( "" )

                local ArgY = 10 + TextArgument1:GetTall() + 10

                local LabelArgument2 = vgui.Create( "DLabel", FrameConfirmation )
                LabelArgument2:SetSize( FrameConfirmation:GetWide() - 20, 25 )
                LabelArgument2:Dock(TOP)
                LabelArgument2:SetVisible(false)
                LabelArgument2:SetText( v.arg2 )
                
                local TextArgument2 = vgui.Create( "DTextEntry", FrameConfirmation )
                TextArgument2:SetSize( FrameConfirmation:GetWide() - 20, 25 )
                TextArgument2:Dock(TOP)
                TextArgument2:SetVisible(false)
                TextArgument2:SetText( "" )

                if v.argCount == 2 then
                    FrameConfirmation:SetSize( 300, 180 )
                    LabelArgument2:SetVisible(true)
                    TextArgument2:SetVisible(true)
                end

                local ButtonOK = vgui.Create( "DButton", FrameConfirmation )
                ButtonOK:SetSize( FrameConfirmation:GetWide() - 20, 25 )
                ButtonOK:Dock(BOTTOM)
                ButtonOK:SetText( "OK" )
                ButtonOK:SetFont("AriviaFontButtonItem")
                ButtonOK:SetTextColor( Color( 255, 255, 255 ) )
                ButtonOK.Paint = function( self, w, h )
                    local color = Color(64, 105, 126, 190)
                    if self:IsHovered() or self:IsDown() then
                        color = Color(64, 105, 126, 220)
                    end
                    draw.RoundedBox( 4, 0, 0, w, h, color )
                end
                ButtonOK.DoClick = function()
                    if v.argCount == 1 then
                        RunConsoleCommand( "say", v.command .. " " .. TextArgument1:GetValue() )
                    else
                        RunConsoleCommand( "say", v.command .. " " .. TextArgument1:GetValue() .. " " .. TextArgument2:GetValue() )
                    end
                    
                    Arivia.Panel:Hide()
                    FrameConfirmation:Close()
                end

            end
        end

    end

end

vgui.Register( 'AriviaCommand', PANEL, 'EditablePanel' )