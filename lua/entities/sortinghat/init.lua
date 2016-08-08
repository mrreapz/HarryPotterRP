--[[
	Author: Nuunuu
	Steam: https://steamcommunity.com/profiles/76561197995674374

	License:
	Do not redistribute. Other than that, do whatever you like.	
]]--

AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel("models/half-dead/wizards/hat_01.mdl")
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

function ENT:Use( ply, activator )
	ply:SetHealth(50)
	ply:changeTeam(TEAM_GRYFFINDOR)
end

function SortingHatSpawn()
	local shSpawn = vm.config.mapspawn[ game.GetMap() ]
	
	for k, v in pairs( shSpawn ) do
		local sortinghat = ents.Create( "sortinghat" )
		sortinghat:SetPos( v.pos )
		sortinghat:SetAngles( v.ang )
		sortinghat:SetMoveType( MOVETYPE_NONE )
		sortinghat:Spawn()
	end
end

hook.Add( "InitPostEntity", "SpawnSortingHat", SortingHatSpawn )
