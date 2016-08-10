
math.randomseed(os.time())

class = {}

class[0] = "DAtDA"
class[1] = "Herbology"
class[2] = "Potions"
class[3] = "Transfiguration"
class[4] = "Hagrid's 'Class'"
class[5] = "Charms"
class[6] = "Wizardry"
class[7] = "Break Time!"

totalClasses = 8 --classes are 0 based, meaning this number will be 1 more than the last class index

professor = {}
houses = include("darkrp_customthings/jobs.lua")
professor[class[0]] = houses.TEAM_DADA
professor[class[1]] = houses.TEAM_CHARMSPROFESSOR
professor[class[2]] = houses.TEAM_POTIONSPROFESSOR
professor[class[3]] = houses.TEAM_TRANSFIGPROFESSOR
professor[class[4]] = houses.TEAM_GAMEKEEPER
professor[class[5]] = houses.TEAM_CHARMSPROFESSOR
professor[class[6]] = houses.TEAM_WIZARDRYPROFESSOR
professor[class[7]] = nil

houseClass = {}
houseClass[houses.TEAM_SLYTHERIN] = ""
houseClass[houses.TEAM_GRYFFINDOR] = ""
houseClass[houses.TEAM_HUFFLEPUFF] = ""
houseClass[houses.TEAM_RAVENCLAW] = ""

local classDuration = 30

timer.Create( "ClassTime", classDuration, 0, function()
	local newClass1 = math.random(0,totalClasses - 1)
	local newClass2 = math.random(0,totalClasses - 1)
	while (newClass1 == newClass2) 
	do
		newClass2 = math.random(0,totalClasses - 1)
	end

	a = GetRandomHouseArray()

	houseClass[a[0]] = newClass1 
	houseClass[a[1]] = newClass1 
	houseClass[a[2]] = newClass2 
	houseClass[a[3]] = newClass2 
	
	for k,v in pairs(player.GetAll()) do
		local currentJob = v:Team()

		if currentJob == houses.TEAM_SLYTHERIN then
			v:SetNWString("currentClass", houseClass[houses.TEAM_SLYTHERIN])
			
		elseif currentJob == houses.TEAM_GRYFFINDOR then
			v:SetNWString("currentClass", houseClass[houses.TEAM_GRYFFINDOR])

		elseif currentJob == houses.TEAM_HUFFLEPUFF then
			v:SetNWString("currentClass", houseClass[houses.TEAM_HUFFLEPUFF])

		elseif currentJob == houses.TEAM_RAVENCLAW then 
			v:SetNWString("currentClass", houseClass[houses.TEAM_RAVENCLAW])

		elseif currentJob == professor[class[newClass1]] then
			v:SetNwString("currentClass", "Your class has begun: " .. class[newClass1])

		elseif currentJob == professor[class[newClass2]] then
			v:SetNwString("currentClass", "Your class has begun: " .. class[newClass2])

		else 
			v:SetNWString("currentClass", "No Classes")

		end

		DarkRP.notify(v,0,4,"Class is over, please make your way to your next class")			
	end
end)

local function GetRandomHouseArray()
	local a = {}

	a[0] = houses.TEAM_SLYTHERIN
	a[1] = houses.TEAM_GRYFFINDOR
	a[2] = houses.TEAM_HUFFLEPUFF
	a[3] = houses.TEAM_RAVENCLAW

	for i = 0, 3
	do
		local j = math.random( 0, i )

		-- Swap the elements at positions i and j.
		local temp = a[i]
		a[i] = a[j]
		a[j] = temp
	end

	return a
end