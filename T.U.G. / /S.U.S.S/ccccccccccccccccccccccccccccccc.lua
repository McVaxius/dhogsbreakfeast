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
yield("/wait 3")
yield("/title set garo")
yield("/wait 3")

--[[wait 5 is for this error:
Consecutive text command input is currently restricted.
Unable to use that title.
--]]

--Q strafe left, E Strafe right
--[[
valid_pvp_areas = {
    [1032] = "E",  -- palaistra  --VERIFIED
    [1033] = "E",  -- volcanic heart
    [1034] = "Q",  -- cloud nine --VERIFIED
    [1116] = "Q",  -- clockwork castletown --VERIFIED
    [1138] = "Q"   -- red sands --VERIFIED
}
--]]

--we gonna make xyz locs,  [zone] = {x1, y1, z1, x2, y2, z2}
--THANKS HYPERBOREA
valid_pvp_escape = {
    [1032] = {1, 2, 3, 4, 5, 6},  -- palaistra
    [1033] = {1, 2, 3, 4, 5, 6},  -- volcanic heart
    [1034] = {1, 2, 3, 4, 5, 6},  -- cloud nine
    [1116] = {1, 2, 3, 4, 5, 6},  -- clockwork castletown
    [1138] = {1, 2, 3, 4, 5, 6}   -- red sands
}

safeX = 0
safeY = 0
safeZ = 0
safetyMove = 0

reach_out_and_LIMITBREAKSOMEONE = {
	{"Phalanx", 19},
	{"Primal Scream", 21},
	{"Eventide", 32},
	{"Relentless Rush", 37},
	{"Terminal Trigger", 37},
	{"Afflatus Purgation", 24},
	{"Celestial River", 33},
	{"Mesotes", 40},
	{"Mesotes", 40},
	{"Final Fantasia", 23},
	{"Marksman's Spite", 31},
	{"Contradance", 38},
	{"Terminal Trigger", 37},
	{"Meteodrive", 20},
	{"Sky High", 22},
	{"Sky Shatter", 22},
	{"Sky Shatter", 22},
	{"Seiton Tenchu", 30},
	{"Seiton Tenchu", 30},
	{"Zantetsuken", 34},
	{"Tenebrae Lemurum", 39},
	{"Soul Resonance", 25},
	{"Summon Bahamut", 27},
	{"Summon Phoenix", 27},
	{"World-swallower", 41},
	{"Advent of Chocobastion", 42},
	{"Southern Cross", 35},
	{"Seraphism", 28}
}

while fuckpvp == 1 do
	if Svc.Condition[34] == false and safetyMove == 1 then
		safetyMove = 0
		yield("/echo resetting safetymove to 0")
		yield("/hold W")
		yield("/release W")
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
	if Svc.Condition[34] == true then
		fuckyou = 1
		yield("/echo we have entered the pvp match - please wait 20 seconds before more stuff happens")
		yield("/wait 20")
		yield("/mmambo")
		yield("/wait 5")
	end
	if fuckyou == 1 then
		--nemm = "Tactical Crystal"
		nemm = "Tactical Crystal"
		--wigglevars
		rX = getRandomNumber(0,2)
		rZ = getRandomNumber(0,2)
		--this should have some wiggle
		yield("/vnavmesh moveto "..GetObjectRawXPos(nemm)+rX.." "..GetObjectRawYPos(nemm).." "..GetObjectRawZPos(nemm)+rZ)
		--end
		zoob = 0
		ZOOB = 0
		yield("/release W")
--[[
		while GetStatusTimeRemaining(895) == 0 and Svc.Condition[34] and Svc.Condition[1] and safetyMove == 0 do --spawn/respawn invuln
			safeX = Player.Entity.Position.X
			safeY = Player.Entity.Position.Y
			safeZ = Player.Entity.Position.Z
			safetyMove = 1
			yield("/echo grabbing safety x y z and setting safetyMove to 1")
		end
--]]
		while GetStatusTimeRemaining(895) == 1 and Svc.Condition[34] and safetyMove == 1 do --spawn/respawn invuln with safety xyz
			yield("/vnavmesh moveto "..safeX.." "..safeY.." "..safeZ)
--			if GetStatusTimeRemaining(895) == 1 then yield("/wait 0.5") end
--			if GetStatusTimeRemaining(895) == 1 then yield("/wait 0.5") end
			yield("/echo we escaping safely")
			yield("/wait 0.1")
		end
		while GetStatusTimeRemaining(895) == 1 and Svc.Condition[34] and safetyMove == 0 do --spawn/respawn invuln
			yield("/pvpac sprint")
			safeX = valid_pvp_escape[fuckthis][4]
			safeY = valid_pvp_escape[fuckthis][5]
			safeZ = valid_pvp_escape[fuckthis][6]
			if mydistto(valid_pvp_escape[fuckthis][1],valid_pvp_escape[fuckthis][2],valid_pvp_escape[fuckthis][3]) < 20 then
				safeX = valid_pvp_escape[fuckthis][1]
				safeY = valid_pvp_escape[fuckthis][2]
				safeZ = valid_pvp_escape[fuckthis][3]				
			end
			safetyMove = 1
			yield("/echo grabbing safety x y z and setting safetyMove to 1")
			yield("/vnavmesh moveto "..safeX.." "..safeY.." "..safeZ)
			yield("/wait 0.1")
		end
		--DEBUG
		yield("/rotation auto")
		fuckme = fuckme + 1
		if fuckme > 5 then
			jobronies = GetClassJobId()
			fuckme = 0
			--yield("/pvpac \"Final Fantasia\"") -- bard
			for i=1,#reach_out_and_LIMITBREAKSOMEONE do
				if jobronies == reach_out_and_LIMITBREAKSOMEONE[i][2] then
					yield("/pvpac \""..reach_out_and_LIMITBREAKSOMEONE[i][1].."\"") -- any
					yield("/wait 0.1") --juuuust in case there is a 2nd one in the list
				end
			end
			yield("/echo halfassed limit break attempt")
		end
	end
	yield("/wait 0.5")
	if fuckyou == 0 then
		yield("/wait 5") --wait a +bit longer if we are outside.
		if Svc.Condition[91] == false then 
			yield("/dutyfinder") --try autoqueue with cbt if we aren't queueing for a duty.
		end
	end
	--exit via cbt
end