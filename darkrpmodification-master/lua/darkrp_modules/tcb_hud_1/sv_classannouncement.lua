math.randomseed(os.time())

class = {}

class[0] = "DADA"
class[1] = "Herbology"
class[2] = "Potions"
class[3] = "Transfiguration"
class[4] = "Hagrid's 'Class'"
class[5] = "Charms"
class[6] = "Wizardry"
class[7] = "Break Time!"

totalClasses = 8 --classes are 0 based, meaning this number will be 1 more than the last class index

TEAM_GRYFFINDOR = GetGlobalInt("TEAM_GRYFFINDOR")
TEAM_SLYTHERIN = GetGlobalInt("TEAM_SLYTHERIN")
TEAM_HUFFLEPUFF = GetGlobalInt("TEAM_HUFFLEPUFF")
TEAM_RAVENCLAW = GetGlobalInt("TEAM_RAVENCLAW")

professor = {}
professor[class[0]] = GetGlobalInt("TEAM_DADAPROFESSOR")
professor[class[1]] = GetGlobalInt("TEAM_CHARMSPROFESSOR")
professor[class[2]] = GetGlobalInt("TEAM_POTIONSPROFESSOR")
professor[class[3]] = GetGlobalInt("TEAM_TRANSFIGPROFESSOR")
professor[class[4]] = GetGlobalInt("TEAM_GAMEKEEPER")
professor[class[5]] = GetGlobalInt("TEAM_CHARMSPROFESSOR")
professor[class[6]] = GetGlobalInt("TEAM_WIZARDRYPROFESSOR")
professor[class[7]] = nil

houseClass = {}
houseClass[GetGlobalInt("TEAM_SLYTHERIN")] = ""
houseClass[GetGlobalInt("TEAM_GRYFFINDOR")] = ""
houseClass[GetGlobalInt("TEAM_HUFFLEPUFF")] = ""
houseClass[GetGlobalInt("TEAM_RAVENCLAW")] = ""

local classDuration = 30

local function GetRandomHouseArray()
	local a = {}

	a[0] = TEAM_SLYTHERIN
	a[1] = TEAM_GRYFFINDOR
	a[2] = TEAM_HUFFLEPUFF
	a[3] = TEAM_RAVENCLAW

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

timer.Create( "ClassTime", classDuration, 0, function()
	local newClass1 = math.random(0,totalClasses - 1)
	local newClass2 = math.random(0,totalClasses - 1)
	while (newClass1 == newClass2) 
	do
		newClass2 = math.random(0,totalClasses - 1)
	end

	a = GetRandomHouseArray()

	houseClass[a[0]] = class[newClass1] 
	houseClass[a[1]] = class[newClass1] 
	houseClass[a[2]] = class[newClass2] 
	houseClass[a[3]] = class[newClass2] 
	
	for k,v in pairs(player.GetAll()) do
		local currentJob = v:Team()

		if currentJob == TEAM_SLYTHERIN then
			v:SetNWString("currentClass", houseClass[TEAM_SLYTHERIN])
			
		elseif currentJob == TEAM_GRYFFINDOR then
			v:SetNWString("currentClass", houseClass[TEAM_GRYFFINDOR])

		elseif currentJob == TEAM_HUFFLEPUFF then
			v:SetNWString("currentClass", houseClass[TEAM_HUFFLEPUFF])

		elseif currentJob == TEAM_RAVENCLAW then 
			v:SetNWString("currentClass", houseClass[TEAM_RAVENCLAW])

		elseif currentJob == professor[class[newClass1]] then
			v:SetNwString("currentClass", "Your class has begun: " .. class[newClass1])

		elseif currentJob == professor[class[newClass2]] then
			v:SetNwString("currentClass", "Your class has begun: " .. class[newClass2])

		else 
			--print("current : ".. currentJob .."\n" ..
			--	"g: " .. TEAM_GRYFFINDOR .. "\n"..
			--	"s: " .. TEAM_SLYTHERIN .. "\n"..
			--	"h: " .. TEAM_HUFFLEPUFF .. "\n"..
			--	"r: " .. TEAM_RAVENCLAW .. "\n");
			v:SetNWString("currentClass", "No Classes")

		end

		DarkRP.notify(v,0,4,"Class is over, please make your way to your next class")			
	end
end)
