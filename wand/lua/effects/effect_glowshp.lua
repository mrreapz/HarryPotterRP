AddCSLuaFile()

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	
	self.Emitter = ParticleEmitter(self.Start)
	
	for i = 1, math.random(1, 5) do
		local p = self.Emitter:Add("sprites/glow04_noz", self.Start + VectorRand() * 90)

		p:SetDieTime(math.Rand(1, 2))
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetStartSize(25)
		p:SetRoll(math.Rand(-1, 1))
		p:SetRollDelta(math.Rand(-1, 1))
		p:SetEndSize(1)
		p:SetGravity(Vector(0, 0, math.random(80, 300)))
		p:SetAirResistance(20)
		p:SetColor(math.random(0, 255), 255, 255)
	end
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end





