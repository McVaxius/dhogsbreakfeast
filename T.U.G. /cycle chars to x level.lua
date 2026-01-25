require("dfunc")

the_goats = {
"floop floop@Floopiorous",
"floop floopb@Floopiorous",
"floop floopc@Floopiorous",
"floop floopd@Floopiorous",
"floop floope@Floopiorous",
"floop floopf@Floopiorous",
}

--find out who we are on. and pick the next in list, unless we are at end of list in which case "/ays m e" to turn multi back on and cal it a day

for i=1,#the_goats do
	if GetCharacterName(true) == the_goats[i] and i < #the_goats then
		yield("/ays relog "..the_goats[i+1])

		while GetCharacterName(true) != the_goats[i] and i < #the_goats do
			yield("/echo Load -> "..the_goats[i+1])
			yield("/ays relog " ..the_goats[i+1])
			yield("/wait 3")

			yield("/waitaddon _ActionBar<maxwait 600>")
			yield("/wait 5")
		end
		
		--begin AD again
		yield("/bmrai on")
		yield("/bmrai followtarget on")
		yield("/bmrai followoutofcombat on")
		yield("/bmrai setpresetname FRENRIDER")
		
		--/autoduty run DutyMode TerritoryTypeInteger LoopTimesInteger [BareModeBool]
		
		--check my level and sun sastasha if we are under  35	
		if GetLevel() < 35 then yield("/ad run Support 1036 20 false") end --sastasha
		if GetLevel() > 34 then yield("/ad run Support 1267 20 false") end --sunken temple of qarn
		
		return --end this for loop
	end
	if GetCharacterName(true) == the_goats[i] and i == #the_goats then
		yield("/ays m e"
		return --end this for loop
	end
end