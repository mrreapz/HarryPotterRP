AddCSLuaFile()

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.Ang = data:GetAngles()
	self.Col = data:GetStart()
	self.Size = data:GetScale() or 1
	
	self.Emitter = ParticleEmitter(self.Start)
	
	for i = 1, 130 do
		self.Ang:RotateAroundAxis(self.Ang:Forward(), i)

		local p = self.Emitter:Add("particles/flamelet" .. math.random(1, 5), self.Start)

		p:SetDieTime(0.5)
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetStartSize(10)
		p:SetEndSize(30)
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))

		p:SetVelocity(self.Ang:Up() * (140 * self.Size))
		
		p:SetColor(self.Col.x, self.Col.y, self.Col.z)
	end
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end





