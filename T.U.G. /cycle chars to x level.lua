require("dfunc")

the_goats = {
"floop floopf@Floopiorous",
"floop floopf@Floopiorous",
"floop floopf@Floopiorous",
"floop floopf@Floopiorous",
"floop floopf@Floopiorous",
"floop floopf@Floopiorous",
"floop floopf@Floopiorous",
"floop floopf@Floopiorous",
"floop floopf@Floopiorous"
}

--find out who we are on. and pick the next in list, unless we are at end of list in which case "/ays m e" to turn multi back on and cal it a day

yield("/wait 15")
function do_it()
	--check my level and sun sastasha if we are under  35
	yield("/wait 3")
	--switch to highest level combat job if we aren't on it already.
	if are_we_dol() then
		yield("/equipjob "..job_short(which_cj()))
		yield("/echo Switching to "..job_short(which_cj()))
		yield("/wait 3")
	end
	yield("/wait 3")
	gyatlevel = GetLevel() --get our level and assign it to an easy to remember variable
	--check the quests and run them if not done - make sure they are in priority queue and set priority queue to not self delete
	questcheck = 666
	if gyatlevel > 31 then questcheck = 764 end --open qarn 764 "Braving new Depths"
	if gyatlevel > 34 then questcheck = 921 end --open cutters 921 "Dishonor before Death"
	if gyatlevel > 41 then --open dzemael shadows uncast 1128 1129 1130 lim grid ulda
		if GetFlamesGCRank() > 0 then questcheck = 1130 end
		if GetAddersGCRank() > 0 then questcheck = 1129 end
		if GetMaelstromGCRank() > 0 then questcheck = 1128 end
	end
	
	--now lets see if that quest is done.
	if questcheck ~= 666 then
		while Quests.IsQuestComplete(questcheck) == false do
			yield("/echo waiting for quest -> "..questcheck.." to finish")
			yield("/wait 5")
		end
	end
	
	--set the recursive script check level
	if gyatlevel < 35 then IPC.AutoDuty.SetConfig("StopLevelInt", "35") end
	if gyatlevel > 34 and gyatlevel < 44 and GetFlamesGCRank() == 0 then IPC.AutoDuty.SetConfig("StopLevelInt", "44") end
	if GetFlamesGCRank() > 0 then
		if gyatlevel > 34 and gyatlevel < 38 then IPC.AutoDuty.SetConfig("StopLevelInt", "38") end
		if gyatlevel > 37 and gyatlevel < 44 then IPC.AutoDuty.SetConfig("StopLevelInt", "44") end
	end
	if gyatlevel > 43 and gyatlevel < 100 then IPC.AutoDuty.SetConfig("StopLevelInt", "47") end
	--pick the duty now
	--if gyatlevel < 35 then yield("/ad run Support 1036 20 false") end --sastasha
	if gyatlevel < 35 then yield("/ad run Support 1245 20 false") end --halatali
	if gyatlevel > 34 and gyatlevel < 44 and GetFlamesGCRank() == 0 then yield("/ad run Support 1267 20 false") end --sunken temple of qarn
	if GetFlamesGCRank() > 0 then
		if gyatlevel > 34 and gyatlevel < 38 then yield("/ad run Support 1267 20 false") end --sunken temple of qarn
		if gyatlevel > 37 and gyatlevel < 44 then yield("/ad run Support 1303 20 false") end --cuckers cry
	end
	if gyatlevel > 43 then yield("/ad run Support 1330 20 false") end --dzemael
	yield("/snd stop all")
end

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
		if Player.Job.Level < 48 then
			do_it()
		end	
--		return --end this for loop
	end
	if GetCharacterName(true) == the_goats[i] and i == #the_goats then
		yield("/ays m e")
--		return --end this for loop
		yield("/snd stop all")
	end
end
