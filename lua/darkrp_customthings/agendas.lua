--[[---------------------------------------------------------------------------
DarkRP Agenda's
---------------------------------------------------------------------------
Agenda's can be set by the agenda manager and read by both the agenda manager and the other teams connected to it.


HOW TO MAKE AN AGENDA:
AddAgenda(Title of the agenda, Manager (who edits it), {Listeners (the ones who just see and follow the agenda)})
---------------------------------------------------------------------------]]
-- Example: AddAgenda("Gangster's agenda", TEAM_MOB, {TEAM_GANG})
-- Example: AddAgenda("Police agenda", TEAM_MAYOR, {TEAM_CHIEF, TEAM_POLICE})


AddAgenda("Gryffindor Agenda", TEAM_GRYFFINDOR, {TEAM_GRYFFINDOR})
AddAgenda("Slytherin Agenda", TEAM_SLYTHERIN, {TEAM_SLYTHERIN})
AddAgenda("Hufflepuff Agenda", TEAM_HUFFLEPUFF, {TEAM_HUFFLEPUFF})
AddAgenda("Ravenclaw Agenda", TEAM_RAVENCLAW, {TEAM_RAVENCLAW})
AddAgenda("Hogwarts Agenda", TEAM_HEADMASTER, {TEAM_GRYFFINDOR, TEAM_SLYTHERIN, TEAM_HUFFLEPUFF, TEAM_RAVENCLAW, TEAMNURSE})
