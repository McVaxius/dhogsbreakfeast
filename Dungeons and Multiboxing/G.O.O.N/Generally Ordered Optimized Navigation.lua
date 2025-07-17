--[[
Generally Ordered Optimized Navigation.lua  (thanks for the idea fifi)
or "Something need Gooning"
thanks to @Akasha and @Ritsuko for some of the ideas/code

purpose: help autoduty with farming duties.
design: it will run 99 prae, and then run decumana until reset time (1 am PDT) and reset the counter and go back to farming prae.

Plugins/configs (ill update as people realize i forgot instructions)
Automaton (Now called CBT)
Some form of bossmod
Rotation Solver Reborn
Vnavmesh
Simpletweaks
Cutscene Skip -> https://raw.githubusercontent.com/KangasZ/DalamudPluginRepository/main/plugin_repository.json

Configurations (NOT OPTIONAL.  THEY ARE ABSOLUTELY MANDATORY)
game -> don't have it in controller mode or it will start chatting (!?!?!?!?!?!) Thanks @Arcorius for this
game -> duty finder config -> unsync+levelsync

Pandora -> actually have this disabled it causes problems.
Simpletweaks -> targeting fix aka "Fix '/target' Command
AD -> Turn off "Leave Duty" and or change to leave only when duty is complete and not path complete
AD -> choose the W2W Ritsuko or whatever path you want to use BEFORE starting anyhthing in ad. make sure to click prae then pick the route.

This script placed into your SND folder -> https://raw.githubusercontent.com/McVaxius/dhogsbreakfeast/refs/heads/main/dfunc.lua

Yesalready configs (maybe only the first one is needed since the rest are done via callbacks w ya off) also make sure yesalready is on :p ad turns it off sometimes (???)
	"YesNo"
		/Repair all displayed items for.*/
		/Exit.*/
		/Move immediately to sealed area.*/
	"Lists"
		/Retire to an inn room.*/

CBT -> Enhanced Duty start/end
	duty start -> /snd run start_gooning
	duty end -> /ad stop
	leave duty -> 10 seconds

OPTIONAL to reduce cpu+gpu usage significantly and cool down your sauna to just a warm afternoon:
Custom Resolution Scaler -> Gameplay -> Pixelated -> 0.1 -> Enabled [x] -> Save and Apply
	0.1 is like n64 / ps1 graphics. 0.05 is like snes, and 0.001 is like hilarious. its just 4 pixels. THATS IT 
	it won't reduce cpu/ram reqs but it will reduce GPU to nothing
Chillframes -> 15 out of combat 30 in combat
	it will reduce CPU and GPU reqs, it wont affect ram


FIX from old PYES setup:
REMOVE THIS FROM YESALREADY
		Return to the starting point for the Praetorium?   ※You may be unable to re-enter ongoing battles.
FIX FOR WEIRD PATHING ISSUES:
also.. if you run multiple copies of dalamud from same folder eventually autoduty becomes autodoodie and will fail to do paths and you will have to kill all clients running from that path, and then just pick one and load it.
its related to vnav
another way to explain it:
1 client per dalamud folder
using same vnav cache for multiple clients eventually causes failure in autoduty
when in doubt just kill the client and reload.. snd vnav ad all get a little weird after a while

recommended party:
war dps dps sch
for sch in RSR turn off adloquim, succor and physick

reccommend setup:
WAR SCH SMN/MCH MNK
or 
WAR SCH MCH MCH
or
GNB SGE MCH MCH
or
BLU BLU BLU BLU or some combination of BST/BLU

(yeah right hahaha.)

random thoughts
I figured out how to get ad to do unsync+level sync
you first setup unsync+level sync . since it will never unhceck level sync. then tick unsync for regular duty prae
and then let goon do its thing
minor qol just to see the times in a nice chat window
also sometimes things go haywire if you change jobs just /xlkill that/those client(s) and restart them
also because the path has automove, we have to leave the horrible camera controls on :(
also sometimes the movement type is changed from legacy to standard -> ?????????????????? its not autoduty??!??

i'm searching for prae
1,52,61001*,5 through to 61015  .Text
for i=5,15 do
	Instances.DutyFinder:OpenRegularDuty(i)
dName = Addons.GetAddon("ContentsFinder"):GetNode(1,52,61000+i,5)
yield("/echo Duty Name "..i.." -> "..tostring(dName.Text))
yield("/wait 1")
end
--]]

require("dfunc")

yield("/echo You have started G.O.O.N ing")

jigglecounter = 0
x1 = EntityPlayerPositionX()
y1 = EntityPlayerPositionY()
z1 = EntityPlayerPositionZ()

stopcuckingme = 0    --counter for checking whento pop duty
imthecaptainnow = 0 --set this to 1 if this char is the party leader																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																														 --set this to 1 if this char is the party leader
if Svc.Party[Svc.Party.PartyLeaderIndex].ContentId == Svc.ClientState.LocalContentId then imthecaptainnow = 1 end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
--------EDIT THESE IN THE SND SETTINGS!---------------------------------------------------------------------------------------
--[=====[
[[SND Metadata]]
author: dhogGPT
version: 420.69.420.0
description: Farm mogtomes with your cousins.
plugin_dependencies:
- vnavmesh
- SimpleTweaksPlugin
configs:
  zduty_counter:
    default: 0
    description: "This is the Prae duty counter. \nSet it to 0 if its the first run of the day \n Daily reset time is 3 am EST or 12am PST"
    type: int
    min: 1
    max: 99
    required: true
  ztornclothes:
    default: 25
    description: "pct to try to repair at\n this is for npc repair.\nParty leader will repair at this pct\nRest of party will go try to repair no matter what (99 pct) if they are outside of duty for >20 seconds"
    type: int
    min: 1
    max: 99
    required: true
  zfinickyclothes:
    default: 0
    description: "0 = dont auto equip\n1 = autoequip, useful if you have bis that isnt max level\ndefault set to NOT equip so people can manage their BIS"
    type: int
    min: 0
    max: 1
    required: true
  zducttape:
    default: 33916
    description: "0 = itemID of repair material to check for self repair.\ncheck if we even have g8dm, otherwise dont waste time,\n10386 is g6dm if you wanna change it, 17837 is g7, 33916 is g8"
    type: number
    required: true
  zbm_preset:
    default: "none"
    description: "if you set it to none it wont use bmr and instead it will use RSR. this is for the ai preset to use."
    type: string
    required: true
  zfeedme:
    default: 46003
    description: "itemID for food to eat\nuse simple tweaks ShowID to find it (turn it on and hover over item, it will be the number on the left in the square [] brackets)\nSet this to 6942069 if you want it to pull from a list and eat whatever is in the inventory when food timer is < 5 minutes"
    type: number
    required: true
  zfeedmeitem:
    default: "Canned Beesechussy"
    description: "call it whatever you want. doesn't affect anything"
    type: string
    required: true
  zfeedmesearch:
    default: true
    description: "do you want it to search for other foods if the selected one runs out?"
    type: boolean
    required: true
  zecho_level:
    default: 3
    description: "5 show nothing at all except critical moments\n4 only show duty counters\n3 only show important stuff\n2 show the progress messages\n1 show more\n0 show all"
    type: int
    min: 0
    max: 5
    required: true
  zitworksonmymachine:
    default: 0
    description: "0 means use ad start (pre-select regular mode+correct path first in ad)\n1 means use the callback and snd function method(s) for queueing into porta/prae\ntoggle this setting if queueing is weird or broken"
    type: int
    min: 0
    max: 1
    required: true

[[End Metadata]]
--]=====]

--Don't edit these
duty_counter = Config.Get("zduty_counter")
tornclothes = Config.Get("ztornclothes")
finickyclothes = Config.Get("zfinickyclothes")
ducttape = Config.Get("zducttape")
bm_preset = Config.Get("zbm_preset")
feedme = Config.Get("zfeedme")
feedmeitem = Config.Get("zfeedmeitem")
zfeedmesearch = Config.Get("zfeedmesearch")
echo_level = Config.Get("zecho_level")
itworksonmymachine = Config.Get("zitworksonmymachine")

--you can edit these if you are brave debug/dont-touch-settings-unless-you-know-whats-up
hardened_sock = 1200 		 --bailout from duty in 1200 seconds (20 minutes)
debug_counter = 0 --if this is >0 then subtract from the total duties . useful for checking for crashes just enter in the duty_counter value+1 of the last crash, so if you crashed at duty counter 5, enter in a 6 for this value
maxjiggle = 30 --how much default time (# of loops of the script) before we jiggle the char in prae
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

--dutypresets -- test with Instances.DutyFinder:OpenRegularDuty(830)    
praeID = 16	  -- count from the top until you reach praetorium to get the number if you dont have all of ARR dungeons unlocked. sometimes 1044 works. count from top to prae and then add 1 for the index to use here.
decuID = 830  -- this seems to work on most clients
if IPC.Automaton.IsTweakEnabled("AutoQueue") == true then IPC.Automaton.SetTweakState("AutoQueue", false) end
if imthecaptainnow == 1 and Svc.Condition[34] == false and itworksonmymachine == 1 then
	Instances.DutyFinder:OpenRegularDuty(1)
	yield("/waitaddon ContentsFinder<maxwait 10>")
	yield("/echo scanning for Praetorium (itworksonmymachine == 1)")
	yield("/wait 5")
	for i=6,50 do
	Instances.DutyFinder:OpenRegularDuty(i)
	dName = Addons.GetAddon("ContentsFinder"):GetNode(1,52,61000+i,5)
	yield("/echo Duty Name "..(i+2).." ->"..tostring(dName.Text).."<--")
	if dName.Text == "The Praetorium" then
		yield("/echo we found it at index -> "..(i+2))
		praeID = i + 2
	end
	yield("/wait 0.1")
	end
	ChooseAndClickDuty(praeID)
end

--dont touch these ones
entered_duty = 0
equip_counter = 0
inprae = 0
maxzone = 0
someone_took_the_duct_tape = 0
checking_the_duct_tape = 0
decucounter = 0
foodsearch = false

--ipc, upc, we all p for c
if imthecaptainnow == 0 and itworksonmymachine == 1 then
	yield("/echo I'm not the captain now")
	if IPC.Automaton.IsTweakEnabled("AutoQueue") == true then IPC.Automaton.SetTweakState("AutoQueue", false) end
end
if imthecaptainnow == 1 and itworksonmymachine == 1 then
	yield("/echo I'm the captain now")
	if IPC.Automaton.IsTweakEnabled("AutoQueue") == false then IPC.Automaton.SetTweakState("AutoQueue", true) end
end
if IPC.Automaton.IsTweakEnabled("EnhancedDutyStartEnd") == false and itworksonmymachine == 1  then IPC.Automaton.SetTweakState("EnhancedDutyStartEnd", true) end

if itworksonmymachine == 0 then
	if IPC.Automaton.IsTweakEnabled("AutoQueue") == true then IPC.Automaton.SetTweakState("AutoQueue", false) end
	yield("/echo it does not in fact work on my machine - we gonna use AD to queue i guess")
end

function force_rotation()
	if bm_preset == "none" then
		yield("/bmrai setpresetname Deactivate") --turn off bm rotation
		yield("/rotation Auto")
	end

	if bm_preset ~= "none" then
		yield("/bmrai setpresetname "..bm_preset)
		yield("/bmrai followtarget on")
		yield("/bmrai follow Slot1")
		yield("/rotation Cancel") --turn off RSR in case it is on
	end
	
	yield("/bmrai on")
end

force_rotation()
--decide if we are going to bailout - logic stolen from Ritsuko <3
function leaveDuty()
    yield("/ad stop")
    while IsInZone(1044) do
        if IsAddonVisible("SelectYesno") then
            --yield("/click SelectYesno Yes")
			yield("/callback SelectYesno true 0")
        else
            yield("/leaveduty")
        end
        yield("/wait 2")
    end
    return
end

while 1 == 1 do
	yield("/wait 2") --the big wait. run the entire fucking script every 2 seconds
	checking_the_duct_tape = checking_the_duct_tape + 1
	
if IPC.Automaton.IsTweakEnabled("AutoQueue") == false and Svc.Condition[34] == false and (duty_counter > 0 or decucounter > 0) and imthecaptainnow == 1 then
	yield("/echo Turning ->ON<- Auto Queue -> It was off for some reason")
	IPC.Automaton.SetTweakState("AutoQueue", true)
end

--safe check ifs
if Player.Available then
if type(Svc.Condition[34]) == "boolean" and type(Svc.Condition[26]) == "boolean" and type(Svc.Condition[4]) == "boolean" then
--
	if imthecaptainnow == 1 and duty_counter > 98 and decucounter < 1 then
		if  itworksonmymachine == 1 then
			if IPC.Automaton.IsTweakEnabled("AutoQueue") == true then
				IPC.Automaton.SetTweakState("AutoQueue", false)
				yield("/echo Turning ->OFF<- Auto Queue -> Please wait till we switch to Decumana")
			end
			if Svc.Condition[34] == false and decucounter == 0 then
				ChooseAndClickDuty(decuID)
				if IPC.Automaton.IsTweakEnabled("AutoQueue") == false then
					yield("/echo Turning ->ON<- Auto Queue -> Please wait till we switch to Decumana")
					IPC.Automaton.SetTweakState("AutoQueue", true)
				end
				yield("/echo Firing up Decumana")
				yield("/wait 2")
				yield("/dutyfinder")
			end
		end
		if  itworksonmymachine == 0 then
			yield("/echo Firing up Decumana")
			yield("/ad stop")
			yield("/wait 0.5")
			yield("/ad queue Porta Decumana")
		end
	end
	
	if imthecaptainnow == 1 and duty_counter < 2 then
		if  itworksonmymachine == 1 then
			if IPC.Automaton.IsTweakEnabled("AutoQueue") == true then
				IPC.Automaton.SetTweakState("AutoQueue", false)
				yield("/echo Turning ->OFF<- Auto Queue -> Daily reset has occurred. we will be resuming Praetorium")
			end
			if Svc.Condition[34] == false then
				ChooseAndClickDuty(praeID)
				if IPC.Automaton.IsTweakEnabled("AutoQueue") == false then
					yield("/echo Turning ->ON<- Auto Queue -> Daily reset has occurred. we will be resuming Praetorium")
					IPC.Automaton.SetTweakState("AutoQueue", true)
				end
				yield("/echo Firing up Praetorium")
				yield("/wait 2")
				yield("/dutyfinder")
			end
		end
		if  itworksonmymachine == 0 then
			yield("/echo Firing up Praetorium")
			yield("/ad stop")
			yield("/wait 0.5")
			yield("/ad queue The Praetorium")
		end
	end
	
	if Svc.Condition[34] == true and Svc.Condition[26] == true then
		yield("/rotation auto")
	end

	--decide if we are going to bailout - logic stolen from Ritsuko <3
	zoneleft = GetContentTimeLeft()
	if type(zoneleft) == "number" and zoneleft > 100 then
		if zoneleft > maxzone then
			maxzone = zoneleft
			--force_rotation() --refresh the rotationtype when we do this
		end
		inprae = maxzone - zoneleft
		if inprae > hardened_sock and Svc.Condition[26] == false then
			yield("/echo We bailed from duty -> "..duty_counter)
			NavRebuild()
			while not NavIsReady() do
				yield("/wait 1")
			end
			leaveDuty()
		end
	end

	if Svc.Condition[34] == false then yield("/callback SelectYesno true 0") end	--is there some bullshit and yesalready was disabled outside of the duty? 
	maxzone = 0--reset the timer for inside prae

	--Food check!
	feedme, feedmeitem  = food_deleter(feedme,feedmeitem,echo_level,feedmesearch)
	
	--do we need to need npc repairs? check INSIDE duty
	if NeedsRepair(tornclothes) and tornclothes > -1 and GetItemCount(1) > 4999 and Svc.Condition[34] == true and IPC.Automaton.IsTweakEnabled("AutoQueue") == true then
		IPC.Automaton.SetTweakState("AutoQueue", false)
	end
	
	--Do we need repairs? only check outside of duty.
	--check every 0.3 seconds 8 times so total looop is 2.4 seconds
	goat = 0
	while goat < 9 and Svc.Condition[34] == false do
		goat = goat + 1
		yield("/wait 0.3")
		if Svc.Condition[34] == false then
			--SELF REPAIR
			local minicounter = 0
			if GetItemCount(ducttape) > 0 then
				if NeedsRepair(99) then
					yield("/wait 10")
					while not IsAddonVisible("Repair") do
					  yield("/generalaction repair")
					  yield("/wait 1")
					  minicounter = minicounter + 1
					  if minicounter > 20 then
						minicounter = 0
						break
					  end
					end
					yield("/callback Repair true 0")
					yield("/wait 0.1")
					if IsAddonVisible("SelectYesno") then
					  yield("/callback SelectYesno true 0")
					  yield("/wait 1")
					end
					while Svc.Condition[39] do yield("/wait 1")
					yield("/wait 1")
					yield("/callback Repair true -1")
					  minicounter = minicounter + 1
					  if minicounter > 20 then
						minicounter = 0
						break
					  end
					end
				end
			end
			--JUST OUTSIDE THE INN REPAIR
			if NeedsRepair(tornclothes) and tornclothes > -1 and GetItemCount(1) > 4999 and Svc.Condition[34] == false and Svc.Condition[56] == false then --only do this outside of a duty yo
				goatcounter = 0
				yield("/wait 0.7") --since we have a 0.3 in the main while loop for repair
				if imthecaptainnow == 0 then
					someone_took_the_duct_tape = someone_took_the_duct_tape + 1
				end
				if (imthecaptainnow == 0 and someone_took_the_duct_tape > 10) or (imthecaptainnow == 1 and IPC.Automaton.IsTweakEnabled("AutoQueue") == false) then --we've been outside of prae for 20+ seconds or we are the party leader and autoqueue is disabled
					yield("/ad repair")
					tornclothes = 99 --force party member repairs. we may not get another chance!
					while NeedsRepair(tornclothes) and goatcounter < 3600 do
						yield("/wait 0.1")
						goatcounter = goatcounter + 1
					end
				end
				if imthecaptainnow == 1 then
					yield("/wait 120") --wait an extra two minutes if we were the party leader in case other players have some weird path for repair + return going on.
					IPC.Automaton.SetTweakState("AutoQueue", true)
				end
				yield("/ad stop")
			end
		end
	end
	--end safe check one
	end
	end
	--
	--safe check ifs part 2
	if Player.Available then
		if type(Svc.Condition[34]) == "boolean" and type(Svc.Condition[26]) == "boolean" and type(Svc.Condition[4]) == "boolean" then
		--

		--check if we are stuck somewhere.
		--first ensure we are in the duty and not in combat

		--1044 is prae we only need this there atm
			if Player.Available then

			if Svc.Condition[34] == true and Svc.Condition[26] == false and Svc.ClientState.TerritoryType == 1044 then
				entitty = 0

				while Entity.GetEntityByName(GetCharacterName(false)).CurrentHp == 0 do
					yield("/echo We died........counting to 5 (3 sec per) then we resetting to entrance..."..entitty.."/5")
					yield("/wait 3")
					entitty = entitty + 1
					if Svc.Condition[26] == false then entitty = entitty + 1 end --speed things up if we aren't in combat
					if entitty > 5 then --accept the respawn immediately if we aren't in combat :~(
						yield("/callback SelectYesno true 0")
						yield("/ad stop")
						yield("/wait 10")
						yield("/ad start")
						yield("/rotation auto")
					end
				end
				
				if Entity.Target and Entity.Target.Name then
					goatfucker = Entity.Target.Name or "goatfucker"
					if (goatfucker == "Nero tol Scaeva" or goatfucker == "Gaius van Baelsar" or goatfucker == "Phantom Gaius" or goatfucker == "Mark II magitek colossus") and Svc.Condition[26] == true then
						yield("/vnav stop")
						if echo_level < 2 then yield("/echo Target in combat condition 26 -> "..goatfucker) end
					end
				end
			end
			if Svc.Condition[34] == true and Svc.Condition[26] == false then
				if GetContentTimeLeft() < 7179 and GetContentTimeLeft() > 0 then --this way it doesn't count towards reset while we are at entrance
					if math.abs(x1 - EntityPlayerPositionX()) < 3 and math.abs(y1 - EntityPlayerPositionY()) < 3 and math.abs(z1 - EntityPlayerPositionZ()) < 3 then
						if echo_level < 4 then yield("/echo We havent moved very much something is up -> "..jigglecounter.."/"..maxjiggle.." cycles to return!") end
						jigglecounter = jigglecounter + 1
					end
				end
				yield("/rotation auto")
				if jigglecounter > maxjiggle and Svc.ClientState.TerritoryType == 1044 then --we stuck for 30+ seconds somewhere in praetorium
					if echo_level < 4 then yield("/echo attempting to restart AD and hope for the best") end
					jigglecounter = 0
					yield("/ad stop")
					yield("/wait 2")
					yield("/return")
					yield("/wait 1")
					yield("/callback SelectYesno true 0")
					yield("/wait 12")
					yield("/ad start")
					yield("/wait 2")
				end
			end

			end
			
			if Svc.Condition[34] == true and Svc.Condition[26] == false then
				equip_counter = equip_counter + 1
				if equip_counter > 50 and finickyclothes == 1 then 
					yield("/equiprecommended")
					yield("/wait 0.5")
					equip_counter = 0
				end
			end

			if Svc.Condition[4] == false and Svc.Condition[26] == true then
				jigglecounter = 0
				if Entity.Target and Entity.Target.Name then
					if type(GetTargetName()) ~= "string" then
						yield("/rotation auto")
						yield("/wait 0.5")
					end
				end
			end
			
			if Svc.Condition[34] == true then
				x1 = EntityPlayerPositionX()
				y1 = EntityPlayerPositionY()
				z1 = EntityPlayerPositionZ()
			end

			stopcuckingme = stopcuckingme + 1
			--autoqueue at the end because its least important thing
			--can we queue for decu? - in any case we can start counting praes for now.
			if type(Svc.ClientState.TerritoryType) == "number" then
				zonecheck = Svc.ClientState.TerritoryType
				if not (zonecheck == 1044 or zonecheck == 1048) then
					entered_duty = 0
				end
				if (zonecheck == 1044 or zonecheck == 1048) and entered_duty == 0 then
					entered_duty = 1
					if (duty_counter < 20 and zonecheck ~= 1048) or zonecheck == 1044 or (zonecheck == 1048 and duty_counter > 98) and IPC.Automaton.IsTweakEnabled("AutoQueue") == true then --don't count yesterday's last decumana in the counter!
						duty_counter = duty_counter + 1
					end
					if duty_counter > 98 and IPC.Automaton.IsTweakEnabled("AutoQueue") == true and zonecheck == 1048 then
						decucounter = decucounter + 1
					end
					if debug_counter == 0 then
						if echo_level < 5 then yield("/echo Duty # -> "..duty_counter.."/99 Praetorium -> "..decucounter.."/? Decumana") end
					end
					if debug_counter > 0 then
						if echo_level < 5 then yield("/echo This is duty # -> "..duty_counter.." Runs since last crash -> "..(duty_counter-debug_counter)) end
					end
					
				end
			end
			if os.date("!*t").hour > 6 and os.date("!*t").hour < 8 and duty_counter > 20 then --theres no way we can do 20 prae in 1 hour so this should cover rollover from the previous day
				duty_counter = 0
				decucounter = 0
				if echo_level < 4 then yield("/echo We are starting over the duty counter, we passed daily reset time!") end
			end

			if Svc.Condition[34] == false and imthecaptainnow == 1 then
				yield("/wait 5") --wait a +bit longer if we are outside.
				if Svc.Condition[91] == false then 
					yield("/dutyfinder") --try autoqueue with cbt if we aren't queueing for a duty.
				end
			end
		--safe check ends
		end
	end
---
end