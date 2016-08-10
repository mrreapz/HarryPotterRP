AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.Spawnable = false

function ENT:Draw()
	if SERVER then return end

	self:DrawModel()

	if self.Part then
		local p = self.Part:Add("sprites/flamelet" .. math.random(1, 5), self:GetPos())
		p:SetDieTime(math.Rand(1, 2))
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetStartSize(50)
		p:SetEndSize(40)
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))
	end
end

function ENT:Initialize()
	if CLIENT then self.Part = ParticleEmitter(self:GetPos()) return end
	
	self:SetModel("models/props_debris/concrete_chunk04a.mdl")
	self:SetModelScale(5, 0)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:DrawShadow(false)
	
	self:EmitSound("ambient/explosions/explode_6.wav", 120, 110)
	self:EmitSound("ambient/explosions/explode_8.wav", 100, 110)
	self:EmitSound("ambient/explosions/explode_5.wav", 100, 110)
	
	timer.Simple(7, function() if IsValid(self) then self:Remove() end end)
end

function ENT:Think()
	local x = math.sin(CurTime() * 15) * 500
	local y = math.cos(CurTime() * 15) * 500
	local pos = self:GetOwner():GetPos() + Vector(x, y, 150 + (math.sin(CurTime() * 15) * 30))
	
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 150)) do
		if v:IsPlayer() and v != self:GetOwner() and v:Alive() then v:Kill() end
	end
	
	self:SetPos(pos)
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