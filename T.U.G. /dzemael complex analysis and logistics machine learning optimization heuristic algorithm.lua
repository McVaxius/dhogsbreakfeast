require("dfunc")

if Svc.ClientState.TerritoryType == 1330 then
	goat = "fucker"

	goatfucker = 0

	while goat == "fucker" do
		if Svc.ClientState.TerritoryType == 1330 and goatfucker > 3 and Svc.Condition[26] == false then
		    yield("/echo my dist to final boss -> "..mydistto(79,-39,-170))
			if mydistto(79,-39,-170) > 35 then
				yield("/vnav moveto 79 -39 -170")
			end
			goatfucker = 0
		end
		if Svc.ClientState.TerritoryType == 1330 then goatfucker = goatfucker + 1 end
		yield("/wait 5")
	end
end