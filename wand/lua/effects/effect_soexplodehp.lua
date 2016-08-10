AddCSLuaFile()

local blow = Material("particle/warp2_warp")
local glow = Material("effects/brightglow_y")

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.Ang = data:GetAngles()
	self.Norm = data:GetNormal()
	self.size = 0
	self.alph = 255
	
	timer.Simple(0.3, function()
		self.Emitter = ParticleEmitter(self.Start)
		
		for i = 1, 160 do
			self.Ang:RotateAroundAxis(self.Ang:Forward(), i)

			local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start)
			p:SetDieTime(math.Rand(1, 2))
			p:SetStartAlpha(150)
			p:SetEndAlpha(0)
			p:SetStartSize(230)
			p:SetEndSize(0)
			p:SetRoll(math.Rand(-10, 10))
			p:SetRollDelta(math.Rand(-10, 10))
			p:SetVelocity(self.Ang:Up() * 1000)
			p:SetColor(50, 50, 50)
			
			local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start)
			p:SetDieTime(math.Rand(0.5, 1))
			p:SetStartAlpha(150)
			p:SetEndAlpha(0)
			p:SetStartSize(230)
			p:SetEndSize(0)
			p:SetRoll(math.Rand(-10, 10))
			p:SetRollDelta(math.Rand(-10, 10))
			p:SetVelocity(VectorRand() * math.random(800, 1300) - self.Norm * math.random(800, 1300))
			p:SetAirResistance(200)
			p:SetColor(50, 50, 50)
			
			local p = self.Emitter:Add("effects/fleck_cement" .. math.random(1, 2), self.Start + (VectorRand() * 20))
			p:SetDieTime(math.Rand(5, 7))
			p:SetStartAlpha(255)
			p:SetEndAlpha(0)
			p:SetStartSize(math.Rand(4, 20))
			p:SetEndSize(math.Rand(4, 6))
			p:SetRoll(math.Rand(-10, 10))
			p:SetRollDelta(math.Rand(-10, 10))

			p:SetVelocity((-self.Norm * math.random(200, 700)) + VectorRand() * math.random(900, 2000))
			p:SetCollide(true)
			p:SetGravity(Vector(0, 0, math.Rand(-260, -190)))
			p:SetColor(50, 50, 50)
		end
		
		self.Emitter:Finish()
	end)
	
	self.Die = CurTime() + 3
end

function EFFECT:Think()
	if CurTime() > self.Die then return false end
	
	self.size = self.size + 20
	if self.alph > 1 then self.alph = self.alph - 2 end
	
	return true
end

function EFFECT:Render()
	render.SetMaterial(blow)
	render.DrawSprite(self.Start, self.size, self.size, Color(255, 255, 255, self.alph))
	render.DrawQuadEasy(self.Start, self.Norm, self.size * 2, self.size * 2, Color(255, 255, 255, self.alph), self.size * 0.2)
	
	render.SetMaterial(glow)
	render.DrawSprite(self.Start, self.size * 5, self.size * 3, Color(255, 255, 255, self.alph * 2))
end





