math.randomseed(os.time())

local classDuration = 7 * 60

house = {
	slytherin = "Slytherin",
	gryffindor = "Gryffindor",
	hufflepuff = "Hufflepuff",
	ravenclaw = "Ravenclaw"
}

class = {}

class[1] = "Defense Against the Dark Arts"
class[2] = "Herbology"
class[3] = "Potions"
class[4] = "Transfiguration"
class[5] = "Hagrid's 'Class'"
class[6] = "Astronomy"

local totalClasses = 6

houseClass = {
	house.slytherin = "",
	house.gryffindor = "",
	house.hufflepuff = "",
	house.ravenclaw = "",
}

timer.Create( "ClassTime", classDuration, 0, function()
	if (true) then
		for k,v in pairs(player.GetAll()) do
			local newClass1 = math.random(1,totalClasses)
			local newClass2 = math.random(1,totalClasses)
			while (newClass1 == newClass2) do
				newClass2 = math.random(1,totalClasses)
			end
			
			--currentClassMessage = house.ravenclaw + " : " + class[newClass1] + "\n"
			--currentClassMessage += house.gryffindor + " : " + class[newClass1] + "\n"
			--currentClassMessage += house.hufflepuff + " : " + class[newClass2] + "\n"
			--currentClassMessage += house.slytherin + " : " + class[newClass2] + "\n"

			houseClass[house.slytherin] = class[newClass1]
			houseClass[house.gryffindor] = class[newClass2]
			houseClass[house.hufflepuff] = class[newClass1]
			houseClass[house.ravenclaw] = class[newClass2]

			DarkRP.notify(v,0,4,"Class is over, please make your way to your next class")
		end
	end
end)