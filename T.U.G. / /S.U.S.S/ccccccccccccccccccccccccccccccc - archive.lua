--[[
Obviously don't ask anyone about this in discord anywhere. use at your own risk and please enjoy.
Author: Uncle Steven

cc botter

instructions:
*open DF
*pick pvp -> casual match
*close DF. 
*run script

setup CBT auto exit duty, and auto queue

target "Tactical Crystal"
zones->
The Palaistra
The Volcanic Heart
Cloud Nine
The Clockwork Castletown
The Red Sands

PVPMKSPartyList3
1,5,6,6,18,21
from 6-10
enemy1 = Addons.GetAddon("PvPMKSPartyList3"):GetNode(1, 5, 6, 6, 18, 21)
enemy2 = Addons.GetAddon("PvPMKSPartyList3"):GetNode(1, 5, 7, 6, 18, 21)
enemy3 = Addons.GetAddon("PvPMKSPartyList3"):GetNode(1, 5, 8, 6, 18, 21)
enemy4 = Addons.GetAddon("PvPMKSPartyList3"):GetNode(1, 5, 9, 6, 18, 21)
enemy5 = Addons.GetAddon("PvPMKSPartyList3"):GetNode(1, 5, 10, 6, 18, 21)
yield("/echo Player 1 from enemy team -> "..enemy1.Text)


GetStatusTimeRemaining(895) == 0 --- this is invuln
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
1032, 1034, --cloud nine
1037,1036, --clockwork castletown
1138  --red sands
}

cardinal_wardinal = {
--"W",
--"A",
--"S",
--"D"
"Q", --strafe left
"E"  --strafe right
}

cardinal_wardinal_flardinal = 1
safeX = 0
safeY = 0
safeZ = 0
safetyMove = 0

while fuckpvp == 1 do
	if Svc.Condition[34] == false and safetyMove == 1 then
		safetyMove = 0
		yield("/echo resetting safetymove to 0")
	end
	fuckthis = Svc.ClientState.TerritoryType
	fuckyou = 0
	--[[
	for i=1,#valid_pvp_areas do
		if fuckthis == valid_pvp_areas[i] then
			fuckyou = 1
		end
	end
	--]]
	if Svc.Condition[34] == true then fuckyou = 1 end
	if fuckyou == 1 then
		--nemm = "Tactical Crystal"
		nemm = "Tactical Crystal"
		--if GetStatusTimeRemaining(895) ~= 1 then--dont nav if we invuln
			yield("/vnavmesh moveto "..GetObjectRawXPos(nemm).." "..GetObjectRawYPos(nemm).." "..GetObjectRawZPos(nemm))
		--end
		zoob = 0
		yield("/release W")
		while GetStatusTimeRemaining(895) == 0 and Svc.Condition[34] and safetyMove == 0 do --spawn/respawn invuln
			safeX = Player.Entity.Position.X
			safeY = Player.Entity.Position.Y
			safeZ = Player.Entity.Position.Z
			safetyMove = 1
			yield("/echo grabbing safety x y z and setting safetyMove to 1")
		end
		while GetStatusTimeRemaining(895) == 1 and Svc.Condition[34] and safetyMove == 1 do --spawn/respawn invuln with safety xyz
			yield("/vnavmesh moveto "..safeX.." "..safeY.." "..safeZ)
			yield("/wait 0.5")
			yield("/echo we escaping safely")
		end
		while GetStatusTimeRemaining(895) == 1 and Svc.Condition[34] and safetyMove == 0 do --spawn/respawn invuln
			zoob = zoob + 1
			yield("/pvpac sprint")
			yield("/hold W")
			yield("/vnavmesh moveto "..GetObjectRawXPos(nemm).." "..GetObjectRawYPos(nemm).." "..GetObjectRawZPos(nemm))
			if zoob > 3 then
				zoob = 0
				yield("/gaction jump")
				yield("/hold "..cardinal_wardinal[cardinal_wardinal_flardinal])
				yield("/release "..cardinal_wardinal[cardinal_wardinal_flardinal])
				--yield("/release W")
				cardinal_wardinal_flardinal = cardinal_wardinal_flardinal + 1
			end
			yield("/wait 0.5")
			if cardinal_wardinal_flardinal > #cardinal_wardinal then cardinal_wardinal_flardinal = 1 end
			
			--yield("/vnav stop")
			--[[
			yield("/hold "..cardinal_wardinal[cardinal_wardinal_flardinal])
			nextinal = cardinal_wardinal_flardinal + 1
			if nextinal > #cardinal_wardinal then nextinal = 1 end
			for z=1,10 do
				yield("/hold "..cardinal_wardinal[nextinal])
				yield("/wait 0.1")
				yield("/release "..cardinal_wardinal[nextinal])
			end
			yield("/release "..cardinal_wardinal[cardinal_wardinal_flardinal])
			cardinal_wardinal_flardinal = cardinal_wardinal_flardinal + 1
			if cardinal_wardinal_flardinal > #cardinal_wardinal then cardinal_wardinal_flardinal = 1 end
			--]]
		end
		--DEBUG
		--yield("/echo vnavmesh moveto "..GetObjectRawXPos(nemm).." "..GetObjectRawYPos(nemm).." "..GetObjectRawZPos(nemm))
		yield("/rotation auto")
		fuckme = fuckme + 1
		if fuckme > 5 then
			--yield("/gaction jump")
			fuckme = 0
			yield("/pvpac \"limit break\"")
			yield("/echo halfassed limit break attempt")
		end
	end
	yield("/wait 0.5")
	if fuckyou == 0 then
		yield("/wait 5") --wait a +bit longer if we are outside.
		yield("/release W")
		if Svc.Condition[91] == false then 
			yield("/dutyfinder") --try autoqueue with cbt if we aren't queueing for a duty.
		end
	end
	--exit via cbt
	--Instances.DutyFinder:OpenRouletteDuty(number)
end