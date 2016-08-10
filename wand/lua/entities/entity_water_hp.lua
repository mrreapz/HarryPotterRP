AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.Spawnable = false

function ENT:Draw()
end

function ENT:Initialize()
	if CLIENT then return end
	
	self:SetModel("models/props_debris/concrete_chunk05g.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMaterial("models/shadertest/shader3")
	self:DrawShadow(false)
end

function ENT:Think()
	local ef = EffectData()
	ef:SetOrigin(self:GetPos())
	util.Effect("effect_waterr_hp", ef)
end

function ENT:PhysicsCollide(data, physobj)
	if CLIENT then return end
	
	//local decals = { "mhsWaterDecal", "mhsWaterDecalSmall" }

	local ef = EffectData()
	ef:SetStart(self:GetPos())
	ef:SetOrigin(self:GetPos())
	ef:SetScale(math.random(3, 7))
	util.Effect("watersplash", ef)
	
	//util.Decal(decals[math.random(1, #decals)], data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)
	
	local owner = self:GetOwner()
	
	if IsValid(data.HitEntity) then
		if data.HitEntity:IsOnFire() then data.HitEntity:Extinguish() end
	
		data.HitEntity:TakeDamage(math.random(0, 1), self.Owner, self)
	end
	
	self:Remove()
end