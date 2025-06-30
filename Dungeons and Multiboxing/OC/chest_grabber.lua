--passing by a chest? grab it.

loadfiyel = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\_functions.lua"
functionsToLoad = loadfile(loadfiyel)
functionsToLoad()

grabbyhands = 1
sidechest = 0

while grabbyhands == 1 do
	if GetCharacterCondition(26) == false then
		nemm = "Treasure Chest"
		sidechest = mydistto(GetObjectRawXPos(nemm),GetObjectRawYPos(nemm),GetObjectRawZPos(nemm))
		if sidechest > 0 and sidechest < 10 then
			yield("/vnavmesh moveto "..GetObjectRawXPos(nemm).." "..GetObjectRawYPos(nemm).." "..GetObjectRawZPos(nemm))
			yield("/target \"Treasure Chest\"")
			if sidechest < 2 then
				yield("/interact")
			end
		end
	end
	yield("/wait 0.5")
end