--[[
Changelog
v1.5
its even more reliable fully afk now

v1.0
First version. deep dungeon party leader for wiggling around DDs using xan's deep dungeon module in VBM
the DD module is a WIP feature of VBM - so please don't stress over weird issues. report them if you can to:
https://github.com/awgil/ffxiv_bossmod/issues/604
Please be advised as of this version there is the problem of navmesh.  you see DD is layed out in a grid of areas
the areas always exist. but only a few are active for your instance of the dungeon floor.  that said; only certain room connections
exist between those few rooms even. and currently navmesh does not know about this so it tries to path to destination as if every room was active and had every possible entrypoint available.
xan IS aware of this and it is a problem being worked on
also LOS stuff isn't really great atm because its a very hard problem to solve and is also known/being worked on.

--DD helper for solo or party of other cousins
--this is the party leader script in a group of cousins. the others would run frenrider

config ->
turn on everything in the dd module, turn OFF bronze coffers
make a vbm/bmr autorot called DD. ill eventually include an export in here to use(?) idk
turn on auto leave in CBT. at least until we hit the later floors then frantically go turn it off haha


--yesalready
Proceed to the next floor with your current party?
Exiting the area with a full inventory may result in the loss of rewards. Record progress and leave the area?
--deep dungeon requires VBM. BMR **WILL** crash your client without any logs or crash dump
			--deep dungeon requires VBM. BMR **WILL** crash your client without any logs or crash dump

additional config -> READ THE FRENRIDER CONFIG REQUIREMENTS - its the same
here:
https://github.com/Jaksuhn/SomethingNeedDoing/blob/master/Community%20Scripts/Dungeons/frenrider/frenrider_McVaxius.lua
			
--]]

--[[ --supposedly fixed now
if HasPlugin("BossModReborn") then
	yield("/xldisableplugin BossModReborn")
	repeat
		yield("/wait 1")
	until not HasPlugin("BossModReborn")
	yield("/xlenableplugin BossMod")
	repeat
		yield("/wait 1")
	until HasPlugin("BossMod")
	yield("/vbmai on")
	yield("/vbm ar set DD")
	yield("/echo WE SWITCHED TO VBM FROM BMR - please review DTR bar etc.")
end
	yield("/vbmai on")
	yield("/vbm ar set DD")
	yield("/rotation off") -- RSR please will cause AI movement problems
--]]
require("dfunc")

--important variables
fatfuck = 1
number_of_party_config = 4 --how many poople in party hah well we will check anyhow

yield("/bmrai setpresetname DD")

--The Distance Function
--why is this so complicated? well because sometimes we get bad values and we need to sanitize that so snd does not STB (shit the bed)
function distance(x1, y1, z1, x2, y2, z2)
	if type(x1) ~= "number" then x1 = 0 end
	if type(y1) ~= "number" then y1 = 0 end
	if type(z1) ~= "number" then z1 = 0 end
	if type(x2) ~= "number" then x2 = 0 end
	if type(y2) ~= "number" then y2	= 0 end
	if type(z2) ~= "number" then z2 = 0 end
	zoobz = math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
	if type(zoobz) ~= "number" then
		zoobz = 0
	end
    --return math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
    return zoobz
end

function getRandomNumber(min, max)
  return math.random(min,max)
end

function pooplecheck()
	number_of_party = number_of_party_config
	number_of_party = number_of_party - 1 --index starts at 0 anyways
	for poopy=0,number_of_party-1 do
		if string.len(GetPartyMemberName(poopy)) < 1 then number_of_party = number_of_party - 1 end
		yield("/wait 0.3")
	end
	number_of_party = number_of_party + 1
	if number_of_party > 1 then
		yield("/echo Number of poople in party ->"..number_of_party)
	end
	number_of_party = number_of_party - 1
	if number_of_party < 0 then number_of_party = 0 end
end

pooplecheck()

--counters
fattack = 0
fanav = 0
samenav = 0
wallitbro = 0
anal_of_passage = 0

rpX = EntityPlayerPositionX()
rpY = EntityPlayerPositionY()
rpZ = EntityPlayerPositionZ()


while fatfuck == 1 do
	yield("/wait 0.1") --speedup
    
	if getRandomNumber(1, 20) == 1 then
		yield("/target Palace")
		yield("/target Peaven")
		yield("/target Orthros")
		yield("/target Wuckcuck")
		yield("/echo grabbing nearby monster cuz whynot")
	end
	
	yield("/attack")	
	if string.len(GetTargetName()) > 1 then --check the target to make sure its valid before checking distance.
		if tonumber(GetLevel(GetClassJobId())) < 60 then --if if we aren't leveled to max in potd for example. i need to see if i can figure out which dd we in
			if distance(EntityPlayerPositionX(), EntityPlayerPositionY(), EntityPlayerPositionZ(), GetObjectRawXPos(GetTargetName()),GetObjectRawYPos(GetTargetName()),GetObjectRawZPos(GetTargetName())) < 50 then
				yield("/vnav moveto "..GetObjectRawXPos(GetTargetName()).." "..GetObjectRawYPos(GetTargetName()).." "..GetObjectRawZPos(GetTargetName()))
				yield("/echo vnavving to -> "..GetTargetName())
				yield("/wait 15") -- escape the gravitational pull of the floor exit
			end
		end
	end
	
	DD_relax = "Cairn of Passage"
	if distance(EntityPlayerPositionX(), EntityPlayerPositionY(), EntityPlayerPositionZ(), GetObjectRawXPos(DD_relax),GetObjectRawYPos(DD_relax),GetObjectRawZPos(DD_relax)) < 50 then
		yield("/bmrai off")
		yield("/rotation auto")
		yield("/echo CHILLING a sec so we can actually travel to the next floor")
		yield("/vnav moveto "..GetObjectRawXPos(DD_relax).." "..GetObjectRawYPos(DD_relax).." "..GetObjectRawZPos(DD_relax))
		yield("/wait 15")
		yield("/bmrai on")
		yield("/rotation cancel")
		--now we just need to check if there is a monster somewhat nearby so owe can escape the exit if need be. lets say 30 yalms?
		if string.len(GetTargetName()) > 1 then --check the target to make sure its valid before checking distance.
			if distance(EntityPlayerPositionX(), EntityPlayerPositionY(), EntityPlayerPositionZ(), GetObjectRawXPos(GetTargetName()),GetObjectRawYPos(GetTargetName()),GetObjectRawZPos(GetTargetName())) < 100 then
				yield("/vnav moveto "..GetObjectRawXPos(DD_relax).." "..GetObjectRawYPos(DD_relax).." "..GetObjectRawZPos(DD_relax))
				yield("/echo vnavving to -> "..DD_relax)
				yield("/wait 5") -- escape the gravitational pull of the floor exit
			end
		end
	end

	if Player.Available == false then
		--may as well reset everything if we get to this part
		yield("/send NUMPAD0")
		yield("/wait 1")
		fattack = 0
		fanav = 0
		samenav = 0
		wallitbro = 0
		anal_of_passage = 0
		yield("/echo resetting all counters - we are transiting floors or floor sets")
	end
	if Player.Available then
		--*we should probably check for toad/otter/owl/capybara status and force path to the anal of passage
		--comment this next line out if you don't want spam
		--yield("/echo # -> attack->"..fattack.."/5 nav->"..fanav.."/30 stopnav->"..samenav.."/10 wall->"..wallitbro.."/50 anal->"..anal_of_passage.."/180")
		fattack = fattack + 1
		fanav = fanav + 1
		wallitbro = wallitbro + 1
		anal_of_passage = anal_of_passage + 1
		
		if wallitbro > 50 then
			--run in a stright line on a random cardinal direction for 3 seconds once every 50 seconds. this will fix stuck hallway bs with no target on HUD
			--this is a kludge but provides just enough "jostling" for DD module to "get around"
			--this will not occur if we aren't in a duty.
			--but only if we aren't near a cairn 
			nemm = "Cairn of Passage"
			poostance = distance(EntityPlayerPositionX(), EntityPlayerPositionY(), EntityPlayerPositionZ(), GetObjectRawXPos(nemm),GetObjectRawYPos(nemm),GetObjectRawZPos(nemm))
			if poostance > 10 and Svc.Condition[34] == true then
				boop = {
				"W",
				"A",
				"S",
				"D"
				}
				booprand = getRandomNumber(1,4)
				yield("/echo We moving in cardinal for 3 seconds -> "..boop[booprand])
				yield("/hold "..boop[booprand].." <wait.3.0>")
				yield("/release "..boop[booprand])
			end
			--sometimes the cairn is not quite correctly targeted --  we will carefully shift INTO it
			if poostance < 5 then
				yield("/echo sneaking forward a bit just in case")
				yield("/hold W <wait.1>")
				yield("/release W")
			end
			wallitbro = 0
			yield("/wait 0.5")
		end

		if anal_of_passage > 180 then --every 3 minutes try to leave the floor just in case we stuck
				fattack = 0
				fanav = 0
				samenav = 0
				wallitbro = 0
			if anal_of_passage > 200 then --stay near the anal passage for 20 seconds
				anal_of_passage = 0
			end
			--nemm = GetPartyMemberName(1)
			--yield("/vnav moveto "..GetObjectRawXPos(nemm).." "..GetObjectRawYPos(nemm).." "..GetObjectRawZPos(nemm))
			yield("/echo attempting to get to the exit for the current floor")
			nemm = "Cairn of Passage"--this works if it exists so we can do this right after trying a party member. it will go to the party member otherwise.
			yield("/vnav moveto "..GetObjectRawXPos(nemm).." "..GetObjectRawYPos(nemm).." "..GetObjectRawZPos(nemm))
			yield("/wait 0.5")
		end
		
		if GetTargetName() == "Entry Point" then
			fattack = 6942069
			yield("/echo we are outside the floor system and need to re enter")
			nemm = GetTargetName()
			yield("/vnav moveto "..GetObjectRawXPos(nemm).." "..GetObjectRawYPos(nemm).." "..GetObjectRawZPos(nemm))
			yield("/wait 0.5")
			yield("/send NUMPAD0")
			yield("/wait 0.5")
			yield("/send NUMPAD0")
			yield("/wait 0.5")
		end
		
		if fattack > 5 then 
			--attack stuff
			yield("/bm on")
			yield("/echo attempting to attack!")
			--yield("/send KEY_1")
			shetzone = Svc.ClientState.TerritoryType
			--[[
			if shetzone > 560 and shetzone < 608 then
				if Svc.Condition[26] == false then
					yield("/hold W <wait.3.0>")
					yield("/release W")
				end
			end
			--]]
		
			if shetzone == 561 then yield("/target Death") end --floor 10
			if shetzone == 562 then yield("/target Spurge") end --floor 20
			if shetzone == 563 then yield("/target Ningishzida") end --floor 30
			if shetzone == 564 then yield("/target Ixtab") end --floor 40
			if shetzone == 565 then yield("/target Edda") end --floor 50
			if shetzone == 593 then yield("/target Rider") end --floor 60
			if shetzone == 594 then yield("/target Yaquaru") end --floor 70
			if shetzone == 595 then yield("/target Gudanna") end --floor 80
			if shetzone == 596 then yield("/target Godmother") end --floor 90
			if shetzone == 597 then yield("/target Nybeth") end --floor 100
			if shetzone == 598 then yield("/target Alicanto") end --floor 110
			if shetzone == 599 then yield("/target Kirtimukha") end --floor 120
			if shetzone == 600 then yield("/target Alfard") end --floor 130
			if shetzone == 601 then yield("/target Puch") end --floor 140
			if shetzone == 602 then yield("/target Tisiphone") end --floor 150  --halicarnassus ahahahhaha shes baaack
			if shetzone == 603 then yield("/target Totesritter") end --floor 160
			if shetzone == 604 then yield("/target Yulunggu") end --floor 170
			if shetzone == 605 then yield("/target Dendainsonne") end --floor 180
			if shetzone == 606 then yield("/target Godfather") end --floor 190
			if shetzone == 607 then yield("/target Nybeth") end --floor 200
			
			yield("/bmrai on")
			yield("/vbmai on")

			--get thee to next floor
			pooplecheck()
			yield("/target Point")
			yield("/wait 0.5")
			--if GetTargetName() == "Entry Point" then
			--	yield("/interact")  --this seems to be crashy
			--end
			fattack = 0
			--also check for dead party members and path to them asap
			if number_of_party > 1 then
				for i=0,number_of_party do
					nemm = GetPartyMemberName(i)
					nemm = nemm or ""
					yield("/wait 0.5")
					aitchpee = GetPartyMemberHP(i)
					yield("/echo Party member["..i.."] Name->"..nemm.." HP->"..aitchpee)
					if aitchpee < 5 and number_of_party > 1 and string.len(nemm) > 1 then
						--yield("/echo we need to save "..nemm.."->"..GetObjectRawXPos(nemm).." y "..GetObjectRawYPos(nemm).." z "..GetObjectRawZPos(nemm).."!")
						--yield("/echo we need to save "..GetPartyMemberName(i).."->"..GetPartyMemberRawXPos(i).." y "..GetPartyMemberRawYPos(i).." z "..GetPartyMemberRawZPos(i).."!")
						yield("/vnav stop")
						--yield("/bmrai off")
						yield("/wait 1")
						yield("/echo attempting to reach -> "..nemm.." <- they are low on HP or dead!")
						yield("/vnav moveto "..GetObjectRawXPos(nemm).." "..GetObjectRawYPos(nemm).." "..GetObjectRawZPos(nemm))
						--yield("/vnav moveto "..GetPartyMemberRawXPos(i).." "..GetPartyMemberRawYPos(i).." "..GetPartyMemberRawZPos(i))
						yield("/wait 5")		
					end
				end
			end
			yield("/wait 1")
		end

		--if fanav > 10 and samenav < 10 then
		nemm = GetTargetName()
		nemm = nemm or ""
		if fanav > 30 and Svc.Condition[26] == false and string.len(nemm) > 1 then
			fanav = 0
			yield("/echo attempting to move to -> "..nemm)
			yield("/vnav moveto "..GetObjectRawXPos(nemm).." "..GetObjectRawYPos(nemm).." "..GetObjectRawZPos(nemm))
			yield("/wait 1")
		end

		npX = EntityPlayerPositionX()
		npY = EntityPlayerPositionY()
		npZ = EntityPlayerPositionZ()
		if npX < 0 then npX = npX * -1 end
		if npY < 0 then npX = npY * -1 end
		if npZ < 0 then npX = npZ * -1 end
		if npX - rpX < 3 then samenav = samenav + 1 end
		if npX - rpY < 3 then samenav = samenav + 1 end
		if npX - rpZ < 3 then samenav = samenav + 1 end
		rpX = npX
		rpY = npY
		rpZ = npZ
		--[[
		if math.abs(EntityPlayerPositionX()-rpX) < 3 then samenav = samenav + 1 end
		if math.abs(EntityPlayerPositionY()-rpY) < 3 then samenav = samenav + 1 end
		if math.abs(EntityPlayerPositionZ()-rpZ) < 3 then samenav = samenav + 1 end
		--]]
		
		if samenav > 10 then
			yield("/echo We've been idle too long, stopping if we can.")
			yield("/vnav stop")
			samenav = 0
			yield("/wait 1")
		end

		--we get stuck sometimes should probably stop vnav after a while if we havent moved.
		
		
	end
end