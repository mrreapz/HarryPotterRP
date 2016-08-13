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
-- [ INFO BUTTONS ]
-- 
-- Displayed on left-side of the F4 Menu
-- You can disable any one of these by changing 
-- enabled = true to false.
--
-- To open a URL:
--      Arivia:OpenURL("http://url.com", "Titlebar Text")
--
-- To open standard text:
--      Arivia:OpenText("Text here", "Titlebar Text")
--
-----------------------------------------------------------------

Arivia.UseIconsWithInfo = true -- This shows the icons with text.

Arivia.Settings.Menu.TitleForums = "Community Forums"
Arivia.Settings.Menu.LinkForums = "http://facepunch.com/"

Arivia.Settings.Menu.TitleDonate = "Donate to our Server!"
Arivia.Settings.Menu.LinkDonate = "http://paypal.com/"

Arivia.Settings.Menu.TitleWebsite = "Welcome to our Official Website!"
Arivia.Settings.Menu.LinkWebsite = "www.twitch.tv/normaldifficulty"

Arivia.Settings.Menu.TitleWorkshop = "The Official Network Steam Collection"
Arivia.Settings.Menu.LinkWorkshop = "http://steamcommunity.com/"

-----------------------------------------------------------------
-- [ RULES ]
-----------------------------------------------------------------

Arivia.Settings.Menu.TitleRules = "Network Rules"

Arivia.Settings.RulesTextColor = Color( 255, 255, 255, 255 )
Arivia.Settings.RulesText = 
[[

----THE RULES!----
[x] KNOW THE RULES.
[x] GET SORTED BEFORE ATTENDING CLASS.
[x] Legit RP Names (No Lore/Meme/Offensive Names).
[x] No being disrespectful to other players or staff
[x] NO Mic/Chat Spamming.
[x] NO Racism.
[x] NO RDMing/Free-Spelling.
[x] Must have intent RP at all times.
[x] Respect others
[x] Advert will only be used for RP situations. If I see otherwise, SHADOWBANNED.
[x] No AFKing for experience.
[x] *Bonus* DON’T STAND ON FLITWICK’S HEAD, Dickhead.


----INFRACTION CONSEQUENCES----
The following actions may be taken in this order [unless violating a more serious offense]:

[-] 3 Warnings = kick,
[-] 5 warnings = 3 day suspension,
[-] 7 warnings = Perminant ban.
[-] A permanent ban will be issued and shall not be removed
[-] Bypassing a server ban will result in a GLOBAL BAN from ALL servers within our network.

]]

Arivia.Settings.InfoButtons = {
    {
        name = "Online Staff",
        description = "Available to assist",
        icon = "arivia/arivia_button_staff.png",
        buttonNormal = Color(64, 105, 126, 190),
        buttonHover = Color(64, 105, 126, 240),
        textNormal = Color(255, 255, 255, 255),
        textHover = Color(255, 255, 255, 255),
        enabled = true,
        func = function()
            Arivia:OpenAdmins()
        end
    },
    { 
        enabled = true,
        name = "Rules", 
        description = "What you should know",
        icon = "arivia/arivia_button_rules.png",
        buttonNormal = Color( 163, 135, 79, 190 ), 
        buttonHover = Color( 163, 135, 79, 240 ), 
        textNormal = Color ( 255, 255, 255, 255 ),
        textHover = Color( 255, 255, 255, 255 ),
        func = function() Arivia:OpenExternal( Arivia.Settings.Menu.TitleRules, Arivia.Settings.RulesText, true ) end 
    },
    { 
        enabled = true,
        name = "Donate", 
        description = "Donate to help keep us running",
        icon = "arivia/arivia_button_donate.png",
        buttonNormal = Color( 145, 71, 101, 190 ), 
        buttonHover = Color( 145, 71, 101, 240 ), 
        textNormal = Color ( 255, 255, 255, 255 ),
        textHover = Color( 255, 255, 255, 255 ),
        func = function() Arivia:OpenExternal( Arivia.Settings.Menu.TitleDonate, Arivia.Settings.Menu.LinkDonate ) end 
    },
    { 
        enabled = true,
        name = "Website", 
        description = "Visit the official website",
        icon = "arivia/arivia_button_website.png",
        buttonNormal = Color( 72, 112, 58, 190 ), 
        buttonHover = Color( 72, 112, 58, 240 ), 
        textNormal = Color ( 255, 255, 255, 255 ),
        textHover = Color( 255, 255, 255, 255 ),
        func = function() Arivia:OpenExternal( Arivia.Settings.Menu.TitleWebsite, Arivia.Settings.Menu.LinkWebsite ) end 
    },
    { 
        enabled = true,
        name = "Steam Workshop", 
        description = "Download our addons here",
        icon = "arivia/arivia_button_workshop.png",
        buttonNormal = Color( 112, 87, 58, 190 ), 
        buttonHover = Color( 112, 87, 58, 220 ), 
        textNormal = Color ( 255, 255, 255, 255 ),
        textHover = Color( 255, 255, 255, 255 ),
        func = function() Arivia:OpenExternal( Arivia.Settings.Menu.TitleWorkshop, Arivia.Settings.Menu.LinkWorkshop ) end 
    },
    {
        enabled = true,
        name = "Disconnect",
        description = "Disconnect from our server",
        icon = "arivia/arivia_button_disconnect.png",
        buttonNormal = Color(124, 51, 50, 190),
        buttonHover = Color(124, 51, 50, 240),
        textNormal = Color(255, 255, 255, 255),
        textHover = Color(255, 255, 255, 255),
        func = function()
            RunConsoleCommand("disconnect")
        end
    }
}