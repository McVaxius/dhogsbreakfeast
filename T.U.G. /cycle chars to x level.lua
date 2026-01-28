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

yield("/wait 15")

for i=1,#the_goats do
	if GetCharacterName(true) == the_goats[i] and i < #the_goats then
		yield("/ays relog "..the_goats[i+1])

		while GetCharacterName(true) ~= the_goats[i+1] do
			yield("/echo Load -> "..the_goats[i+1])
			--yield("/ays relog " ..the_goats[i+1])
			yield("/wait 3")

			yield("/waitaddon _ActionBar<maxwait 600>")
			yield("/wait 5")
		end
		
		--begin AD again
		yield("/bmrai on")
		yield("/bmrai followtarget on")
		yield("/bmrai followoutofcombat on")
		yield("/bmrai setpresetname FRENRIDER")
		yield("/lifestream stop")
		
		--/autoduty run DutyMode TerritoryTypeInteger LoopTimesInteger [BareModeBool]
		
		--check my level and sun sastasha if we are under  35
		gyatlevel = GetLevel() --get our level and assign it to an easy to remember variable
		if gyatlevel < 35 then IPC.AutoDuty.SetConfig("StopLevelInt", "35") end
		if gyatlevel > 34 and gyatlevel < 44 then IPC.AutoDuty.SetConfig("StopLevelInt", "44") end
		if gyatlevel > 43 and gyatlevel < 100 then IPC.AutoDuty.SetConfig("StopLevelInt", "47") end
		if gyatlevel < 35 then yield("/ad run Support 1036 20 false") end --sastasha
		if gyatlevel > 34 and gyatlevel < 44 then yield("/ad run Support 1267 20 false") end --sunken temple of qarn
		if gyatlevel > 43 then yield("/ad run Support 1330 20 false") end --dzemael
		yield("/snd stop all")
--		return --end this for loop
	end
	if GetCharacterName(true) == the_goats[i] and i == #the_goats then
		yield("/ays m e")
--		return --end this for loop
		yield("/snd stop all")
	end
end