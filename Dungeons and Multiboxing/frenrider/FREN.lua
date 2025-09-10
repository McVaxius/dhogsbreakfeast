--party leader move to flag and combat along the way

require("dfunc")

imlazy = true
nemm = "Treasure Coffer"

while imlazy do
	yield("/wait 1")
	sidechest = mydistto(GetObjectRawXPos(nemm),GetObjectRawYPos(nemm),GetObjectRawZPos(nemm))
	sidechestlast = 0
	while sidechest > 0 and sidechest < 20 and Svc.Condition[26] == false do
		sidechest = mydistto(GetObjectRawXPos(nemm),GetObjectRawYPos(nemm),GetObjectRawZPos(nemm))
		if sidechestlast > 9999999999990 and sidechest == sidechestlast then
			if Svc.Condition[26] == false then
				yield("/vnav moveflag <flag>")
				yield("/wait 5")
			end
		end
		sidechestlast = sidechest
		print("we are in the while loop -> side chest -> "..sidechest)
		yield("/vnavmesh moveto "..GetObjectRawXPos(nemm).." "..GetObjectRawYPos(nemm).." "..GetObjectRawZPos(nemm))
		yield("/target \""..nemm.."\"")
		if sidechest < 5 then
			yield("/interact")
		end
		yield("/wait 1")
	end
	if Svc.Condition[26] == true then
		yield("/vnav stop")
	end
	if Svc.Condition[26] == false then
		yield("/vnav moveflag <flag>")
	end
	if Svc.Condition[34] == false then
		imlazy = false
	end
end