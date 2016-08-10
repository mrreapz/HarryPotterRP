AddCSLuaFile()

function EFFECT:Init(data)
	self.Ply = data:GetEntity()
	local tr = self.Ply:GetEyeTrace()
	self.Start = self.Ply:GetShootPos()
	
	local dist = self.Start:Distance(tr.HitPos)
	
	self.Emitter = ParticleEmitter(self.Start)
	
	for i = 1, dist / 125 do
		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start + self.Ply:GetAimVector() * i * 125)

		p:SetDieTime(i / 5)
		p:SetStartAlpha(math.random(150, 200))
		p:SetEndAlpha(0)
		p:SetStartSize(80)
		p:SetRoll(math.Rand(-1, 1))
		p:SetRollDelta(math.Rand(-1, 1))
		p:SetEndSize(260)
		p:SetAirResistance(150)
		p:SetColor(0, 0, 0)
	end
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end





