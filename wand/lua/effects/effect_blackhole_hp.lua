AddCSLuaFile()

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.Ang = data:GetAngles()
	
	self.Emitter = ParticleEmitter(self.Start)
		
	//for i = 1, 1 do
		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start)
		p:SetDieTime(math.Rand(1, 1.5))
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetStartSize(400)
		p:SetEndSize(100)
		p:SetVelocity(VectorRand() * 40)
		p:SetColor(0, 0, 0)
		
		if math.random(1, 30) == 4 then
			local p = self.Emitter:Add("particle/warp2_warp", self.Start)
			p:SetDieTime(math.Rand(1, 1.5))
			p:SetStartAlpha(255)
			p:SetEndAlpha(0)
			p:SetStartSize(400)
			p:SetEndSize(100)
			p:SetVelocity(VectorRand() * 300)
		end
		
		local pos = self.Start + VectorRand() * 1200
		local p = self.Emitter:Add("particle/particle_glow_05_addnofog", pos)
		p:SetDieTime(math.Rand(1, 2))
		p:SetStartAlpha(0)
		p:SetEndAlpha(255)
		p:SetStartSize(0)
		p:SetEndSize(20)
		p:SetVelocity((self.Start - pos) * 0.5)
		
		for i = 1, 3 do
			local pos = self.Start + VectorRand() * 3000
			local p = self.Emitter:Add("particle/particle_glow_05_addnofog", pos)
			p:SetDieTime(math.Rand(1, 2))
			p:SetStartAlpha(0)
			p:SetEndAlpha(255)
			p:SetStartSize(0)
			p:SetEndSize(math.random(20, 50))
			p:SetColor(math.random(0, 255), math.random(0, 255), 0)
			p:SetVelocity((self.Start - pos) * 0.4)
		end
		//p:SetCollide(true)
	//end
		
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end


