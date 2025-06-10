yield("/ays multi d")

--unlock these two shitty aetherytes bronze lake and upper la noscea
loadfiyel = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\_functions.lua"
functionsToLoad = loadfile(loadfiyel)
functionsToLoad()

movetype = "move"
--movetype = "fly"

charlist = {
"firstname lastname@server",
"firstname lastname@server",
"firstname lastname@server"
}

for i=1,#charlist do
	--load ze char
	while charlist[i] ~= GetCharacterName(true) do
		yield("/echo swithcing chars!")
		yield("/ays relog " ..charlist[i])
		yield("/wait 3")
		yield("/waitaddon _ActionBar <maxwait.600><wait.5>")
	end

	if are_we_dol() then
		yield("/equipjob "..job_short(which_cj()))
		yield("/echo Switching to "..job_short(which_cj()))
		yield("/wait 3")
	end

	yield("/echo First chocobo mount")
	yield("/mount \"Company Chocobo\"")
	yield("/wait 6")
	
	--do we have wineport unlocked?
	--wineport aetheryte is id 12

	if IsAetheryteUnlocked(12) == true then
		yield("/echo we have wineport unlocked so we tp to it")
		yield("/tp wineport")
		CharacterSafeWait()
	end

	if IsAetheryteUnlocked(12) == false then
		--get to moraby :(
		yield("/echo we dont have wineport unlocked so we need to go to moraby")
		yield("/tp moraby")
		CharacterSafeWait()

		yield("/vnav "..movetype.."to 572.73193359375 96.397186279297 -525.09948730469") --get to eastern las noscnea wineport side
		visland_stop_moving()
		CharacterSafeWait()
		yield("/vnav "..movetype.."to -19.65797996521 70.50106048584 10.600910186768") --get to eastern las noscnea wineport side aetheryte
		visland_stop_moving()
		grab_aetheryte()
		zungazunga()
		yield("/mount \"Company Chocobo\"")
		yield("/wait 6")
	end
	
	yield("/echo lets go to bronzeport")
	yield("/vnav "..movetype.."to 80.876075744629 80.039474487305 -125.75521850586") --get to bronze lake
	visland_stop_moving()
	CharacterSafeWait()
	yield("/vnav "..movetype.."to 434.98513793945 3.6090104579926 98.775543212891") --get to bronze lake aetheryte
	visland_stop_moving()
	grab_aetheryte()
	zungazunga()
	yield("/mount \"Company Chocobo\"")
	yield("/wait 6")

	yield("/echo lets go to goblinport")
	yield("/vnav "..movetype.."to 286.96008300781 41.385322570801 -203.57307434082") --get to upper la noscea
	visland_stop_moving()
	CharacterSafeWait()
	yield("/vnav "..movetype.."to -117.79266357422 64.759223937988 -206.78842163086") --get to upper la noscea aetheryte
	visland_stop_moving()
	grab_aetheryte()
	zungazunga()

	yield("/li fc")
end

yield("/ays multi e")