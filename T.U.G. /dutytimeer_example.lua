im_a_cuck = true
stop_gooning = 0
TAS = 0
duty_duration = 60 --in minutes - was testing decu

require("dfunc")

function OnDutyCompleted()
	stop_gooning = 1
	--math is hard as a rock
	if Svc.Condition[34] and Svc.Condition[26] == false then
		yield("/target Ultima")
	end
	TAS = (duty_duration * 60) - math.floor(InstancedContent.ContentTimeLeft)
end

while im_a_cuck do
    yield("/send KEY_1")  --this is here for UC. comment it out if your using something else
    yield("/wait 0.1")
	if stop_gooning == 1 then
		stop_gooning = 0
		TAS_mm_ss = secondsToMinutesString(TAS)
		yield("/echo Duty Completed in: -> "..TAS_mm_ss)
	end
end
