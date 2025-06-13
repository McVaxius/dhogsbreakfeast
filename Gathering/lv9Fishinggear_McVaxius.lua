--[[
Usage:
You have finished the first fishin quest and are level 10.
Talk to sissipoo to complete fisher quest 1
Talk to Roegadyn next to her to get ocean fishing quest.
now run the sccript and enjoy. (I hope you read the below config requirements).


config. 
you need navmesh, pandora, teleporter, lifestream, somethingeeddoing, textadvance, yesalready
and yesalready. setup yesalready to auto accept any purchases from npcs ;o
to do the auto purchase, just make 2 entries with

/Buy.*/
and include target specific, and put the two npcs names
Iron Thunder
and for the 2nd one, 
Syneyhil

--]]

function visland_stop_moving()
 yield("/equipguud")
 yield("/equiprecommended")
 yield("/character")
 yield("/callback Character true 15")
 yield("/wait 0.5")
 yield("/callback SelectYesno true 0")
 yield("/character")
 yield("/callback Character true 15")
 yield("/callback SelectYesno true 0")
 yield("/wait 3")
 muuv = 1
 muuvX = GetPlayerRawXPos()
 muuvY = GetPlayerRawYPos()
 muuvZ = GetPlayerRawZPos()
 while muuv == 1 do
	yield("/wait 1")
	if muuvX == GetPlayerRawXPos() and muuvY == GetPlayerRawYPos() and muuvZ == GetPlayerRawZPos() then
		muuv = 0
	end
	muuvX = GetPlayerRawXPos()
	muuvY = GetPlayerRawYPos()
	muuvZ = GetPlayerRawZPos()
 end
 yield("/echo movement stopped safely - script proceeding to next bit")
 yield("/visland stop")
 yield("/vnavmesh stop")
 yield("/wait 3")
end
--get to the first vendor
yield("/vnavmesh moveto -154.89814758301 18.200000762939 23.502319335938")
visland_stop_moving()
yield("/target Iron Thunder")
yield("/wait 2")
yield("/interact")
yield("/wait 2")
yield("/callback SelectIconString true 2 <wait.2>")
yield("/callback SelectString true 0 <wait.2>")
yield("/callback Shop true 0 0 1 <wait.1.0>")
yield("/callback Shop true 0 2 1 <wait.1.0>")
yield("/callback Shop true 0 4 1 <wait.1.0>")
yield("/callback Shop true 0 6 1 <wait.1.0>")
yield("/callback Shop true 0 7 1 <wait.1.0>")
yield("/callback Shop true -1 <wait.1.0>")
yield("/send ESCAPE")
yield("/wait 0.5")
yield("/send ESCAPE")
yield("/wait 0.5")
visland_stop_moving()

--get to second vendor
yield("/vnavmesh moveto -246.67446899414 16.199998855591 41.268531799316")
visland_stop_moving()
yield("/target Syneyhil")
yield("/wait 2")
yield("/interact")
yield("/wait 2")
yield("/callback SelectIconString true 1")
yield("/wait 2")
yield("/callback SelectString true 0")
yield("/wait 2")
yield("/callback Shop true 0 5 1")
yield("/wait 1")
yield("/callback Shop true -1")
yield("/wait 1")
visland_stop_moving()

--go unlock fishing aetheryte
yield("/vnavmesh moveto -334.74258422852 11.99923324585 54.69458770752")
visland_stop_moving()
yield("/target Aethernet Shard")
yield("/wait 2")
yield("/interact")
yield("/wait 10")

--go talk to roe @ ocean fishing docks
yield("/vnavmesh moveto -411.98840332031 4.0 75.463768005371")
visland_stop_moving()
yield("/target Foerzagyl")
yield("/wait 2")
yield("/interact")
yield("/wait 3")
visland_stop_moving()

--auto equip and bait setup
yield("/wait 5")
yield("/ac bait")
yield("/wait 5")
yield("/callback Bait true 29717 false")
yield("/wait 1")
yield("/ac bait")
yield("/wait 1")
yield("/character")
yield("/wait 1")
yield("/callback Character true 12")
yield("/wait 1")
yield("/callback RecommendEquip true 0")
yield("/wait 1")
yield("/send ESCAPE")
yield("/wait 0.5")
yield("/send ESCAPE")
yield("/wait 0.5")

--auto equip and bait setup 2nd attempt just in case it didnt work ;o
yield("/wait 5")
yield("/ac bait")
yield("/wait 5")
yield("/callback Bait true 29717 false")
yield("/wait 1")
yield("/ac bait")
yield("/wait 1")
yield("/character")
yield("/wait 1")
yield("/callback Character true 12")
yield("/wait 1")
yield("/callback RecommendEquip true 0")
yield("/wait 1")

--go straight to costa del sol or quarrymill?
yield("/tp quarrymill")
yield("/wait 10")
visland_stop_moving()
yield("/vnavmesh moveto 184.9930267334 7.2395286560059 -35.677642822266")
visland_stop_moving()
yield("/ac cast")