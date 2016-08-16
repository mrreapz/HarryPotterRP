mrreapz_config = {}

hook.Add("loadCustomDarkRPItems", "mrreapz_spellbooks", function()
	mrreapz_config = {
		-- MAKE SURE THAT ALL OF THE SPELL NAMES ARE LOWERCASE!
		["rictusempra"] = {
			spellbook_price = 420,
			minimum_level = 1,
			job_that_sells_it = TEAM_CITIZEN
		}
	}

	DarkRP.createCategory{
		name = "Spellbooks",
		categorises = "entities",
		startExpanded = true,
		color = Color(0, 107, 0, 255),
		sortOrder = 0,
	}

	for k, v in pairs(mrreapz_config) do
		print("Creating spellbook '" .. k .. "'")
		DarkRP.createEntity((k:gsub("^%l", string.upper)), {
			ent = "spellbook",
			model = "models/props_lab/bindergreen.mdl",
			price = v.spellbook_price,
			max = 5,
			cmd = "buyspellbook_" .. k,
			allowed = {TEAM_CITIZEN},
		    spawn = function(ply, tr, tblEnt)
				local ent = ents.Create("spellbook")
				local tr = ply:GetEyeTrace()
				local hitpos = tr.HitPos
				if (hitpos - ply:EyePos()):Length() > 100 then
					hitpos = ply:EyePos() + (tr.Normal * 100);
				end
				ent:SetPos( hitpos )
				ent:Spawn()
				ent:Activate()
				ent.spell = k
				return ent
			end--,
		    --category = "Spellbooks",
		})
	end
end)
