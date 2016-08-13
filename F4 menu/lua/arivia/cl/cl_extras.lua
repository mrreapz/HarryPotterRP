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
Arivia = Arivia or {}

function PANEL:Init()

    local AriviaScrollbar = self

    AriviaScrollbar.Offset = 0
    AriviaScrollbar.Scroll = 0
    AriviaScrollbar.CanvasSize = 1
    AriviaScrollbar.BarSize = 1    
    
    AriviaScrollbar.btnUp = vgui.Create( "DButton", AriviaScrollbar )
    AriviaScrollbar.btnUp:SetText( "" )
    AriviaScrollbar.btnUp.DoClick = function ( AriviaScrollbar ) AriviaScrollbar:GetParent():AddScroll( -1 ) end
    AriviaScrollbar.btnUp.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "ButtonUp", panel, w, h ) end
    
    AriviaScrollbar.btnDown = vgui.Create( "DButton", AriviaScrollbar )
    AriviaScrollbar.btnDown:SetText( "" )
    AriviaScrollbar.btnDown.DoClick = function ( AriviaScrollbar ) AriviaScrollbar:GetParent():AddScroll( 1 ) end
    AriviaScrollbar.btnDown.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "ButtonDown", panel, w, h ) end
    
    AriviaScrollbar.btnGrip = vgui.Create( "DScrollBarGrip", AriviaScrollbar )
    
    AriviaScrollbar:SetSize( 15, 15 )

end

function PANEL:SetEnabled( b )
    
    if ( !b ) then
    
        self.Offset = 0
        self:SetScroll( 0 )
        self.HasChanged = true
        
    end
    
    self:SetMouseInputEnabled( b )
    self:SetVisible( b )
    
    if ( self.Enabled != b ) then

        self.Content:InvalidateLayout()

        if ( self.Content.OnScrollbarAppear ) then
            self.Content:OnScrollbarAppear()
        end

    end
    
    self.Enabled = b    
    
end


function PANEL:Value()

    return self.Pos
    
end

function PANEL:BarScale()

    if ( self.BarSize == 0 ) then return 1 end
    
    return self.BarSize / (self.CanvasSize+self.BarSize)
    
end

function PANEL:SetUp( _barsize_, _canvassize_ )

    self.BarSize    = _barsize_
    self.CanvasSize = math.max( _canvassize_ - _barsize_, 1 )

    self:SetEnabled( _canvassize_ > _barsize_ )

    self:InvalidateLayout()
        
end

function PANEL:OnMouseWheeled( dlta )

    if ( !self:IsVisible() ) then return false end
    
    return self:AddScroll( dlta * -2 )
    
end

function PANEL:AddScroll( dlta )

    local OldScroll = self:GetScroll()

    dlta = dlta * 25
    self:SetScroll( self:GetScroll() + dlta )
    
    return OldScroll != self:GetScroll()
    
end

function PANEL:SetScroll( scrll )

    if ( !self.Enabled ) then self.Scroll = 0 return end

    self.Scroll = math.Clamp( scrll, 0, self.CanvasSize )
    
    self:InvalidateLayout()
    
    local func = self.Content.OnVScroll
    if ( func ) then
    
        func( self.Content, self:GetOffset() )
    
    else
    
        self.Content:InvalidateLayout()
    
    end
    
end

function PANEL:AnimateTo( scrll, length, delay, ease )

    local anim = self:NewAnimation( length, delay, ease )
    anim.StartPos = self.Scroll
    anim.TargetPos = scrll
    anim.Think = function( anim, pnl, fraction )
    
        pnl:SetScroll( Lerp( fraction, anim.StartPos, anim.TargetPos ) )
    
    end
    
end

function PANEL:GetScroll()

    if ( !self.Enabled ) then self.Scroll = 0 end
    return self.Scroll
    
end

function PANEL:GetOffset()

    if ( !self.Enabled ) then return 0 end
    return self.Scroll * -1
    
end

function PANEL:Think()

end


function PANEL:Paint( w, h )
    
    derma.SkinHook( "Paint", "VScrollBar", self, w, h )
    return true
    
end

function PANEL:OnMousePressed()

    local x, y = self:CursorPos()

    local PageSize = self.BarSize
    
    if ( y > self.btnGrip.y ) then
        self:SetScroll( self:GetScroll() + PageSize )
    else
        self:SetScroll( self:GetScroll() - PageSize )
    end 
    
end

function PANEL:OnMouseReleased()

    self.Dragging = false
    self.DraggingCanvas = nil
    self:MouseCapture( false )
    
    self.btnGrip.Depressed = false
    
end

function PANEL:OnCursorMoved( x, y )

    if ( !self.Enabled ) then return end
    if ( !self.Dragging ) then return end

    local x = 0
    local y = gui.MouseY()
    local x, y = self:ScreenToLocal( x, y )
    
    y = y - self.btnUp:GetTall()
    y = y - self.HoldPos
    
    local TrackSize = self:GetTall() - self:GetWide() * 2 - self.btnGrip:GetTall()
    
    y = y / TrackSize
    
    self:SetScroll( y * self.CanvasSize )   
    
end

function PANEL:Grip()

    if ( !self.Enabled ) then return end
    if ( self.BarSize == 0 ) then return end

    self:MouseCapture( true )
    self.Dragging = true
    
    local x, y = 0, gui.MouseY()
    local x, y = self.btnGrip:ScreenToLocal( x, y )
    self.HoldPos = y 
    
    self.btnGrip.Depressed = true
    
end

function PANEL:PerformLayout()

    local Wide = self:GetWide()
    local Scroll = self:GetScroll() / self.CanvasSize
    local BarSize = math.max( self:BarScale() * (self:GetTall() - (Wide * 2)), 10 )
    local Track = self:GetTall() - ( Wide * 2 ) - BarSize
    Track = Track + 1
    
    Scroll = Scroll * Track
    
    self.btnGrip:SetPos( 0, Wide + Scroll )
    self.btnGrip:SetSize( Wide, BarSize )
    
    self.btnUp:SetPos( 0, 0, Wide, Wide )
    self.btnUp:SetSize( Wide, Wide )
    
    self.btnDown:SetPos( 0, self:GetTall() - Wide, Wide, Wide )
    self.btnDown:SetSize( Wide, Wide )

end

derma.DefineControl( "AriviaDVScrollBar", "A Scrollbar", PANEL, "Panel" )

local PANEL = {}
function PANEL:Init()

    local PanelCategory = self

    PanelCategory.Children = {}
    PanelCategory.IsToggled = true

    PanelCategory:SetTall( 20 )
    PanelCategory.Button = vgui.Create( "DButton", PanelCategory )
    PanelCategory.Button:Dock( TOP )
    PanelCategory.Button:DockMargin( 5, 5, 5, 0 )
    PanelCategory.Button:SetHeight( 25 )
    PanelCategory.Button:SetText( "" )

    PanelCategory.Button.DoClick = function() PanelCategory:DoToggle() end

    PanelCategory.Button.Paint = function(self, w, h)
        draw.RoundedBox( 0, 0, 0, w, h, Color( 5, 5, 5, 200 ) )
        draw.SimpleText( PanelCategory.Title, "AriviaFontMenuItem", 5, 12, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    end

end

-----------------------------------------------------------------
-- [ PAINT ]
-- Better than microsoft paint
-----------------------------------------------------------------

function PANEL:Paint(w, h)
    draw.RoundedBox(0, 1, 0, w - 2, h, Color(5, 5, 5, 200))
end

-----------------------------------------------------------------
-- [ ADD NEW CHILD ]
-- Add new entries
-----------------------------------------------------------------

function PANEL:AddNewChild(element)
    local PanelCategory = self

    if not IsValid(element) then return end
    table.insert(PanelCategory.Children, element)

    PanelCategory.List:PerformLayout()
end

-----------------------------------------------------------------
-- [ SETUP CHILDREN ]
-- Do a little math calc to determine the height of the cat panel
-----------------------------------------------------------------

function PANEL:SetupChildren()
    local PanelCategory = self
    PanelCategory:SetTall( 25 + PanelCategory.List:GetTall() + 15 )
end

-----------------------------------------------------------------
-- [ TOGGLE OPENED ]
-- Action when category list is toggled open
-----------------------------------------------------------------

function PANEL:ToggleOpened()
    local PanelCategory = self
    PanelCategory.IsToggled = true
    PanelCategory:SizeTo( PanelCategory:GetWide(), 25 + PanelCategory.List:GetTall() + 15, 0.5, 0.1 )
end

-----------------------------------------------------------------
-- [ TOGGLE CLOSED ]
-- Action when category list is toggled closed
-----------------------------------------------------------------

function PANEL:ToggleClosed()
    local PanelCategory = self
    PanelCategory.IsToggled = false
    PanelCategory:SizeTo( PanelCategory:GetWide(), 35, 0.5, 0.1 )
end

-----------------------------------------------------------------
-- [ DO TOGGLE ]
-- Determine state of category list and perform next state
-----------------------------------------------------------------

function PANEL:DoToggle()
    local PanelCategory = self
    if PanelCategory.IsToggled then
        PanelCategory:ToggleClosed()
    else
        PanelCategory:ToggleOpened()
    end
end

-----------------------------------------------------------------
-- [ HEADER TITLE ]
-- Set the category title in header
-----------------------------------------------------------------

function PANEL:HeaderTitle(catTitle)
    local PanelCategory = self
    PanelCategory.Title = catTitle
end

vgui.Register("AriviaCategory", PANEL, "DPanel")