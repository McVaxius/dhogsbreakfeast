--dont worry about it
--just a stupid script to trigger a diff script at a specific time or general time

yield("/echo oh i can feel it lets goooo")
goats = "sexy"

while goats == "sexy" do
	if os.date("!*t").hour > 8 then
		goats = "clapped"
		yield("/pcraft run goon")
	end
	yield("/wait 5")
	yield("/echo oh i can feel it lets goooo -> "..os.date("!*t").hour..":"..os.date("!*t").min)
end