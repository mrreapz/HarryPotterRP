AddCSLuaFile()

function EFFECT:Init(data)
	local lightings = { [1] = "effects/tool_tracer", [2] = "jforce/lighting_jf_red" }
	self.lighting = Material(lightings[data:GetAttachment()])
	
	self.Owner = data:GetEntity()
	
	local pos
	
	local hand = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if hand then 
		pos = self.Owner:GetBonePosition(hand) 
	else 
		pos = self.Owner:GetShootPos() + Vector(0, 0, -20) 
	end
	
	self.Start = pos
	
	self.Col = data:GetStart() //color
	self.Time = CurTime() + 0.1
	
	local dlight = DynamicLight(self.Owner:EntIndex())
	dlight.Pos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 160
	dlight.r = self.Col.x
	dlight.g = self.Col.y
	dlight.b = self.Col.z
	dlight.Brightness = 1
	dlight.Size = math.random(400, 800)
	dlight.Decay = 1
	dlight.DieTime = CurTime() + 0.1
    dlight.Style = 0
	
	self:SetRenderBoundsWS(self.Start, self.Owner:GetShootPos() + self.Owner:GetAimVector() * 450)
end

function EFFECT:Think()
	if CurTime() > self.Time then return false end
	return true
end

function EFFECT:Render()
	render.SetMaterial(self.lighting)

	for i = 1, 15 do
		local ang = self.Owner:EyeAngles()
		ang.p = ang.p + 45
		
		local vec = VectorRand()
		vec.x = math.abs(vec.x)
		vec.z = math.abs(vec.z)
		
		vec:Rotate(ang)
		
		self.End = self.Start + vec * 4
		
		render.DrawBeam(self.Start, self.End, 7, 0, 5, Color(255, 255, 255, 255))
		
		self.Start = self.End
	end
end





