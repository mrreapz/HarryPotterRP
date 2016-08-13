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
-- [ COMMANDS / CONTROL BUTTONS ]
-- 
-- These are pretty much set for your own specifications based 
-- on what features your server has. I like to use a certain
-- color scheme for the buttons, so if you would like the same;
-- I've listed the colors below:
--
-- Red              Color( 124, 51, 50, 190 )
-- Yellow/Gold      Color( 163, 135, 79, 190 )
-- Blue             Color( 64, 105, 126, 190 )
-- Fuschia          Color( 145, 71, 101, 190 )
-- Green            Color( 72, 112, 58, 190 )
-- Brown            Color( 112, 87, 58, 190 )
--
-----------------------------------------------------------------

Arivia.Commands = {
    { 
        name = "Drop Money", 
        command = "/dropmoney", 
        buttonNormal = Color(72, 112, 58, 190),
        buttonHover = Color(72, 112, 58, 240),
        textNormal = Color(255, 255, 255, 255),
        textHover = Color(255, 255, 255, 255),
        argCount = 1, 
        arg1 = "Amount",
        arg2 = "Amount" 
    },
    { 
        name = "Give Money", 
        command = "/give", 
        buttonNormal = Color(72, 112, 58, 190),
        buttonHover = Color(72, 112, 58, 240),
        buttonOutline = Color(255, 255, 255, 50),
        textNormal = Color(255, 255, 255, 255),
        textHover = Color(255, 255, 255, 255),
        argCount = 1, 
        arg1 = "Amount",
        arg2 = "Amount" 
    },
    { 
        name = "Separator"
    },
    { 
        name = "Drop Weapon", 
        command = "/drop", 
        buttonNormal = Color(163, 135, 79, 190),
        buttonHover = Color(163, 135, 79, 240),
        buttonOutline = Color(255, 255, 255, 50),
        textNormal = Color(255, 255, 255, 255),
        textHover = Color(255, 255, 255, 255),
        argCount = 0,
        arg1 = "",
        arg2 = "" 
    },
    { 
        name = "Make Shipment", 
        command = "/makeshipment", 
        buttonNormal = Color(163, 135, 79, 190),
        buttonHover = Color(163, 135, 79, 240),
        buttonOutline = Color(255, 255, 255, 50),
        textNormal = Color(255, 255, 255, 255),
        textHover = Color(255, 255, 255, 255),
        argCount = 0,
        arg1 = "",
        arg2 = "" 
    },
    { 
        name = "Sell All Doors", 
        command = "/unownalldoors", 
        buttonNormal = Color(163, 135, 79, 190),
        buttonHover = Color(163, 135, 79, 240),
        buttonOutline = Color(255, 255, 255, 50),
        textNormal = Color(255, 255, 255, 255),
        textHover = Color(255, 255, 255, 255),
        argCount = 0,
        arg1 = "",
        arg2 = "" 
    },
    { 
        name = "Request Gun License", 
        command = "/requestlicense", 
        buttonNormal = Color(163, 135, 79, 190),
        buttonHover = Color(163, 135, 79, 240),
        buttonOutline = Color(255, 255, 255, 50),
        textNormal = Color(255, 255, 255, 255),
        textHover = Color(255, 255, 255, 255),
        argCount = 0,
        arg1 = "",
        arg2 = "" 
    },
    {
        name = "Separator", 
        mayorOnly = true
    },
    { 
        name = "Start Lockdown", 
        command = "/lockdown", 
        buttonNormal = Color(64, 105, 126, 190),
        buttonHover = Color(64, 105, 126, 240),
        buttonOutline = Color(255, 255, 255, 50),
        textNormal = Color(255, 255, 255, 255),
        textHover = Color(255, 255, 255, 255),
        argCount = 0, 
        arg1 = "",
        arg2 = "",
        mayorOnly = true
    },
    {
        name = "Stop Lockdown", 
        command = "/unlockdown", 
        buttonNormal = Color(64, 105, 126, 190),
        buttonHover = Color(64, 105, 126, 240),
        buttonOutline = Color(255, 255, 255, 50),
        textNormal = Color(255, 255, 255, 255),
        textHover = Color(255, 255, 255, 255),
        argCount = 0, 
        arg1 = "",
        arg2 = "",
        mayorOnly = true
    },
    {
        name = "Add Law", 
        command = "/addlaw", 
        buttonNormal = Color(64, 105, 126, 190),
        buttonHover = Color(64, 105, 126, 240),
        buttonOutline = Color(255, 255, 255, 50),
        textNormal = Color(255, 255, 255, 255),
        textHover = Color(255, 255, 255, 255),
        argCount = 1, 
        arg1 = "New Law",
        arg2 = "",
        mayorOnly = true
    },
    {
        name = "Remove Law", 
        command = "/removelaw", 
        buttonNormal = Color(64, 105, 126, 190),
        buttonHover = Color(64, 105, 126, 240),
        buttonOutline = Color(255, 255, 255, 50),
        textNormal = Color(255, 255, 255, 255),
        textHover = Color(255, 255, 255, 255),
        argCount = 1, 
        arg1 = "Law Number",
        arg2 = "",
        mayorOnly = true
    },
    {
        name = "Place Lawboard", 
        command = "/placelaws", 
        buttonNormal = Color(64, 105, 126, 190),
        buttonHover = Color(64, 105, 126, 240),
        buttonOutline = Color(255, 255, 255, 50),
        textNormal = Color(255, 255, 255, 255),
        textHover = Color(255, 255, 255, 255),
        argCount = 0, 
        arg1 = "",
        arg2 = "",
        mayorOnly = true
    },            
    {
        name = "Broadcast Message", 
        command = "/broadcast", 
        buttonNormal = Color(64, 105, 126, 190),
        buttonHover = Color(64, 105, 126, 240),
        buttonOutline = Color(255, 255, 255, 50),
        textNormal = Color(255, 255, 255, 255),
        textHover = Color(255, 255, 255, 255),
        argCount = 1, 
        arg1 = "Law Number",
        arg2 = "",
        mayorOnly = true
    },
    {
        name = "Separator", 
        civilProtectionOnly = true
    },
    {
        name = "Search Warrant", 
        command = "/warrant", 
        buttonNormal = Color(124, 51, 50, 190),
        buttonHover = Color(124, 51, 50, 240),
        buttonOutline = Color(255, 255, 255, 50),
        textNormal = Color(255, 255, 255, 255),
        textHover = Color(255, 255, 255, 255),
        argCount = 2, 
        arg1 = "Player",
        arg2 = "Reason",
        civilProtectionOnly = true
    },
    {
        name = "Wanted Player", 
        command = "/wanted", 
        buttonNormal = Color(124, 51, 50, 190),
        buttonHover = Color(124, 51, 50, 240),
        buttonOutline = Color(255, 255, 255, 50),
        textNormal = Color(255, 255, 255, 255),
        textHover = Color(255, 255, 255, 255),
        argCount = 2, 
        arg1 = "Player",
        arg2 = "Reason",
        civilProtectionOnly = true
    },
    {
        name = "Remove Wanted Status", 
        command = "/unwanted", 
        buttonNormal = Color(124, 51, 50, 190),
        buttonHover = Color(124, 51, 50, 240),
        buttonOutline = Color(255, 255, 255, 50),
        textNormal = Color(255, 255, 255, 255),
        textHover = Color(255, 255, 255, 255),
        argCount = 1, 
        arg1 = "Player",
        arg2 = "",
        civilProtectionOnly = true
    }
    
}
