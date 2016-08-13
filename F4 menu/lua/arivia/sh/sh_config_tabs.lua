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
-- [ MAIN TABS ]
-----------------------------------------------------------------
-- The main tabs for the F4 menu. These are populated automatically
-- based on the setup of your DarkRP server.
--
-- NOTE: DO NOT DELETE ANY OF THESE. IF ITEMS DO NOT EXIST - THEY
-- WILL REMOVE THEMSELVES AUTOMATICALLY.
-----------------------------------------------------------------
-- name..................Name of the tab
-- nameColor.............Text color for tab name.
-- description...........Description displayed under name.
-- icon..................Icon for tab
-- buttonColor...........Color of button in normal state.
-- buttonHoverColor......Color of button when mouse hovers over.
-- unavailableDarken.....If items will "dim" if they cannot buy.
-- unavailableColor......Color of item if they cannot buy.
-- prestigeEnabled.......Display prestige required to buy item. 
-- ......................(MUST HAVE PRESTIGE MOD INSTALLED)
-- xpsystemEnabled.......Display XP required to buy item. 
-- ......................(MUST HAVE XP MOD INSTALLED)
-----------------------------------------------------------------

Arivia.TabJobs = {
    name = "Jobs",
    nameColor = Color( 255, 240, 244 ),
    description = "Earning your paycheck",
    icon = "arivia/arivia_button_jobs.png",
    buttonColor = Color(64, 105, 126, 190),
    buttonHoverColor = Color(64, 105, 126, 240),
    unavailableDarken = true,
    unavailableColor = Color( 20, 20, 20, 200 ),
    showUnavailableJobs = false,
    prestigeEnabled = false,
    xpsystemEnabled = false,
}

Arivia.TabWeapons = {
    name = "Weapons",
    nameColor = Color( 255, 240, 244 ),
    description = "The beauty of the 2nd amendment",
    icon = "arivia/arivia_button_weapons.png",
    buttonColor = Color( 72, 112, 58, 190 ),
    buttonHoverColor = Color( 72, 112, 58, 240 ),
    unavailableDarken = true,
    unavailableColor = Color( 20, 20, 20, 200 ),
    prestigeEnabled = false,
    xpsystemEnabled = false,
}

Arivia.TabAmmo = {
    name = "Ammo",
    nameColor = Color( 255, 240, 244 ),
    description = "Keeping your guns ready",
    icon = "arivia/arivia_button_ammo.png",
    buttonColor = Color( 163, 135, 79, 190 ),
    buttonHoverColor = Color( 163, 135, 79, 240 ),
    unavailableDarken = true,
    unavailableColor = Color( 20, 20, 20, 200 ),
    prestigeEnabled = false,
    xpsystemEnabled = false,
}

Arivia.TabEntities = {
    name = "Entities",
    nameColor = Color( 255, 240, 244 ),
    description = "Items for use in-world",
    icon = "arivia/arivia_button_entities.png",
    buttonColor = Color( 124, 51, 50, 190 ),
    buttonHoverColor = Color( 124, 51, 50, 240 ),
    unavailableDarken = true,
    unavailableColor = Color( 20, 20, 20, 200 ),
    prestigeEnabled = false,
    xpsystemEnabled = false,
}

Arivia.TabVehicles = {
    name = "Vehicles",
    nameColor = Color( 255, 240, 244 ),
    description = "Getting your permit",
    icon = "arivia/arivia_button_vehicles.png",
    buttonColor = Color(64, 105, 126, 190),
    buttonHoverColor = Color(64, 105, 126, 240),
    unavailableDarken = true,
    unavailableColor = Color( 20, 20, 20, 200 ),
    prestigeEnabled = false,
    xpsystemEnabled = false,
}

Arivia.TabShipments = {
    name = "Shipments",
    nameColor = Color( 255, 240, 244 ),
    description = "Extra things to help out",
    icon = "arivia/arivia_button_shipments.png",
    buttonColor = Color( 145, 71, 101, 190 ),
    buttonHoverColor = Color( 145, 71, 101, 240 ),
    unavailableDarken = true,
    unavailableColor = Color( 20, 20, 20, 200 ),
    showUnavailableGuns = false,
    prestigeEnabled = false,
    xpsystemEnabled = false,
}

Arivia.TabFood = {
    name = "Food",
    nameColor = Color( 255, 240, 244 ),
    description = "Yummy for the tummy",
    icon = "arivia/arivia_button_food.png",
    buttonColor = Color( 145, 71, 101, 190 ),
    buttonHoverColor = Color( 145, 71, 101, 240 ),
    unavailableDarken = true,
    unavailableColor = Color( 20, 20, 20, 200 ),
    prestigeEnabled = false,
    xpsystemEnabled = false,
}
