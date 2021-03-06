include("weapon_hpmstick.lua")

SWEP.PrintName = "Mind Wand"
SWEP.WandModel = "models/mstick/oldstick/w_oldstick.mdl"

SWEP.VElements = {
	["s"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 2.5, -13.5), size = { x = 0, y = 0 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["m"] = { type = "Model", model = SWEP.WandModel, bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 1.5, -9), angle = Angle(-165, 0, 0), size = Vector(0.82, 0.82, 0.82), color = Color(255, 255, 255, 255), surpresslightning = false, skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["m"] = { type = "Model", model = SWEP.WandModel, bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 1.557, -10), angle = Angle(180, 0, 0), size = Vector(0.82, 0.82, 0.82), color = Color(255, 255, 255, 255), surpresslightning = false, skin = 0, bodygroup = {} }
}