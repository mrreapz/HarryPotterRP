--[[
	Author: Nuunuu
	Steam: https://steamcommunity.com/profiles/76561197995674374

	License:
	Do not redistribute. Other than that, do whatever you like.	
]]--

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )
include("darkrp_customthings/professions.lua")

local function GetRandomHouseArray()
	local a = {}

	a[0] = TEAM_SLYTHERIN
	a[1] = TEAM_GRYFFINDOR
	a[2] = TEAM_HUFFLEPUFF
	a[3] = TEAM_RAVENCLAW

	for i = 0, 3
	do
		local j = math.random( 0, i )

		-- Swap the elements at positions i and j.
		local temp = a[i]
		a[i] = a[j]
		a[j] = temp
	end

	return a
end


function ENT:Initialize()
	self.totalHouses = 4
	self.currentHouse = 0
	self.houseSounds = {
		TEAM_GRYFFINDOR = "sortinghat/AnnounceGryffindor.wav",
		TEAM_HUFFLEPUFF = "sortinghat/AnnounceHufflepuff.wav",
		TEAM_RAVENCLAW = "sortinghat/AnnounceRavenclaw.wav",
		TEAM_SLYTHERIN = "sortinghat/AnnounceSlytherin.wav"
	}
	self.houseList = GetRandomHouseArray()
	
	self:SetModel("models/half-dead/wizards/hat_01.mdl")
	--self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion( false )
		phys:Wake()
	end
end

function ENT:Use( activator, caller )
	if (activator:GetDarkRPVar( "job" ) == "Unsorted") then
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
		effectdata:SetMagnitude(1)
		effectdata:SetScale(1)
		effectdata:SetRadius(2)
		util.Effect("Sparks", effectdata)

		local house = self.houseList[self.currentHouse]
		self.currentHouse += 1
		if self.currentHouse >= self.totalHouses then
			self.currentHouse == 0
			self.houseList = GetRandomHouseArray()
		end

		ENT:EmitSound(self.houseSounds[house])
		activator:ChangeTeam(house, true)
	end
end

function SortingHatSpawn()
	local shSpawn = shat.config.mapspawn[ game.GetMap() ]
	
	for k, v in pairs( shSpawn ) do
		local sortinghat = ents.Create( "rp_sortinghat" )
		sortinghat:SetPos( v.pos )
		sortinghat:SetAngles( v.ang )
		sortinghat:SetMoveType( MOVETYPE_NONE )
		sortinghat:Spawn()
		sortinghat:Activate()
	end
end

hook.Add( "InitPostEntity", "SpawnSortingHat", SortingHatSpawn )
