AddCSLuaFile()

local blow = Material("sprites/orangeflare1")

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.Ang = data:GetAngles()
	self.size = 1000
	self.alpha = 255
	
	self.Emitter = ParticleEmitter(self.Start)
		
	for i = 1, 250 do
		self.Ang:RotateAroundAxis(self.Ang:Forward(), i)

		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start)
		p:SetDieTime(math.Rand(2, 3))
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetStartSize(1000)
		p:SetEndSize(800)
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))
		p:SetVelocity(self.Ang:Up() * 5000)
		p:SetColor(50, 50, 50)
		//p:SetCollide(true)
		
		local p = self.Emitter:Add("effects/fleck_cement" .. math.random(1, 2), self.Start + Vector(0, 0, 30))
		p:SetDieTime(math.Rand(8, 12))
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetStartSize(math.Rand(30, 100))
		p:SetEndSize(math.Rand(4, 6))
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))

		local vec = VectorRand()
		vec.z = math.abs(vec.z)
		p:SetVelocity((self.Ang:Up() * math.random(1000, 1500)) + vec * math.random(900, 2000))
		p:SetGravity(Vector(0, 0, math.Rand(-260, -190)))
		p:SetColor(50, 50, 50)
	end
		
	self.Emitter:Finish()
	
	self.Die = CurTime() + 6
end

function EFFECT:Think()
	if CurTime() > self.Die then return false end
	
	if self.size < 130000 then self.size = self.size + 250 end
	if self.alpha > 0 then self.alpha = self.alpha - 0.4 end
	
	return true
end

function EFFECT:Render()
	render.SetMaterial(blow)
	render.DrawSprite(self.Start + Vector(0, 0, 600), self.size + 13000, self.size, Color(255, 255, 255, self.alpha))
end


