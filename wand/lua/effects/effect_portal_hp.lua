AddCSLuaFile()

local mat = Material("particle/particle_glow_02")

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.Norm = data:GetNormal()
	self.size = 1
	self.End = false
	
	self.Die = CurTime() + 10
	
	timer.Simple(8.5, function()
		self.End = true
	end)
end

function EFFECT:Think()
	if CurTime() > self.Die then return false end
	
	if not self.End and self.size < 160 then self.size = self.size + 2 end
	
	if self.End and self.size > 0 then self.size = self.size - 4 end
	
	return true
end

function EFFECT:Render()
	render.SetMaterial(mat)
	render.DrawQuadEasy(self.Start, self.Norm, self.size, self.size, Color(255, 255, 255), 90)
end

