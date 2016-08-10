AddCSLuaFile()

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.Ent = data:GetEntity()
	
	self.Emitter = ParticleEmitter(self.Start)
	
	for i = 1, 30 do
		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start)

		p:SetDieTime(math.Rand(0.3, 0.4))
		p:SetStartAlpha(math.random(200, 255))
		p:SetEndAlpha(0)
		p:SetStartSize(1)
		p:SetEndSize(4)

		p:SetVelocity(self.Ent:EyeAngles():Forward() * 20)
		p:SetGravity(Vector(0, 0, math.random(-220, -150)))
		p:SetColor(95, 75, 45)
	end
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end





