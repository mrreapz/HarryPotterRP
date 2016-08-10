AddCSLuaFile()

local blow = Material("particle/warp4_warp_NoZ")

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.Ang = Angle(90, 0, 0)
	self.size = 1600
	
	timer.Simple(0.3, function()
		self.Emitter = ParticleEmitter(self.Start)
		
		for i = 1, 350 do
			self.Ang:RotateAroundAxis(self.Ang:Forward(), i)

			local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start)
			p:SetDieTime(math.Rand(0.4, 0.7))
			p:SetStartAlpha(255)
			p:SetEndAlpha(0)
			p:SetStartSize(120)
			p:SetEndSize(50)
			p:SetRoll(math.Rand(-60, 60))
			p:SetRollDelta(math.Rand(-60, 60))
			p:SetVelocity(self.Ang:Up() * 3000)
			p:SetColor(50, 50, 50)
		end
		
		self.Emitter:Finish()
	end)
	
	self.Die = CurTime() + 4
end

function EFFECT:Think()
	if CurTime() > self.Die then return false end
	
	if self.size > 0 then self.size = self.size - 35 end
	
	return true
end

function EFFECT:Render()
	render.SetMaterial(blow)
	render.DrawSprite(self.Start, self.size, self.size, Color(255, 255, 255, 255))
end

