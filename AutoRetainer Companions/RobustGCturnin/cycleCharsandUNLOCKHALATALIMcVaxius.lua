--get to GC desk (Your GC desk)
--usual scripts and stuff needed.

--return location, 0 fc, 2 = limsa bell  etc
local franchise_owners = {
{"Firstname Lastname@Server", 0},
{"Firstname Lastname@Server", 0},
{"Firstname Lastname@Server", 0},
{"Firstname Lastname@Server", 0},
{"Firstname Lastname@Server", 0},
{"Firstname Lastname@Server", 0},
{"Firstname Lastname@Server", 0},
{"Firstname Lastname@Server", 0},
{"Firstname Lastname@Server", 0}
}

numpty = "Level'100 Frendo"   --name of your frendo. no @server required

loadfiyel = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\_functions.lua"
functionsToLoad = loadfile(loadfiyel)
functionsToLoad()
DidWeLoadcorrectly()

for i=1,#franchise_owners do
	if GetCharacterName(true) ~= franchise_owners[i][1] then
		yield("/ays relog " ..franchise_owners[i][1])
		yield("/wait 2")
		CharacterSafeWait()
	end	
	--*check if we have completed the quest
		--*check if we have acquired the quest
		--*acquire quest
	--*complete quest
	yield("/equipjob arc")
	yield("/equipjob mrd")
	yield("/equipjob cnj")
	--*do halatali ahahahaha
		--*invite numpty to party
		--*start instance
		--*start autoduty
	--*disband party

		--return home after getting the goodies
		yield("/li")
		yield("/wait 5")
		CharacterSafeWait()
		--added 5 second wait here because sometimes they get stuck.
		yield("/wait 5")
		if franchise_owners[i][2] == 0 then
			yield("/tp Estate Hall")
			yield("/wait 1")
			--WaitForAddon("Nowloading", 15)
			yield("/wait 15")
			WaitForAddon("NamePlate", 600)
			--normal small house shenanigans
			yield("/hold W <wait.1.0>")
			yield("/release W")
			yield("/target Entrance")
			yield("/wait 1")
			yield("/lockon on")
			yield("/automove on")
			yield("/wait 2.5")
			yield("/automove off")
			yield("/wait 1.5")
			yield("/hold Q")
			yield("/wait 2")
			yield("/release Q")
		end
		--retainer bell nearby shenanigans
		if franchise_owners[i][2] == 1 then
			yield("/target \"Summoning Bell\"")
			yield("/wait 2")
			PathfindAndMoveTo(GetObjectRawXPos("Summoning Bell"), GetObjectRawYPos("Summoning Bell"), GetObjectRawZPos("Summoning Bell"), false)
			visland_stop_moving() --added so we don't accidentally end before we get to the bell
		end
		--limsa bell
		if franchise_owners[i][2] == 2 then
			yield("/echo returning to limsa bell")
			return_to_limsa_bell()
		end
	end
end