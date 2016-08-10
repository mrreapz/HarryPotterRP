AddCSLuaFile()

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	
	self.Emitter = ParticleEmitter(self.Start)
	
	for b = 1, 7 do
		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start)

		p:SetDieTime(math.Rand(2, 3))
		p:SetStartAlpha(math.random(150, 200))
		p:SetEndAlpha(0)
		p:SetStartSize(300)
		p:SetEndSize(600)

		p:SetVelocity(VectorRand() * 70)
		p:SetColor(0, 255, 0)
		p:SetCollide(true)
	end
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end





