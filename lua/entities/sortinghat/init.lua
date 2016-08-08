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
	activator:EmitSound( "vo/npc/male01/behindyou01.wav", 50, 100 )
	activator:SetRunSpeed(GAMEMODE.Config.runspeed * 2)
	activator:changeTeam(TEAM_GRYFFINDOR)
end