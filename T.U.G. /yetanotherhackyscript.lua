--bad questionable helper
require("dfunc")
hehe = "heehee"

hehex = GetPlayerRawXPos()
hehey = GetPlayerRawYPos()
hehez = GetPlayerRawZPos()
togglecounter = 0

while hehe == "heehee" do
    yield("/bmrai on")
    if Svc.Condition[34] ~= nil and Svc.Condition[34] == true then
        yield("/bmrai setpresetname Autoduty Passive")
        yield("/rotation auto")
    end
    if Svc.Condition[34] ~= nil and Svc.Condition[34] == false then
        yield("/bmrai setpresetname FRENRIDER")
        yield("/rotation cancel")
		
		--debug
		--yield("/echo GetPlayerRawXPos() -> "..GetPlayerRawXPos())
		--yield("/echo              hehex -> "..hehex)
		--yield("/echo math.abs(GetPlayerRawXPos() - hehex) -> "..math.abs(GetPlayerRawXPos() - hehex))
		--yield("/echo math.abs(GetPlayerRawYPos() - hehey) -> "..math.abs(GetPlayerRawYPos() - hehey))
		--yield("/echo math.abs(GetPlayerRawZPos() - hehez) -> "..math.abs(GetPlayerRawZPos() - hehez))
		if math.abs(GetPlayerRawXPos() - hehex) < 0.5 and math.abs(GetPlayerRawYPos() - hehey) < 0.5 and math.abs(GetPlayerRawZPos() - hehez) < 0.5 then
			togglecounter = togglecounter + 1
			if togglecounter > 5 then
				yield("/echo restarting QST")
				yield("/interact")
				yield("/send NUMPAD0")
				yield("/qst stop")
				yield("/wait 3")
				yield("/interact")
				yield("/send NUMPAD0")
				yield("/qst start")
				yield("/wait 2")
				yield("/interact")
				yield("/send NUMPAD0")
				yield("/wait 10")
				yield("/send ESCAPE")
				togglecounter = 0
			end
			if togglecounter > 54563456 then
				yield("/echo it took too long, we are going to try to reset questionable")
				togglecounter = 0
				yield("/xldisableplugin Questionable")
				yield("/wait 10")
				yield("/xlenableplugin Questionable")
			end
		end
		if math.abs(GetPlayerRawXPos() - hehex) > 0.5 then
			togglecounter = 0
		end
		
		hehex = GetPlayerRawXPos()
		hehey = GetPlayerRawYPos()
		hehez = GetPlayerRawZPos()
    end
	if Player.Job.Level > 18 then --make sure we not near training dummy stuff near start of msq
		yield("/send KEY_1")
	end
    yield("/wait 10")
end