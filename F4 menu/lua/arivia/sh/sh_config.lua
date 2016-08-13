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

-----------------------------------------------------------------
-- [ WORKSHOP / FASTDL RESOURCES ]
-----------------------------------------------------------------
-- Set [Arivia.Settings.ResourcesEnabled] to false if you do not 
-- wish for the server to force players to download the 
-- resources/materials.
-----------------------------------------------------------------
-- Set [Arivia.Settings.WorkshopEnabled] to false if you do not 
-- wish for the server to force clients to download the resources 
-- from the workshop.
-----------------------------------------------------------------
-- Set [Arivia.Settings.WorkshopMountGMAEnabled] to false if you 
-- do not wish for the server to force clients to download the 
-- resources from the workshop.
-----------------------------------------------------------------

Arivia.Settings.ResourcesEnabled = true
Arivia.Settings.WorkshopMountGMAEnabled = false
Arivia.Settings.WorkshopEnabled = true

-----------------------------------------------------------------
-- [ DEBUG MODE ]
-----------------------------------------------------------------
-- Enabling this will display special prints during 
-- particular processes which include resource / workshop 
-- mounting, special actions and more. Should really only enable
-- this if you need it.
-----------------------------------------------------------------

Arivia.Settings.DebugEnabled = false

-----------------------------------------------------------------
-- [ BACKGROUND SETTINGS ]
-----------------------------------------------------------------
-- These settings are for background functionality
-----------------------------------------------------------------

Arivia.Settings.BackgroundsEnabled = true
Arivia.Settings.BackgroundsBlurEnabled = true
Arivia.Settings.BackgroundsList = 
{
    "http://api.iamrichardt.com/products/1679/resources/wallpaper/wallpaper-001.jpg",
    "http://api.iamrichardt.com/products/1679/resources/wallpaper/wallpaper-002.jpg",
    "http://api.iamrichardt.com/products/1679/resources/wallpaper/wallpaper-003.jpg",
    "http://api.iamrichardt.com/products/1679/resources/wallpaper/wallpaper-004.jpg",
    "http://api.iamrichardt.com/products/1679/resources/wallpaper/wallpaper-005.jpg",
    "http://api.iamrichardt.com/products/1679/resources/wallpaper/wallpaper-006.jpg",
    "http://api.iamrichardt.com/products/1679/resources/wallpaper/wallpaper-007.jpg",
}

Arivia.Settings.LiveBackgroundsEnabled = true
Arivia.Settings.LiveBackgroundsList = 
{
    "http://api.iamrichardt.com/products/1679/resources/wallpaper/index.php?background=active_background_1.webm",
    "http://api.iamrichardt.com/products/1679/resources/wallpaper/index.php?background=active_background_2.webm",
    "http://api.iamrichardt.com/products/1679/resources/wallpaper/index.php?background=active_background_3.webm",
    "http://api.iamrichardt.com/products/1679/resources/wallpaper/index.php?background=active_background_4.webm",
    "http://api.iamrichardt.com/products/1679/resources/wallpaper/index.php?background=active_background_5.webm",
}

-----------------------------------------------------------------
-- [ F4 VISUAL SETTINGS ]
-----------------------------------------------------------------
-- These settings change the look of the F4 menu.
-----------------------------------------------------------------

Arivia.Settings.NetworkNameDisplayed = true                             -- Display a network name on top of F4 menu?
Arivia.Settings.NetworkName = "Welcome to the Network"                  -- Network name to display if above option enabled
Arivia.Settings.NetworknameColor = Color( 255, 255, 255, 255 )          -- Color for network name text

Arivia.Settings.PlayerMoneyColor = Color( 255, 255, 255, 255 )          -- Color for player money
Arivia.Settings.PlayerJobColor = Color( 255, 255, 255, 255 )            -- Color for player job color

Arivia.Settings.MiddlePanelBackgroundColor = Color( 16, 16, 16, 210 )   -- Middle panel background color
Arivia.Settings.LeftMidPanelBackgroundColor = Color( 0, 0, 0, 250 ) 	--Left Panel Background Color

Arivia.Settings.LeftTopPanelBackgroundColor = Color( 128, 0, 0, 250 )

Arivia.CloseButtonColor = Color( 255, 255, 255, 255 )           		-- Color for the close button in the top right

-----------------------------------------------------------------
-- [ PANEL REGENERATION ]
-----------------------------------------------------------------
-- This is really for debugging purposes.
-- Regenerates the panel completely each time it's opened. Therefore
-- whatever panel the user is on prior to closing the menu will not
-- be saved as it cannot remember.
--
-- By default this is turned OFF (false)
-----------------------------------------------------------------

Arivia.Settings.InitRegenPanel = true

-----------------------------------------------------------------
-- [ DEBUG MODE ]
-----------------------------------------------------------------
-- Turns on special prints to the console such as player model 
-- precaching, resource loads, and various other things pieces 
-- of info. Typically this is used for trouble-shooting and 
-- should be kept disabled (false) when not in use. 
-----------------------------------------------------------------

Arivia.Settings.Debug = false
Arivia.Settings.DebugColor = Color( 255, 0, 0 )

-----------------------------------------------------------------
-- [ CLOCK ]
-----------------------------------------------------------------
-- Properties for the clock in the bottom left.
-----------------------------------------------------------------
-- ClockEnabled     :: Enable/Disable clock
-- ClockFormat      :: Default format for clock
-- ClockColor       :: Color of clock text
-----------------------------------------------------------------

Arivia.Settings.ClockEnabled = true
Arivia.Settings.ClockFormat = "%a, %I:%M:%S %p"
Arivia.Settings.ClockColor = Color( 255, 255, 255, 255 )

-----------------------------------------------------------------
-- [ STAFF PANEL ]
-----------------------------------------------------------------
-- This will allow the F4 menu to display any staff that are
-- currently online. You can modify the colors of the cards.
-- As well as customize the name of the rank that will
-- appear with the card for that player.
-----------------------------------------------------------------
-- UserGroupColors  :: Colors for staff card box based on rank
-- UserGroupTitles  :: Allows you to rename a rank
-- StaffGroups      :: Specifies which ranks are considered "staff"
-----------------------------------------------------------------

Arivia.Settings.UserGroupColors = {}
Arivia.Settings.UserGroupColors["superadmin"] = Color( 200, 51, 50, 220 )
Arivia.Settings.UserGroupColors["admin"] = Color( 72, 112, 58, 220 )
Arivia.Settings.UserGroupColors["supervisor"] = Color( 145, 71, 101, 220 )
Arivia.Settings.UserGroupColors["operator"] = Color( 171, 108, 44, 220 )
Arivia.Settings.UserGroupColors["moderator"] = Color( 171, 108, 44, 220 )
Arivia.Settings.UserGroupColors["trialmod"] = Color( 163, 135, 79, 220 )

Arivia.Settings.UserGroupTitles = {}
Arivia.Settings.UserGroupTitles["superadmin"] = "Owner"
Arivia.Settings.UserGroupTitles["admin"] = "Administrator"
Arivia.Settings.UserGroupTitles["supervisor"] = "Supervisor"
Arivia.Settings.UserGroupTitles["operator"] = "Moderator"
Arivia.Settings.UserGroupTitles["moderator"] = "Moderator"
Arivia.Settings.UserGroupTitles["trialmod"] = "Trial Moderator"

Arivia.Settings.StaffGroups = { 
    "superadmin", 
    "admin", 
    "moderator" 
}

Arivia.Settings.StaffCardBlur = false
Arivia.Settings.StaffCardBackgroundUseRankColor = true                -- Use rank color for staff card background color?
Arivia.Settings.StaffCardBackgroundColor = Color( 0, 0, 0, 230 )      -- If Arivia.StaffCardBackgroundUseRankColor is FALSE - what do you want the card color to be?
Arivia.Settings.StaffCardNameColor = Color( 255, 255, 255, 255 )      -- Text color for player name
Arivia.Settings.StaffCardRankColor = Color( 255, 255, 255, 255 )      -- Text color for rank name

-----------------------------------------------------------------
-- [ LIST TITLE TRUNCATE ]
-----------------------------------------------------------------
-- Sometimes titles are too long. Truncate takes a long string 
-- and replaces the last few characters with [...]
-- Adjust the settings below if you notice it is a bit off.
-----------------------------------------------------------------
-- TruncateEnabled  :: If the truncate feature is on or off
-- TruncateLength   :: How wide text must be before it truncates
-----------------------------------------------------------------

Arivia.TruncateEnabled = true
Arivia.TruncateLength = 170

-----------------------------------------------------------------
-- [ INTERNAL BROWSER ]
-----------------------------------------------------------------
-- How the internet browser will act when outside links 
-- are clicked.
-----------------------------------------------------------------

Arivia.Settings.BrowserColor = Color( 0, 0, 0, 240 ) -- Color to use for the custom browser window.
Arivia.Settings.BrowserTitleTextColor = Color(255, 255, 255, 255)
Arivia.Settings.BrowserControlsEnabled = true

-----------------------------------------------------------------
-- [ BETA FEATURES ]
-----------------------------------------------------------------
-- These will be useful later - don't touch them for now.
-----------------------------------------------------------------

Arivia.Settings.ItemAmountH = 20
Arivia.Settings.ItemnameH = 23