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
        --yield("/bmrai setpresetname FRENRIDER")
        yield("/bmrai setpresetname Questionable - Quest Battles")
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
				yield("/qst start")
				yield("/qst reload")
				togglecounter = 0
			end
			if togglecounter > 2 then
				yield("/send KEY_1")
			end
		end
		if math.abs(GetPlayerRawXPos() - hehex) > 0.5 then
			togglecounter = 0
		end
		
		hehex = GetPlayerRawXPos()
		hehey = GetPlayerRawYPos()
		hehez = GetPlayerRawZPos()
    end
--	if Player.Job.Level > 18 then --make sure we not near training dummy stuff near start of msq
--		yield("/send KEY_1")
--	end
    yield("/wait 10")
end