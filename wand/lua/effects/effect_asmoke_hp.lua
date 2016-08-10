AddCSLuaFile()

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.Entity = data:GetEntity()
	
	self.Emitter = ParticleEmitter(self.Start)
		
	local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start)
	p:SetDieTime(math.Rand(2, 3))
	p:SetStartAlpha(GetConVar("hp_ap_a"):GetInt())
	p:SetEndAlpha(0)
	p:SetStartSize(370)
	p:SetEndSize(200)
	p:SetRoll(math.Rand(-10, 10))
	p:SetRollDelta(math.Rand(-10, 10))
	p:SetColor(GetConVar("hp_ap_r"):GetInt(), GetConVar("hp_ap_g"):GetInt(), GetConVar("hp_ap_b"):GetInt())
	
	for i = 1, 2 do
		if not IsValid(self.Entity) then return end
	
		local vec = Vector(self.Entity:GetPos().x + math.sin(CurTime() * 5) * 200, self.Entity:GetPos().y + math.cos(CurTime() * 5) * 200, self.Entity:GetPos().z)
		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), vec)
		p:SetDieTime(math.Rand(2, 3))
		p:SetStartAlpha(GetConVar("hp_ap_a"):GetInt())
		p:SetEndAlpha(0)
		p:SetStartSize(50)
		p:SetEndSize(25)
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))
		p:SetColor(GetConVar("hp_ap_r"):GetInt(), GetConVar("hp_ap_g"):GetInt(), GetConVar("hp_ap_b"):GetInt())
	end
	
	for i = 1, 2 do
		if not IsValid(self.Entity) then return end
	
		local vec = Vector(self.Entity:GetPos().x + math.sin(CurTime() * 10) * 200, self.Entity:GetPos().y + math.cos(CurTime() * 10) * 200, self.Entity:GetPos().z)
		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), vec)
		p:SetDieTime(math.Rand(2, 3))
		p:SetStartAlpha(GetConVar("hp_ap_a"):GetInt())
		p:SetEndAlpha(0)
		p:SetStartSize(50)
		p:SetEndSize(25)
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))
		p:SetColor(GetConVar("hp_ap_r"):GetInt(), GetConVar("hp_ap_g"):GetInt(), GetConVar("hp_ap_b"):GetInt())
	end
	
	for i = 1, 2 do
		if not IsValid(self.Entity) then return end
	
		local vec = Vector(self.Entity:GetPos().x + math.sin(CurTime() * 15) * 200, self.Entity:GetPos().y + math.cos(CurTime() * 15) * 200, self.Entity:GetPos().z)
		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), vec)
		p:SetDieTime(math.Rand(2, 3))
		p:SetStartAlpha(GetConVar("hp_ap_a"):GetInt())
		p:SetEndAlpha(0)
		p:SetStartSize(50)
		p:SetEndSize(25)
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))
		p:SetColor(GetConVar("hp_ap_r"):GetInt(), GetConVar("hp_ap_g"):GetInt(), GetConVar("hp_ap_b"):GetInt())
	end
		
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end


