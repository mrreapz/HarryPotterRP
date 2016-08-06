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
TEAM_UNSORTED = DarkRP.createJob("Unsorted", {
    color = Color(47, 79, 79, 255),
    model = {"models/player/lordsaw_fps/2serdaiglev1.mdl"},
    description = [[Unsorted. Go to the sorting hat to get sorted into a house.]],
    weapons = {""},
    command = "Unsorted",
    max = 50,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
	category = "Unsorted",
})

TEAM_STUDENTGRYFFINDORMALE = DarkRP.createJob("Gryffindor Male Student", {
    color = Color(196, 45, 45, 255),
    model = {"models/player/lordsaw_fps/2serdaiglev1.mdl", "models/player/lordsaw_fps/1poufsouflev1.mdl", "models/player/lordsaw_fps/2poufsouflev1_lod.mdl", "models/player/lordsaw_fps/3poufsouflev1_lod.mdl"},
    description = [[Gryffindor Male Student.]],
    weapons = {""},
    command = "Gryffindor Male Student",
    max = 50,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
	category = "Gryffindor",
})

TEAM_STUDENTGRYFFINDORFEMALE = DarkRP.createJob("Gryffindor Female Student", {
    color = Color(47, 79, 79, 255),
    model = {"models/player/lordsaw_fps/1serdaiglev1_lod.mdl", "models/player/lordsaw_fps/4poufsouflegirl_lod.mdl", "models/player/lordsaw_fps/4serdaiglegirl_lod.mdl"},
    description = [[Gryffindor Female Student.]],
    weapons = {""},
    command = "Gryffindor Female Student",
    max = 50, 
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
	category = "Gryffindor",
})

TEAM_STUDENTSLYTHERINMALE = DarkRP.createJob("Slytherin Male Student", {
    color = Color(47, 79, 79, 255),
    model = {"models/player/lordsaw_fps/2serdaiglev1.mdl", "models/player/lordsaw_fps/1poufsouflev1.mdl", "models/player/lordsaw_fps/2poufsouflev1_lod.mdl", "models/player/lordsaw_fps/3poufsouflev1_lod.mdl"},
    description = [[Slytherin Male Student.]],
    weapons = {""},
    command = "Slytherin Male Student",
    max = 50,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
	category = "Slytherin",
})

TEAM_STUDENTSLYTHERINFEMALE = DarkRP.createJob("Slytherin Female Student", {
    color = Color(47, 79, 79, 255),
    model = {"models/player/lordsaw_fps/1serdaiglev1_lod.mdl", "models/player/lordsaw_fps/4poufsouflegirl_lod.mdl", "models/player/lordsaw_fps/4serdaiglegirl_lod.mdl"},
    description = [[Slytherin Female Student.]],
    weapons = {""},
    command = "Slytherin Female Student",
    max = 50,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
	category = "Slytherin",
})

TEAM_STUDENTHUFFLEPUFFMALE = DarkRP.createJob("Hufflepuff Male Student", {
    color = Color(47, 79, 79, 255),
    model = {"models/player/lordsaw_fps/2serdaiglev1.mdl", "models/player/lordsaw_fps/1poufsouflev1.mdl", "models/player/lordsaw_fps/2poufsouflev1_lod.mdl", "models/player/lordsaw_fps/3poufsouflev1_lod.mdl"},
    description = [[Hufflepuff Male Student.]],
    weapons = {""},
    command = "Hufflepuff Male Student",
    max = 50,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
	category = "Hufflepuff",
})

TEAM_STUDENTHUFFLEPUFFFEMALE = DarkRP.createJob("Hufflepuff Female Student", {
    color = Color(47, 79, 79, 255),
    model = {"models/player/lordsaw_fps/1serdaiglev1_lod.mdl", "models/player/lordsaw_fps/4poufsouflegirl_lod.mdl", "models/player/lordsaw_fps/4serdaiglegirl_lod.mdl"},
    description = [[Hufflepuff Female Student.]],
    weapons = {""},
    command = "Hufflepuff Female Student",
    max = 50,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
	category = "Hufflepuff",
})

TEAM_STUDENTRAVENCLAWMALE= DarkRP.createJob("Ravenclaw Male Student", {
    color = Color(47, 79, 79, 255),
    model = {"models/player/lordsaw_fps/2serdaiglev1.mdl", "models/player/lordsaw_fps/1poufsouflev1.mdl", "models/player/lordsaw_fps/2poufsouflev1_lod.mdl", "models/player/lordsaw_fps/3poufsouflev1_lod.mdl"},
    description = [[Ravenclaw Male Student.]],
    weapons = {""},
    command = "Ravenclaw Male Student",
    max = 50,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
	category = "Ravenclaw",
})

TEAM_STUDENTRAVENCLAWFEMALE= DarkRP.createJob("Ravenclaw Female Student", {
    color = Color(47, 79, 79, 255),
    model = {"models/player/lordsaw_fps/1serdaiglev1_lod.mdl", "models/player/lordsaw_fps/4poufsouflegirl_lod.mdl", "models/player/lordsaw_fps/4serdaiglegirl_lod.mdl"},
    description = [[Ravenclaw Female Student.]],
    weapons = {""},
    command = "Ravenclaw Female Student",
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










GAMEMODE.DefaultTeam = TEAM_UNSORTED






GAMEMODE.CivilProtection = {
	[TEAM_POLICE] = false,
	[TEAM_CHIEF] = false,
	[TEAM_MAYOR] = false,
}




DarkRP.addHitmanTeam(TEAM_MOB)
