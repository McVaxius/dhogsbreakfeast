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
status 3016 when its at the start of match until one team moves it
status 2988 whe its trying to break through to next checkpoint

zones->
The Palaistra
The Volcanic Heart
Cloud Nine
The Clockwork Castletown
The Red Sands
Bayside Battleground

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
require("dfunc")


fuckpvp = 1
fuckme = 0
case_choice = -1
doop = 0
moop = 0

--comment these out if you dont need the garo title mounts
yield("/title set barago")
yield("/wait 3")
yield("/title set garo")
yield("/wait 3")

--[[wait 5 is for this error:
Consecutive text command input is currently restricted.
Unable to use that title.
--]]
--we gonna make xyz locs,  [zone] = {x1, y1, z1, x2, y2, z2}
--THANKS HYPERBOREA
valid_pvp_escape = {
    [1032] = {70.08521270752, 3.9999997615814, -9.7963066101074, -72.121978759766, 3.9999887943268, 9.7666854858398},  -- palaistra
    [1058] = {70.08521270752, 3.9999997615814, -9.7963066101074, -72.121978759766, 3.9999887943268, 9.7666854858398},  -- palaistra (?!?!?)
    [1033] = {60.159770965576, -1.5, -20.096973419189, -59.741413116455, -1.5, -20.130617141724},  -- volcanic heart
    [1059] = {60.159770965576, -1.5, -20.096973419189, -59.741413116455, -1.5, -20.130617141724},  -- volcanic heart 2 (?!?!?)
    [1034] = {-90.087173461914, 6.2741222381592, 78.478736877441, 89.641860961914, 6.2917737960815, -72.475570678711},  -- cloud nine
    [1060] = {-90.087173461914, 6.2741222381592, 78.478736877441, 89.641860961914, 6.2917737960815, -72.475570678711},  -- cloud nine 2 (?!?!?)
    [1116] = {59.628620147705, -4.887580871582e-06, 30.043525695801, -59.981777191162, 1.1920928955078e-07, -30.034025192261},  -- clockwork castletown
    [1117] = {59.628620147705, -4.887580871582e-06, 30.043525695801, -59.981777191162, 1.1920928955078e-07, -30.034025192261},  -- clockwork castletown 2 (?!?!?)
    [1138] = {-103.6203994751, 2.000935792923, -50.288391113281, 102.09278869629, 2.0002493858337, 50.151763916016},   -- red sands
    [1139] = {-103.6203994751, 2.000935792923, -50.288391113281, 102.09278869629, 2.0002493858337, 50.151763916016},   -- red sands 2 (?!?!?)
	[1293] = {187.177, -2.000, 99.600,  11.792, -2.000, 100.139}, --- the bayside battleground
	[1294] = {187.177, -2.000, 99.600,  11.792, -2.000, 100.139}  --- the bayside battleground 2 (?!?!?)
}

safeX = 0
safeY = 0
safeZ = 0
safetyMove = 0
fuckyou = 0

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
--[[
function OnDutyCompleted()
		safetyMove = 0
		fuckyou = 0
		doop = 0
		moop = 0
		case_choice = -1
end--]]

while fuckpvp == 1 do
	if Svc.Condition[34] == false and safetyMove == 1 then
		safetyMove = 0
		yield("/echo resetting safetyMove to 0 - we are out of duty")
		yield("/hold W")
		yield("/release W")
		fuckyou = 0
		doop = 0
		moop = 0
		case_choice = -1
	end
	fuckthis = Svc.ClientState.TerritoryType
	doop = 0
	moop = 0
	while Svc.Condition[34] == true and fuckyou == 0 do  --timer is paused at 30.998_ seconds until we are able to move our chars around
		if doop == 0 then
			yield("/echo we have entered the pvp match - please wait before more stuff happens the timer is paused at 30.998 seconds atm")
			yield("/vnav stop")
			doop = 1
		end
		if moop == 0 and GetContentTimeLeft() < 29 and GetContentTimeLeft() > 1 then
			yield("/vnav stop")
			yield("/wait 1")
			yield("/echo we are free from the confines of the intro portraits")
			yield("/mmambo") --change it to something else if you like.
			moop = 1
		end
		while GetContentTimeLeft() < 29 and GetContentTimeLeft() > 1 do
			yield("/vnav stop")
			yield("/wait 1")
		end
		if GetContentTimeLeft() < 5 or GetContentTimeLeft() > 100 then  --this way it will catch case of waiting too long
			fuckyou = 1
			yield("/echo the gate is open .. let's gooooooooooo!")
		end
		yield("/wait 0.1")
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
		case_choice = -1
		yield("/release W")
		while GetStatusTimeRemaining(895) == 1 and Svc.Condition[34] and case_choice == -1 do --spawn/respawn invuln
			yield("/pvpac sprint")
			--test both cases
			disturbed_table = {1,2,3,4}
			if case_choice == -1 then yield("/vnav stop") end  --this way it doesnt get caught in corner before we are ready for a table selection
			
			safeX = valid_pvp_escape[fuckthis][1]
			safeY = valid_pvp_escape[fuckthis][2]
			safeZ = valid_pvp_escape[fuckthis][3]
			disturbed_table[1] = mydistto(safeX,safeY,safeZ)
			--yield("/echo disturbed casetest 0 -> "..disturbed_table[1])
			if disturbed_table[1] < 40 then case_choice = 0 end

			safeX = valid_pvp_escape[fuckthis][4]
			safeY = valid_pvp_escape[fuckthis][5]
			safeZ = valid_pvp_escape[fuckthis][6]
			disturbed_table[4] = mydistto(safeX,safeY,safeZ)
			--yield("/echo disturbed casetest 3 -> "..disturbed_table[4])
			if disturbed_table[4] < 40 then case_choice = 3 end

			if case_choice > -1 then 
				safetyMove = 1 
				--yield("/echo grabbing safety x y z - we chose case_choice -> "..case_choice.." disturbed -> "..disturbed_table[1+case_choice])
				yield("/vnavmesh moveto "..valid_pvp_escape[fuckthis][1+case_choice].." "..valid_pvp_escape[fuckthis][2+case_choice].." "..valid_pvp_escape[fuckthis][3+case_choice])
			end
			yield("/wait 0.1")
		end
		--DEBUG
		yield("/rotation auto")
		fuckme = fuckme + 1
		if fuckme > 5 and Svc.Condition[34] == true then
			jobronies = GetClassJobId()
			fuckme = 0
			--yield("/pvpac \"Final Fantasia\"") -- bard
			for i=1,#reach_out_and_LIMITBREAKSOMEONE do
				if jobronies == reach_out_and_LIMITBREAKSOMEONE[i][2] then
					yield("/pvpac \""..reach_out_and_LIMITBREAKSOMEONE[i][1].."\"") -- any
					yield("/wait 0.1") --juuuust in case there is a 2nd one in the list
				end
			end
			--yield("/echo halfassed limit break attempt")
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