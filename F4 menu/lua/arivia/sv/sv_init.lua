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

util.AddNetworkString( "AriviaSendTickerData" )

local function AriviaSendTickerInformation( ply, cmd, args )
	local rand = table.Random( Arivia.TickerNews )
	local text = rand.textNews
	local color = rand.textColor or Color( 255, 255, 255 )
	Arivia:SendTicker(text, color)
end
timer.Create("AriviaPrepareTickerData", 1, 0, AriviaSendTickerInformation )

function Arivia:SendTicker(text, col)
	net.Start( "AriviaSendTickerData" )
	net.WriteVector( Vector(col.r, col.g, col.b) )
	net.WriteString( text )
	net.Broadcast()
end