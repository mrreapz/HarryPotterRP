AddCSLuaFile()

function EFFECT:Init(data)
	self.start = data:GetOrigin()
	
	self.Emitter = ParticleEmitter(self.start)
	
	//for i = 1, 2 do
		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self:GetPos())
		p:SetDieTime(math.Rand(0.5, 1))
		p:SetStartSize(math.Rand(1, 5))
		p:SetEndSize(0)
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))
	//end
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end