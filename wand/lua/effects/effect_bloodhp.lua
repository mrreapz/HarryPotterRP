AddCSLuaFile()

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	
	self.Emitter = ParticleEmitter(self.Start)
	
	for i = 1, math.random(3, 4) do
		local vec = VectorRand()
		vec.z = 0
	
		for b = 1, math.random(4, 7) do
			local vec2 = VectorRand()
			vec2.x = 0
			vec2.y = 0
			local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start + (vec2 * 15))

			p:SetDieTime(math.Rand(0.8, 1.5))
			p:SetStartAlpha(math.random(150, 200))
			p:SetEndAlpha(0)
			p:SetStartSize(10)
			p:SetEndSize(30)

			p:SetVelocity(vec * math.random(40, 80))
			p:SetGravity(Vector(0, 0, -170))
			p:SetColor(230, 0, 0)
		end
	end
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end





