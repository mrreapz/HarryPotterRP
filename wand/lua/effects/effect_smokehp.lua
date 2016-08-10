AddCSLuaFile()

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.col = data:GetStart()
	
	self.Emitter = ParticleEmitter(self.Start)
	
	for i = 1, math.random(40, 80) do
		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start + VectorRand() * 2)

		p:SetDieTime(math.Rand(6, 10))
		p:SetStartAlpha(math.random(150, 200))
		p:SetEndAlpha(0)
		p:SetStartSize(80)
		p:SetRoll(math.Rand(-1, 1))
		p:SetRollDelta(math.Rand(-1, 1))
		p:SetEndSize(260)
		p:SetGravity(Vector(0, 0, math.random(-10, 10)))
		
		p:SetVelocity(((self.Start + VectorRand() * 2) - self.Start):GetNormal() * 80)
		p:SetAirResistance(20)
		//timer.Simple(1.5, function() p:SetVelocity(p:GetVelocity() / 5) end)
		p:SetColor(self.col.x, self.col.y, self.col.z)
	end
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end





