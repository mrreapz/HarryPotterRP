--[[
	Author: Nuunuu
	Steam: https://steamcommunity.com/profiles/76561197995674374

	License:
	Do not redistribute. Other than that, do whatever you like.	
]]--

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
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

function ENT:Use( activator, caller )
	print("Success!!!")
	activator:SetDarkRPVar( "money", 500 )
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
