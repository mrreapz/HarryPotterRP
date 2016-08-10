AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.Spawnable = false

function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()
	if CLIENT then return end
	
	self:SetModel("models/props_debris/concrete_chunk04a.mdl")
	self:SetModelScale(5, 0)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:DrawShadow(false)
end

function ENT:Think()
end

function ENT:PhysicsCollide(data, physobj)
	if CLIENT then return end
	
	//local decals = { "mhsWaterDecal", "mhsWaterDecalSmall" }

	local ef = EffectData()
	ef:SetOrigin(data.HitPos)
	util.Effect("Explosion", ef)
	
	util.BlastDamage(self, self:GetOwner(), self:GetPos(), 120, 300)
	util.ScreenShake(self:GetPos(), 10, 10, 1, 4000)
	
	self:Remove()
end