--bad questionable helper
require("dfunc")
hehe = "heehee"
while hehe == "heehee" do
    yield("/bmrai on")
    if Svc.Condition[34] ~= nil and Svc.Condition[34] == true then
        yield("/bmrai setpresetname Autoduty Passive")
        yield("/rotation auto")
    end
    if Svc.Condition[34] ~= nil and Svc.Condition[34] == false then
        yield("/bmrai setpresetname FRENRIDER")
        yield("/rotation cancel")
    end
	if Player.Job.Level > 18 then --make sure we not near training dummy stuff near start of msq
		yield("/send KEY_1")
	end
    yield("/wait 10")
end