--party leader move to flag and combat along the way

imlazy = true

while imlazy do
	yield("/wait 1")
	if Svc.Condition[26] == true then
		yield("/vnav stop")
	end
	if Svc.Condition[26] == false then
		yield("/vnav moveflag <flag>")
	end
end