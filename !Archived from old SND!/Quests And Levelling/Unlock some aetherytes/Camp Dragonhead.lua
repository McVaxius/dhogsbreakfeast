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
	--dragonhead aetheryte is id 23

	if IsAetheryteUnlocked(23) == true then
		yield("/echo we have dragon unlocked so we do nothing at all")
	end

	if IsAetheryteUnlocked(23) == false then
		--get to moraby :(
		yield("/echo we don't have dragon unlocked so we do it")
		yield("/tp Fallg")
		CharacterSafeWait()
		
		while type(GetZoneID()) == "number" and GetZoneID() == 154 do
				--it gets stuck partway through this area, but a renav fixes it
				yield("/vnav "..movetype.."to -367.21618652344 -6.9321041107178 185.84088134766") 
				yield("/wait 5")
		end
		CharacterSafeWait()
		yield("/vnav "..movetype.."to 230.07713317871 312.49884033203 -234.03834533691") --get to dragonhead aetheryte
		visland_stop_moving()
		grab_aetheryte()
		zungazunga()
		yield("/mount \"Company Chocobo\"")
		yield("/wait 6")
	
		yield("/li fc")
		
	end
end

yield("/ays multi e")