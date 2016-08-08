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
	self.health = 10000000
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Use( activator )
	timer.Simple( 0, function()
		activator:EmitSound( "oasisrp/soda/slurp.wav", 50, 100 )
	end )

	activator:changeTeam(TEAM_GRYFFINDOR)
end