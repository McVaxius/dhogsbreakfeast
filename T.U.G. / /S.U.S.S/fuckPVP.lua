--[[
Obviously don't ask anyone about this in discord anywhere. use at your own risk and please enjoy.
Author: Uncle Steven

Turn frontlines into a (shitty) RTS game.

Feels of Gary (shitter) 554
incel hacker (danshit madame) 888
bored er..lands (suck your) 1273
seal cock (seizure) 431

instructions:
drop a flag where you want your char to go zerg
marginally useful script that requires autorotation and something need doing.
mostly useful if your multiboxing chars in pvp and dont want to manage htem at all. you can click flags on each char and treat PVP like an RTS game.

maybe if i feel like being a sick fuck ill add auto queueing for that sweet experience. maybe useful on incel hacker days to just meet your alts in the middle for nonstop ?n? v ?n? v ?n? deathmatch
--]]

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

while fuckpvp == 1 do
	fuckthis = GetZoneID()
	fuckyou = 0
	if fuckthis == 554 or fuckthis == 888 or fuckthis == 1273 or fuckthis == 431 then
		fuckyou = 1
	end
	if fuckyou == 1 then
		yield("/vnavmesh moveflag <flag>")
		yield("/rotation auto")
		fuckme = fuckme + 1
		if fuckme > 3 then
			yield("/gaction jump")
			fuckme = 0
		end
		if Svc.Condition[10] == false and Svc.Condition[4] == false then
			--yield("/mount \"Chocorpokkur\"")
			yield("/ac \"Mount Roulette\"")
		end
	end
	yield("/wait 5")
end