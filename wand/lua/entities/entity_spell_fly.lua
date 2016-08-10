AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.Spawnable = false

if CLIENT then ENT.STORM_brightness = 0 end

function ENT:Draw()
	if SERVER then return end

	if self.Emitter and not self:GetNWBool("SpellNoDraw") then
		local color = self:GetNWVector("SpellColor")
		if not GetConVar("hp_enablefulldraw"):GetBool() then return end
	
		local p = self.Emitter:Add("particle/fire", self:GetPos() + VectorRand() * (3 + self:GetNWFloat("SpellSize")))
		p:SetDieTime(math.Rand(0.5, 1.5))
		p:SetGravity(Vector(0, 0, math.random(-50, 50)))
		p:SetStartSize(math.Rand(2, 5) + self:GetNWFloat("SpellSize"))
		p:SetEndSize(0)
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))
		p:SetColor(color.x, color.y, color.z)
	
		local p = self.Emitter:Add("particle/fire", self:LocalToWorld(Vector(0, math.sin(CurTime() * 30) * 10, math.cos(CurTime() * 30) * 10)))
		p:SetDieTime(math.Rand(0.5, 1.5))
		p:SetStartSize(math.Rand(3, 6) + self:GetNWFloat("SpellSize"))
		p:SetEndSize(0)
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))
		p:SetColor(color.x, color.y, color.z)
		
		local p = self.Emitter:Add("particle/fire", self:LocalToWorld(Vector(0, math.sin(CurTime() * 60) * 10, math.cos(CurTime() * 60) * 10)))
		p:SetDieTime(math.Rand(0.5, 1.5))
		p:SetStartSize(math.Rand(3, 6) + self:GetNWFloat("SpellSize"))
		p:SetEndSize(0)
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))
		p:SetColor(color.x, color.y, color.z)
	end
	
	if self:GetNWBool("makesuperstuff") and self.STORM_brightness then
		if self.STORM_brightness < 0.8 then self.STORM_brightness = self.STORM_brightness + 0.02 end
	end
end

if SERVER then ENT.mag = {} end

function ENT:Initialize()
	if CLIENT then 
		self.Emitter = ParticleEmitter(self:GetPos()) 
		
		hook.Add("RenderScreenspaceEffects", "stuff_storm_hp" .. self:EntIndex(), function()
			if not self then hook.Remove("RenderScreenspaceEffects", "stuff_storm_hp" .. self:EntIndex()) return end
			if not self.STORM_brightness then hook.Remove("RenderScreenspaceEffects", "stuff_storm_hp" .. self:EntIndex()) return end
		
			local tab = {}
			tab["$pp_colour_addr"] = 0
			tab["$pp_colour_addg"] = 0
			tab["$pp_colour_addb"] = 0
			tab["$pp_colour_brightness"] = self.STORM_brightness
			tab["$pp_colour_contrast"] = 1
			tab["$pp_colour_colour"] = 1
			tab["$pp_colour_mulr"] = 0
			tab["$pp_colour_mulg"] = 0
			tab["$pp_colour_mulb"] = 0
		 
			DrawColorModify(tab)
		end)
		
		return 
	end
	
	self:SetAngles(self:GetOwner():EyeAngles())
	
	self:SetNWVector("SpellColor", Vector(0, 150, 255))
	self:SetNWFloat("SpellLife", 2)
	self:SetNWFloat("SpellAlpha", 255)
	self:SetNWFloat("SpellSize", 0)
	
	timer.Simple(0.001, function()
		if not IsValid(self) then return end
		
		local vector = self:GetOwner():GetAimVector()
		
		self:GetPhysicsObject():EnableGravity(false)
			
		timer.Create("speedSpell" .. self:EntIndex(), 0.01, 0, function() 
			if not IsValid(self) then timer.Stop("speedSpell" .. self:EntIndex()) return end
				
			self:GetPhysicsObject():SetVelocity(vector * 99999)
		end)
	
		local tab = hp_mstick.GetMagic()
		local mag = tab[self:GetNWFloat("SpellType")]
		
		if not self:GetNWBool("SpellNoDraw") then
			local color = self:GetNWVector("SpellColor")
			util.SpriteTrail(self, 0, Color(color.x, color.y, color.z), 1, 50, 0.5, 0.3, 5, "trails/laser.vmt")
			
			local owner = self:GetOwner()
			
			if IsValid(owner) then
				owner:SetNWVector("SpriteColorHP", color)
			end
		end
		
		self:SetNWString("SpellName", mag.name)
	end)
	
	self:SetModel("models/props_junk/PopCan01a.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:DrawShadow(false)
	
	local phys = self:GetPhysicsObject()
	
	if IsValid(phys) then phys:SetMass(1) end
end

function ENT:Think()
	if CLIENT and self:GetNWBool("makesuperstuff") and self.STORM_brightness then
		if self.STORM_brightness > 0 then self.STORM_brightness = self.STORM_brightness - 0.01 end
	end
	
	if self:GetNWBool("SpellShake") and SERVER then
		util.ScreenShake(self:GetPos(), 30, 30, 0.1, 6000)
	end
end

function ENT:OnRemove()
	if CLIENT then self.Emitter:Finish() end
end

function ENT:PhysicsCollide(data, physobj)
	if CLIENT then return end
	
	local owner = self:GetOwner()
	
	if data.HitEntity:GetClass() == "entity_spell_fly" then
		local ef = EffectData()
		ef:SetOrigin(data.HitPos)
		ef:SetAngles(self:GetAngles())
		ef:SetStart(self:GetNWVector("SpellColor"))
		ef:SetScale(1)
		util.Effect("effect_ringhp", ef)
		
		util.ScreenShake(data.HitPos, 50, 50, 0.5, 3000)
	end
	
	self:EmitSound("ambient/energy/zap" .. math.random(1, 3) .. ".wav", 70, 200)
	
	local tab = hp_mstick.GetMagic()
	tab[self:GetNWFloat("SpellType")].attack(owner, data)
	
	local col = self:GetNWVector("SpellColor")
	
	if not self:GetNWBool("SpellNoSparks") then
		local R = tostring(col.x) .. " "
		local G = tostring(col.y) .. " "
		local B = tostring(col.z)
		
		local tes = ents.Create("point_tesla")
		tes:SetPos(data.HitPos)
		tes:SetKeyValue("thick_min", "0.05")
		tes:SetKeyValue("thick_max", "0.2")
		tes:SetKeyValue("lifetime_min", "0.1")
		tes:SetKeyValue("lifetime_max", "0.5")
		tes:SetKeyValue("interval_min", "0.2")
		tes:SetKeyValue("interval_max", "1")
		tes:SetKeyValue("beamcount_min", "5")
		tes:SetKeyValue("beamcount_max", "10")
		tes:SetKeyValue("m_flRadius", "40")
		tes:SetKeyValue("texture", "effects/laser1.vmt")
		tes:SetKeyValue("m_Color", R .. G .. B)
		tes:Spawn()
		tes:Fire("DoSpark", "1", 0.01)
		
		timer.Simple(0.1, function() if IsValid(tes) then tes:Remove() end end)
	end
	
	self:Remove()
end