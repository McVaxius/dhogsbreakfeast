--[[
Obviously don't ask anyone about this in discord anywhere. use at your own risk and please enjoy.
Author: Uncle Steven

cc botter

instructions:
*open DF
*pick pvp -> casual match
*close DF. 
*run script


target "Tactical Crystal"
zones->
The Palaistra
The Volcanic Heart
Cloud Nine
The Clockwork Castletown
The Red Sands
--]]

--required now in order to make basic stuff work.
loadfiyel = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\_functions.lua"
functionsToLoad = loadfile(loadfiyel)
functionsToLoad()


fuckpvp = 1
fuckme = 0

yield("/title set barago")
yield("/wait 5")
yield("/title set garo")
yield("/wait 5")

--[[wait 5 is for this errror:
Consecutive text command input is currently restricted.
Unable to use that title.
--]]

valid_pvp_areas = {
1027,1030, --palaistra
1031,1028, --volcanic heart
1032, --cloud nine
1037,1036, --clockwork castletown
1138  --red sands
}

while fuckpvp == 1 do
	fuckthis = Svc.ClientState.TerritoryType
	fuckyou = 0
	for i=1,#valid_pvp_areas do
		if fuckthis == valid_pvp_areas[i] then
			fuckyou = 1
		end
	end
	if fuckyou == 1 then
		--nemm = "Tactical Crystal"
		nemm = "Tactical Crystal"
		yield("/vnavmesh moveto "..GetObjectRawXPos(nemm).." "..GetObjectRawYPos(nemm).." "..GetObjectRawZPos(nemm))
		--DEBUG
		yield("/echo vnavmesh moveto "..GetObjectRawXPos(nemm).." "..GetObjectRawYPos(nemm).." "..GetObjectRawZPos(nemm))
		yield("/rotation auto")
		fuckme = fuckme + 1
		if fuckme > 3 then
			yield("/gaction jump")
			fuckme = 0
		end
	end
	yield("/wait 0.5")
	if fuckyou == 0 then
		yield("/wait 5") --wait a +bit longer if we are outside.
	end
	--*add in the logic to requeue and to exit the duty also
end