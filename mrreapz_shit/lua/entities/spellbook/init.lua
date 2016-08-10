AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

util.AddNetworkString( "mrreapz_learn_spell" )
util.AddNetworkString( "mrreapz_failed" )
util.AddNetworkString( "mrreapz_learned" )

function ENT:Initialize()
	self:SetModel("models/props_lab/bindergreen.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use(activator, caller)
	local config = mrreap_config[spell]
	if config == nil then
		caller:SendLua('notification.AddLegacy("MrReapz broke something in the config.", NOTIFY_ERROR)')
		return
	end

	local level = caller:getLevel()

	if (config.minimum_level >= level) then
		if mrreapz_spellbook_data[caller:SteamID()] then
			mrreapz_spellbook_data[caller:SteamID()] = {[spell] = true}
		else
			if data[spell] ~= nil then
				caller:SendLua('notification.AddLegacy("You already have this spellbook.", NOTIFY_ERROR)')
			else
				mrreapz_spellbook_data[caller:SteamID()][spell] = true  
			end
		end
	end

    return
end

function ENT:Think()

end
