--Wheehehehehehe

starty = 0
endy = 0

require("dfunc")

function OnDutyCompleted()
	endy = 1
end

function OnDutyStarted()	
	starty = 1
end

while 1 == 1 do
   yield("/wait 5")
   if getRandomNumber(1,10) == 1 then
	yield("/bmrai on")
   end
   if starty == 1 then
	while starty > 0 do
	yield("/zrotation Auto")
	yield("/mount")
	yield("/vbmai on")
	yield("/bmrai on")
	yield("/bmrai followtarget on")
	yield("/bmrai followoutofcombat on")
	yield("/bmrai setpresetname FRENRIDER")
	yield("/wait 1")
	yield("/ad start")
	yield("/echo starty")
	starty = starty - 0.1
	end 
   end
   if endy == 1 then
	fart = 1
	while fart == 1 do
		if Svc.Condition[34] == false then fart = 0 end
		yield("/echo endy")
		yield("/wait 1")
	end
	yield("/qst start")
	endy = 0
   end
end