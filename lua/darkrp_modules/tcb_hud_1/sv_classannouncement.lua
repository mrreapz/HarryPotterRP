math.randomseed(os.time())

house = {
	slytherin = "Slytherin",
	gryffindor = "Gryffindor",
	hufflepuff = "Hufflepuff",
	ravenclaw = "Ravenclaw"
}

class = {}

class[0] = "Defense Against the Dark Arts"
class[1] = "Herbology"
class[2] = "Potions"
class[3] = "Transfiguration"
class[4] = "Hagrid's 'Class'"
class[5] = "Astronomy"

totalClasses = 6 --classes are 0 based, meaning this number will be 1 more than the last class index

houseClass = {}
houseClass[house.slytherin] = ""
houseClass[house.gryffindor] = ""
houseClass[house.hufflepuff] = ""
houseClass[house.ravenclaw] = ""

local classDuration = 30

timer.Create( "ClassTime", classDuration, 0, function()
	if (true) then
		local newClass1 = math.random(0,totalClasses - 1)
		local newClass2 = math.random(0,totalClasses - 1)
		while (newClass1 == newClass2) do
			newClass2 = math.random(0,totalClasses - 1)
		end

		local a = {}

	    a[0] = house.slytherin
		a[1] = house.gryffindor
		a[2] = house.hufflepuff
		a[3] = house.ravenclaw

	    for i = 0, 3
		do
            local j = randint( 0, i )

            -- Swap the elements at positions i and j.
            local temp = a[i]
            a[i] = a[j]
            a[j] = temp
			i++
        end

		houseClass[a[0]] = newClass1 
		houseClass[a[1]] = newClass1 
		houseClass[a[2]] = newClass2 
		houseClass[a[3]] = newClass2 

		
		for k,v in pairs(player.GetAll()) do
			local currentJob = v:getDarkRPVar("job")

			if currentJob == "Slytherin Student" then
				v:SetNWString("currentClass", class[newClass1])
				
			elseif currentJob == "Ravenclaw Student" then
				v:SetNWString("currentClass", class[newClass1])

			elseif currentJob == "Hufflepuff Student" then
				v:SetNWString("currentClass", class[newClass2])

			elseif currentJob == "Gryffindor Student" then 
				v:SetNWString("currentClass", class[newClass2])

			else 
				v:SetNWString("currentClass", "No Classes")

			end

			DarkRP.notify(v,0,4,"Class is over, please make your way to your next class")			
		end
	end
end)