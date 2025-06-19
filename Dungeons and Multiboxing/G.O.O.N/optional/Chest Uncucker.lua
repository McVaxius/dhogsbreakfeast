--for running passively while AD is doing its thing
--pandora -> loot chests on

cucked_by_chests = "often"

while cucked_by_chests == "often" do
	--safe check ifs
	if Player.Available then
	if type(Svc.Condition[34]) == "boolean" and type(Svc.Condition[26]) == "boolean" and type(Svc.Condition[4]) == "boolean" then
	    if Svc.Condition[34] == false then
				yield("/ad resume")
		end
		if Svc.Condition[26] == false and Svc.Condition[34] == true then
		--if Svc.Condition[34] == true then
			zist = GetDistanceToObject("Treasure Coffer")
			if zist < 20 and zist > 0.1 then
				yield("/ad pause")
				yield("/vnavmesh moveto "..GetObjectRawXPos("Treasure Coffer").." "..GetObjectRawYPos("Treasure Coffer").." "..GetObjectRawZPos("Treasure Coffer"))
				yield("/echo attempting to uncuck a chest....")
				yield("/wait 5")
				yield("/ad resume")
				yield("/wait 0.5")
			end
		end
	--safe check ends
	end
	end
	--
	yield("/wait 0.5") --script loop so we dont infinite cpu burn
end


--lapis cucknalis 1097
