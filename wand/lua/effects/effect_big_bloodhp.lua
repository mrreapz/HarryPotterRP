AddCSLuaFile()

//not a blood ;c

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	
	self.Emitter = ParticleEmitter(self.Start)
	
	for i = 1, 100 do
		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start)

		p:SetDieTime(math.Rand(0.1, 1.2))
		p:SetStartAlpha(math.random(150, 210))
		p:SetEndAlpha(0)
		p:SetStartSize(50)
		p:SetEndSize(190)

		p:SetVelocity(VectorRand() * 140)
		p:SetGravity(Vector(0, 0, -70))
		p:SetAirResistance(100)
		p:SetColor(230, 200, 200)
	end
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end





