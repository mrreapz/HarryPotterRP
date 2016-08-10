--[[
	Author: Nuunuu
	Steam: https://steamcommunity.com/profiles/76561197995674374

	License:
	Do not redistribute. Other than that, do whatever you like.	
]]--

AddCSLuaFile()
shat = shat or {}
shat.config = {}

shat.config.unsorted = GetGlobalInt("TEAM_UNSORTED")
shat.config.gryffindor = GetGlobalInt("TEAM_GRYFFINDOR")
shat.config.slytherin = GetGlobalInt("TEAM_SLYTHERIN")
shat.config.hufflepuff = GetGlobalInt("TEAM_HUFFLEPUFF")
shat.config.ravenclaw = GetGlobalInt("TEAM_RAVENCLAW")
shat.config.mapspawn = {}
-- configuration

shat.config.mapspawn["rp_hogwarts"] = {
	{
		pos = Vector(1, -284, 64),
		ang = Angle( 0, 0, 0 )
	}
}