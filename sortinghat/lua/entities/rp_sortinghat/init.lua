--[[
	Author: Nuunuu
	Steam: https://steamcommunity.com/profiles/76561197995674374

	License:
	Do not redistribute. Other than that, do whatever you like.	
]]--

AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
include("darkrp_config/sortinghat_settings.lua")

local function GetRandomHouseArray()
	local a = {}

	a[0] = shat.config.slytherin
	a[1] = shat.config.gryffindor
	a[2] = shat.config.hufflepuff
	a[3] = shat.config.ravenclaw

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
	self.houseSounds = {}
	self.houseSounds[shat.config.gryffindor] = "sortinghat/AnnounceGryffindor.wav"
	self.houseSounds[shat.config.hufflepuff] = "sortinghat/AnnounceHufflepuff.wav"
	self.houseSounds[shat.config.ravenclaw] = "sortinghat/AnnounceRavenclaw.wav"
	self.houseSounds[shat.config.slytherin] = "sortinghat/AnnounceSlytherin.wav"
	
	self.houseList = GetRandomHouseArray()
	
	--self:SetModel("models/half-dead/wizards/hat_01.mdl")
	self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
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
	if (activator:getDarkRPVar( "job" ) == "Unsorted") then
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
		effectdata:SetMagnitude(1)
		effectdata:SetScale(1)
		effectdata:SetRadius(2)
		util.Effect("Sparks", effectdata)

		local house = self.houseList[self.currentHouse]
		self.currentHouse = self.currentHouse + 1
		if self.currentHouse >= self.totalHouses then
			self.currentHouse = 0
			self.houseList = GetRandomHouseArray()
		end

		self:EmitSound(self.houseSounds[house])
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
