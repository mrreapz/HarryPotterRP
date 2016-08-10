--[[
	Author: Nuunuu
	Steam: https://steamcommunity.com/profiles/76561197995674374

	License:
	Do not redistribute. Other than that, do whatever you like.	
]]--

AddCSLuaFile()
shat = shat or {}
shat.config = {}
houses = team.GetAllTeams()
shat.config.unsorted = houses.UNSORTED
shat.config.gryffindor = houses.TEAM_GRYFFINDOR
shat.config.slytherin = houses.TEAM_SLYTHERIN
shat.config.hufflepuff = houses.TEAM_HUFFLEPUFF
shat.config.ravenclaw = houses.TEAM_RAVENCLAW
shat.config.mapspawn = {}
-- configuration

shat.config.mapspawn["rp_hogwarts"] = {
	{
		pos = Vector(1, -284, 64),
		ang = Angle( 0, 0, 0 )
	}
}