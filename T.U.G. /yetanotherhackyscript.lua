--bad questionable helper
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
	yield("/wait 10")
end