--[[---------------------------------------------------------------------------
DarkRP custom jobs
---------------------------------------------------------------------------

This file contains your custom jobs.
This file should also contain jobs from DarkRP that you edited.

Note: If you want to edit a default DarkRP job, first disable it in darkrp_config/disabled_defaults.lua
	Once you've done that, copy and paste the job to this file and edit it.

The default jobs can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/jobrelated.lua

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomJobFields


Add jobs under the following line:
---------------------------------------------------------------------------]]

local defaultStudentGear = {"weapon_hpmstick", "keys"}

TEAM_UNSORTED = DarkRP.createJob("Unsorted", {
    color = Color(47, 79, 79, 255),
    model = {"models/player/lordsaw_fps/2serdaiglev1.mdl"},
    description = [[Unsorted. Go to the sorting hat to get sorted into a house.]],
    weapons = {""},
    command = "Unsorted",
    max = 50,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
	category = "Unsorted",
})
SetGlobalInt("TEAM_UNSORTED", TEAM_UNSORTED)

TEAM_GRYFFINDOR = DarkRP.createJob("Gryffindor Student", {
    color = Color(204,0,0,200),
    model = {"models/player/lordsaw_fps/2serdaiglev1.mdl", "models/player/lordsaw_fps/1poufsouflev1.mdl", "models/player/lordsaw_fps/2poufsouflev1_lod.mdl", "models/player/lordsaw_fps/3poufsouflev1_lod.mdl", "models/player/lordsaw_fps/1serdaiglev1_lod.mdl", "models/player/lordsaw_fps/4poufsouflegirl_lod.mdl", "models/player/lordsaw_fps/4serdaiglegirl_lod.mdl"},
    description = [[Gryffindor Student.]],
    weapons = defaultStudentGear,
    command = "Gryffindor Student",
    max = 50,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
	category = "Gryffindor",
})
SetGlobalInt("TEAM_GRYFFINDOR", TEAM_GRYFFINDOR)

TEAM_SLYTHERIN = DarkRP.createJob("Slytherin Student", {
    color = Color(0,153,0,200),
    model = {"models/player/lordsaw_fps/2serdaiglev1.mdl", "models/player/lordsaw_fps/1poufsouflev1.mdl", "models/player/lordsaw_fps/2poufsouflev1_lod.mdl", "models/player/lordsaw_fps/3poufsouflev1_lod.mdl", "models/player/lordsaw_fps/1serdaiglev1_lod.mdl", "models/player/lordsaw_fps/4poufsouflegirl_lod.mdl", "models/player/lordsaw_fps/4serdaiglegirl_lod.mdl"},
    description = [[Slytherin Student.]],
    weapons = defaultStudentGear,
    command = "Slytherin Student",
    max = 50,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
	category = "Slytherin",
})
SetGlobalInt("TEAM_SLYTHERIN", TEAM_SLYTHERIN)

TEAM_HUFFLEPUFF = DarkRP.createJob("Hufflepuff Student", {
    color = Color(204,163,0,200),
    model = {"models/player/lordsaw_fps/2serdaiglev1.mdl", "models/player/lordsaw_fps/1poufsouflev1.mdl", "models/player/lordsaw_fps/2poufsouflev1_lod.mdl", "models/player/lordsaw_fps/3poufsouflev1_lod.mdl", "models/player/lordsaw_fps/1serdaiglev1_lod.mdl", "models/player/lordsaw_fps/4poufsouflegirl_lod.mdl", "models/player/lordsaw_fps/4serdaiglegirl_lod.mdl"},
    description = [[Hufflepuff Student.]],
    weapons = defaultStudentGear,
    command = "Hufflepuff Student",
    max = 50,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
	category = "Hufflepuff",
})
SetGlobalInt("TEAM_HUFFLEPUFF", TEAM_HUFFLEPUFF)

TEAM_RAVENCLAW = DarkRP.createJob("Ravenclaw Student", {
    color = Color(51,51,255,200),
    model = {"models/player/lordsaw_fps/2serdaiglev1.mdl", "models/player/lordsaw_fps/1poufsouflev1.mdl", "models/player/lordsaw_fps/2poufsouflev1_lod.mdl", "models/player/lordsaw_fps/3poufsouflev1_lod.mdl", "models/player/lordsaw_fps/1serdaiglev1_lod.mdl", "models/player/lordsaw_fps/4poufsouflegirl_lod.mdl", "models/player/lordsaw_fps/4serdaiglegirl_lod.mdl"},
    description = [[Ravenclaw Student.]],
    weapons = defaultStudentGear,
    command = "Ravenclaw Student",
    max = 50,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
	category = "Ravenclaw",
})
SetGlobalInt("TEAM_RAVENCLAW", TEAM_RAVENCLAW)

TEAM_HEADMASTER = DarkRP.createJob("Headmaster", {
    color = Color(47, 79, 79, 255),
    model = {"models/player/dumbledore.mdl"},
    description = [[Professor Dumbledore. The Headmaster of Hogwarts. Can sack Teachers with valid concerns. Controls the wage of the teachers.]],
    weapons = {"weapon_elderwand", "keys", "slappers",},
    command = "Headmaster",
    max = 1,
    salary = 750,
    admin = 0,
    vote = false,
    hasLicense = false,
	category = "Teachers",
})
SetGlobalInt("TEAM_HEADMASTER", TEAM_HEADMASTER)

TEAM_NURSE = DarkRP.createJob("Nurse", {
    color = Color(47, 79, 79, 255),
    model = "models/player/kleiner.mdl",
    description = [[Madam Pomfree. A nurse who can heal any students.]],
    weapons = {"med_kit", "weapon_mindstick"},
    command = "Nurse",
    max = 2,
    salary = 250,
    admin = 0,
    vote = false,
    hasLicense = false,
    medic = true,
    category = "Teachers",
})
SetGlobalInt("TEAM_NURSE", TEAM_NURSE)

TEAM_DADAPROFESSOR = DarkRP.createJob("DADA Professor", {
   color = Color(255, 255, 255, 255),
   model = {"models/player/naruto/mcgonalpm/snapev4.mdl"},
   description = [[There will be no foolish wand-waving or silly incantations in this class.]],
   weapons = {"weapon_mindstick", "keys"},
   command = "DADA Professor",
   max = 1,
   salary = 250,
   admin = 0,
   category = "Teachers",
})
SetGlobalInt("TEAM_DADAPROFESSOR", TEAM_DADAPROFESSOR)

TEAM_CHARMSPROFESSOR = DarkRP.createJob("Charms Professor", {
   color = Color(255, 255, 255, 255),
   model = {"models/player/naruto/mcgonalpm/snapev4.mdl"},
   description = [[Swish and flick!]],
   weapons = {"weapon_mindstick", "keys"},
   command = "Charms Professor",
   max = 1,
   salary = 250,
   admin = 0,
   vote = false,
   hasLicense = false,
   category = "Teachers",
})
SetGlobalInt("TEAM_CHARMSPROFESSOR", TEAM_CHARMSPROFESSOR)

TEAM_TRANSFIGPROFESSOR = DarkRP.createJob("Transfigurations Professor", {
   color = Color(255, 255, 255, 255),
   model = {"models/player/naruto/mcgonalpm/snapev4.mdl"},
   description = [[Transfigurations Professor]],
   weapons = {"weapon_mindstick", "keys"},
   command = "Transfigurations Professor",
   max = 1,
   salary = 250,
   admin = 0,
   vote = false,
   hasLicense = false,
   category = "Teachers",
})
SetGlobalInt("TEAM_TRANSFIGPROFESSOR", TEAM_TRANSFIGPROFESSOR)

TEAM_POTIONSPROFESSOR = DarkRP.createJob("Potions Professor", {
   color = Color(255, 255, 255, 255),
   model = {"models/player/naruto/mcgonalpm/snapev4.mdl"},
   description = [[Potions Professor. Teach the students potions!]],
   weapons = {"weapon_mindstick", "keys"},
   command = "Potions Professor",
   max = 1,
   salary = 250,
   admin = 0,
   vote = false,
   hasLicense = false,
   category = "Teachers",
})
SetGlobalInt("TEAM_POTIONSPROFESSOR", TEAM_POTIONSPROFESSOR)

TEAM_GAMEKEEPER = DarkRP.createJob("Gamekeeper", {
   color = Color(255, 255, 255, 255),
   model = {"models/player/hagrid.mdl"},
   description = [[Hagrid. The Gamekeeper and Keeper of Keys and Grounds of Hogwarts.]],
   weapons = {"weapon_mindstick", "keys", "slappers"},
   command = "Gamekeeper",
   max = 1,
   salary = 250,
   admin = 0,
   vote = false,
   hasLicense = false,
   category = "Teachers",
})
SetGlobalInt("TEAM_GAMEKEEPER", TEAM_GAMEKEEPER)

TEAM_WIZARDRYPROFESSOR = DarkRP.createJob("Wizardry	Professor", {
   color = Color(255, 255, 255, 255),
   model = {"models/obese_male.mdl"},
   description = [[Wizardry Professor]],
   weapons = {"weapon_mindstick", "keys"},
   command = "Wizardry Professor",
   max = 1,
   salary = 250,
   admin = 0,
   vote = false,
   hasLicense = false,
   category = "Teachers",
})
SetGlobalInt("TEAM_WIZARDRYPROFESSOR", TEAM_WIZARDRYPROFESSOR)

TEAM_MUGGLEPROFESSOR = DarkRP.createJob("Muggle Studies Professor", {
   color = Color(255, 255, 255, 255),
   model = {"models/obese_male.mdl"},
   description = [[Muggle Studies Professor]],
   weapons = {"weapon_mindstick", "keys"},
   command = "Muggle Studies Professor",
   max = 1,
   salary = 250,
   admin = 0,
   vote = false,
   hasLicense = false,
   category = "Teachers",
})
SetGlobalInt("TEAM_MUGGLEPROFESSOR", TEAM_MUGGLEPROFESSOR)

TEAM_HERBOLOGYPROFESSOR = DarkRP.createJob("Herbology Professor", {
   color = Color(255, 255, 255, 255),
   model = {"models/obese_male.mdl"},
   description = [[Herbology Professor]],
   weapons = {"weapon_mindstick", "keys"},
   command = "Herbology Professor",
   max = 1,
   salary = 250,
   admin = 0,
   vote = false,
   hasLicense = false,
   category = "Teachers",
})
SetGlobalInt("TEAM_HERBOLOGYPROFESSOR", TEAM_HERBOLOGYPROFESSOR)

TEAM_ASTRONOMYPROFESSOR = DarkRP.createJob("Astronomy Professor", {
   color = Color(255, 255, 255, 255),
   model = {"models/obese_male.mdl"},
   description = [[Astronomy Professor]],
   weapons = {"weapon_mindstick", "keys"},
   command = "Astronomy Professor",
   max = 1,
   salary = 250,
   admin = 0,
   vote = false,
   hasLicense = false,
   category = "Teachers",
})
SetGlobalInt("TEAM_ASTRONOMYPROFESSOR", TEAM_ASTRONOMYPROFESSOR)

TEAM_QUIDDITCHCOACH = DarkRP.createJob("Quidditch Coach", {
   color = Color(255, 255, 255, 255),
   model = {"models/obese_male.mdl"},
   description = [[Quidditch Professor]],
   weapons = {"weapon_mindstick", "keys"},
   command = "Quiditch Coach",
   max = 1,
   salary = 250,
   admin = 0,
   vote = false,
   hasLicense = false,
   category = "Teachers",
})
SetGlobalInt("TEAM_QUIDDITCHCOACH", TEAM_QUIDDITCHCOACH)

GAMEMODE.DefaultTeam = TEAM_UNSORTED

GAMEMODE.CivilProtection = {
	[TEAM_POLICE] = false,
	[TEAM_CHIEF] = false,
	[TEAM_MAYOR] = false,
}

DarkRP.addHitmanTeam(TEAM_MOB)
