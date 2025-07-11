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
	if GetItemCount(12995) > 0 then
		yield("/tp limsa")
		CharacterSafeWait()
		yield("/li aft")
		CharacterSafeWait()
		visland_stop_moving()
		how_many = 1
		bloop = GetItemCount(12995)
		if bloop == 5 then how_many = 1 end
		if bloop == 10 then how_many = 2 end
		if bloop == 15 then how_many = 3 end
		if bloop == 20 then how_many = 4 end
		yield("/echo buying "..how_many.." thingies")
		yield("/vnav moveto 4.8244118690491 44.5 154.6026763916")
		visland_stop_moving()
		yield("/target Calamity Salvager")
		yield("/wait 2")
		yield("/interact")
		yield("/wait 2")
		yield("/callback SelectIconString true 6")
		yield("/wait 3")
		yield("/callback SelectString true 6")
		yield("/wait 3")
		yield("/callback ShopExchangeItem true 0 0 1 3u")
		yield("/wait 3")
		if how_many > 1 then
			yield("/callback ShopExchangeItem true 0 21 1 3u")
			yield("/wait 3")
		end
		if how_many > 2 then
			yield("/callback ShopExchangeItem true 0 22 1 3u")
			yield("/wait 3")
		end
		if how_many > 3 then
			yield("/callback ShopExchangeItem true 0 23 1 3u")
			yield("/wait 3")
		end
		ungabunga()
		--return home after getting the goodies
		yield("/li")
		yield("/wait 5")
		CharacterSafeWait()
		--added 5 second wait here because sometimes they get stuck.
		yield("/wait 5")
		if franchise_owners[i][2] == 0 then
			yield("/tp Estate Hall")
			yield("/wait 1")
			--yield("/waitaddon Nowloading <maxwait.15>")
			yield("/wait 15")
			yield("/waitaddon NamePlate <maxwait.600><wait.5>")
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