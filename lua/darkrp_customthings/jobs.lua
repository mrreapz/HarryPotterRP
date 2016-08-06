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

TEAM_GRYFFINDOR = DarkRP.createJob("Gryffindor Student", {
    color = Color(196, 45, 45, 255),
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

TEAM_SLYTHERIN = DarkRP.createJob("Slytherin Student", {
    color = Color(33, 203, 55, 255),
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

TEAM_HUFFLEPUFF = DarkRP.createJob("Hufflepuff Student", {
    color = Color(255, 213, 0, 255),
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

TEAM_RAVENCLAW = DarkRP.createJob("Ravenclaw Student", {
    color = Color(0, 119, 225, 255),
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

TEAM_HEADMASTER = DarkRP.createJob("Headmaster", {
    color = Color(47, 79, 79, 255),
    model = {"models/player/dumbledore.mdl"},
    description = [[The Headmaster of Hogwarts. Can sack Teachers with valid concerns. Controls the wage of the teachers.]],
    weapons = {"weapon_elderwand", "keys", "arrest_stick", "unarrest_stick"},
    command = "Headmaster",
    max = 1,
    salary = 750,
    admin = 0,
    vote = false,
    hasLicense = false,
	category = "Teachers",
})

TEAM_NURSE = DarkRP.createJob("Nurse", {
    color = Color(47, 79, 79, 255),
    model = "models/player/kleiner.mdl",
    description = [[Madam Pomfree. A nurse who can heal any students.]],
    weapons = {"med_kit", "weapon_advancedwand"},
    command = "Nurse",
    max = 2,
    salary = 250,
    admin = 0,
    vote = false,
    hasLicense = false,
    medic = true,
    category = "Teachers",
})

TEAM_SNAPE = DarkRP.createJob("DADA Teacher", {
   color = Color(255, 255, 255, 255),
   model = {"models/player/naruto/mcgonalpm/snapev4.mdl"},
   description = [[There will be no foolish wand-waving or silly incantations in this class.]],
   weapons = {"weapon_mindstick", "keys"},
   command = "DADA Teacher",
   max = 1,
   salary = 250,
   admin = 0,
   vote = false,
   hasLicense = false,
   medic = false,
   chief = false,
   mayor = false,
   hobo = false,
   cook = false,
   category = "Teachers",
})

GAMEMODE.DefaultTeam = TEAM_UNSORTED

GAMEMODE.CivilProtection = {
	[TEAM_POLICE] = false,
	[TEAM_CHIEF] = false,
	[TEAM_MAYOR] = false,
}

DarkRP.addHitmanTeam(TEAM_MOB)
