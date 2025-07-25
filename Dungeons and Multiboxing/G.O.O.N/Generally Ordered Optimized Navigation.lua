	--[[
	Generally Ordered Optimized Navigation.lua  (thanks for the idea fifi)
	or "Something need Gooning"
	thanks to @Akasha and @Ritsuko for some of the ideas/code

	purpose: help autoduty with farming duties.
	design: it will run 99 prae, and then run decumana until reset time (1 am PDT) and reset the counter and go back to farming prae.

	Plugins/configs (ill update as people realize i forgot instructions)
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

	dfunc.lua exists per the root of the repo instructions. (go read it)

	Yesalready configs (maybe only the first one is needed since the rest are done via callbacks w ya off) also make sure yesalready is on :p ad turns it off sometimes (???)
		"YesNo"
			/Repair all displayed items for.*/
			/Exit.*/
			/Move immediately to sealed area.*/
		"Lists"
			/Retire to an inn room.*/
		"Bothers"
			Duties -> ContentFinderConfirm [x]

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
	for sch in RSR turn off 
	GCD-attack
	Ruin, Ruin II
	GCD-friendly
	adloquim, succor and physick

	for SGE you just turn off the 

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

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
--------EDIT THESE IN THE SND SETTINGS!---------------------------------------------------------------------------------------
--[=====[
[[SND Metadata]]
author: dhogGPT
version: 384
description: Farm mogtomes with your cousins.
plugin_dependencies:
- vnavmesh
- SimpleTweaksPlugin
configs:
  zcross_world:
    default: 0
    description: "Set this to 1 if you are the party leader in a Cross World Party"
    type: int
    min: 0
    max: 1
    required: true
  zduty_counter:
    default: 0
    description: "This is the Prae duty counter. \nSet it to 0 if its the first run of the day \n Daily reset time is 3 am EST or 12am PST"
    type: int
    min: 0
    max: 666
    required: true
  ztornclothes:
    default: 25
    description: "pct to try to repair at\n this is for npc repair.\nParty leader will repair at this pct\nRest of party will go try to repair no matter what (99 pct) if they are outside of duty for >20 seconds"
    type: int
    min: -1
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
    description: "if you set it to none it wont use (v)bm(r) and instead it will use RSR. this is for the ai preset to use."
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
  zpottymouth:
    default: 0
    description: "itemID of a buff pot you want to use\nleave as 0 if you dont want to pot.\npots will be used on\nPraetorium -> First Boss and Gauis\nDecumana -> Start of Both Phases"
    type: int
    required: true
  zpottywords:
    default: "Stale Hot Dog Water"
    description: "The name of the tonic/draught/etc i.e. Gemdraught of Strength III.  call it as you will doesn't affect anything"
    type: string
    required: true
  zquitme:
    default: 9999
    description: "How many runs before quitting"
    type: int
    min: 0
    max: 9999
    required: true
  zquitmeexec:
    default: "/ays m e"
    description: "Command to execute after quitting"
    type: string
    required: true
  ztimedilation:
    default: 2
    description: "how many seconds between loops - this can speed up or slow down alot of operations.. be careful.\nIt's best to have this on small value on party leader, unless they managing npc repair numpties"
    type: float
    min: 0
    max: 10
    required: true
  zwhopot:
    default: 0
    description: "0 = pop pot on gauis , 1 pop pot on phantom gauis"
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
pottymouth = Config.Get("zpottymouth")
pottywords = Config.Get("zpottywords")
quitme = Config.Get("zquitme")
quitmeexec = Config.Get("zquitmeexec")
timedilation = Config.Get("ztimedilation")
whopot = Config.Get("zwhopot")

--you can edit these if you are brave debug/dont-touch-settings-unless-you-know-whats-up
hardened_sock = 1200 		 --bailout from duty in 1200 seconds (20 minutes)
debug_counter = 0 --if this is >0 then subtract from the total duties . useful for checking for crashes just enter in the duty_counter value+1 of the last crash, so if you crashed at duty counter 5, enter in a 6 for this value
maxjiggle = 2/timedilation * 30 --how much default time (# of loops of the script) before we jiggle the char in prae.  this is how based on the 2 second standard and modified by time dilation.
maxres = 2/timedilation * 15
maxjiggle = math.floor(maxjiggle)
maxres = math.floor(maxres)
if maxjiggle ~= 30 then
	yield("/echo Since you have modified the time dilation value -> the maximum time to clean up a wipe is still 30 seconds but the number of ticks are -> "..maxjiggle)
	yield("/echo Since you have modified the time dilation value -> the maximum time to clean up a wipe is still 15 seconds but the number of ticks are -> "..maxres)
end
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
stopcuckingme = 0    --counter for checking whento pop duty
imthecaptainnow = Config.Get("zcross_world") --set this to 1 if this char is the party leader

--dont touch these ones
entered_duty = 0
equip_counter = 0
inprae = 0
maxzone = 0
someone_took_the_duct_tape = 0
checking_the_duct_tape = 0
decucounter = 0
foodsearch = false

if Svc.Party[Svc.Party.PartyLeaderIndex] == nil and Svc.Condition[34] == false then
	yield("/echo You seem to be in a cross world party -> IF YOU ARE THE PARTY LEADER -> please set zcross_world to 1 in config and run G.O.O.N again.")
	yield("/echo You seem to be in a cross world party -> IF YOU ARE THE PARTY LEADER -> please set zcross_world to 1 in config and run G.O.O.N again.")
	yield("/echo You seem to be in a cross world party -> IF YOU ARE THE PARTY LEADER -> please set zcross_world to 1 in config and run G.O.O.N again.")
	yield("/echo You seem to be in a cross world party -> IF YOU ARE THE PARTY LEADER -> please set zcross_world to 1 in config and run G.O.O.N again.")
	yield("/echo You seem to be in a cross world party -> IF YOU ARE THE PARTY LEADER -> please set zcross_world to 1 in config and run G.O.O.N again.")
	yield("/echo You seem to be in a cross world party -> IF YOU ARE THE PARTY LEADER -> please set zcross_world to 1 in config and run G.O.O.N again.")
	yield("/echo You seem to be in a cross world party -> IF YOU ARE THE PARTY LEADER -> please set zcross_world to 1 in config and run G.O.O.N again.")
	yield("/echo You seem to be in a cross world party -> IF YOU ARE THE PARTY LEADER -> please set zcross_world to 1 in config and run G.O.O.N again.")
	yield("/echo You seem to be in a cross world party -> IF YOU ARE THE PARTY LEADER -> please set zcross_world to 1 in config and run G.O.O.N again.")
	yield("/echo You seem to be in a cross world party -> IF YOU ARE THE PARTY LEADER -> please set zcross_world to 1 in config and run G.O.O.N again.")
	yield("/echo You seem to be in a cross world party -> IF YOU ARE THE PARTY LEADER -> please set zcross_world to 1 in config and run G.O.O.N again.")
	yield("/echo You seem to be in a cross world party -> IF YOU ARE THE PARTY LEADER -> please set zcross_world to 1 in config and run G.O.O.N again.")
	yield("/echo You seem to be in a cross world party -> IF YOU ARE THE PARTY LEADER -> please set zcross_world to 1 in config and run G.O.O.N again.")
	imthecaptainnow = 2 + imthecaptainnow
end

if imthecaptainnow ~= 2 then
   if imthecaptainnow == 0 then
	   if Svc.Party[Svc.Party.PartyLeaderIndex].ContentId == Svc.ClientState.LocalContentId then --if we could we the if wheeeeeeeeeeeeeeeeeeeeeeeee
			imthecaptainnow = 1
			yield("/echo I am in fact the captain now.")
			Instances.DutyFinder.IsUnrestrictedParty = true
			Instances.DutyFinder.IsLevelSync = true
		end
	end
	if imthecaptainnow == 3 then
		imthecaptainnow = 1
		yield("/echo I am in fact the captain now.")
		Instances.DutyFinder.IsUnrestrictedParty = true
		Instances.DutyFinder.IsLevelSync = true
	end
end
if imthecaptainnow == 2 then imthecaptainnow = 0 end
if 	imthecaptainnow == 0 then yield("/echo I am NOT the captain.") end

if GetItemCount(pottymouth) == 0 then
	pottymouth = 0
	yield("/echo We are all out of "..pottywords)
end
-----------------------------------------------------------------------------------------------------------------

whichbm = "vbm"
--which bossmod is intalled?
if HasPlugin("BossModReborn") then whichbm = "bmr" end
--these don't actually work reliably the return values not always returning ?!?!
--if IPC.AutoDuty.GetConfig("UsingAlternativeRotationPlugin") == "false" and bm_preset ~= "none" then IPC.AutoDuty.SetConfig("UsingAlternativeRotationPlugin", "true") end
--if IPC.AutoDuty.GetConfig("UsingAlternativeRotationPlugin") == "true" and bm_preset == "none" then IPC.AutoDuty.SetConfig("UsingAlternativeRotationPlugin", "false") end
if bm_preset ~= "none" then IPC.AutoDuty.SetConfig("UsingAlternativeRotationPlugin", "true") end
if bm_preset == "none" then IPC.AutoDuty.SetConfig("UsingAlternativeRotationPlugin", "false") end

--fix bossmod settings so that roles will be properly organized and spread will work more effectively.
IPC.AutoDuty.SetConfig("AutoManageRotationPluginState", "true")
IPC.AutoDuty.SetConfig("AutoManageBossModAISettings", "true")
IPC.AutoDuty.SetConfig("BM_UpdatePresetsAutomatically", "true")
IPC.AutoDuty.SetConfig("maxDistanceToTargetRoleBased", "true")
IPC.AutoDuty.SetConfig("positionalRoleBased", "true")
--because people can't read instructions
if imthecaptainnow == 0 then IPC.AutoDuty.SetConfig("AutoExitDuty", "false") end
if imthecaptainnow == 1 then IPC.AutoDuty.SetConfig("AutoExitDuty", "true") end
IPC.AutoDuty.SetConfig("OnlyExitWhenDutyDone", "true")
IPC.AutoDuty.SetConfig("EnableTerminationActions", "false")
IPC.AutoDuty.SetConfig("Unsynced", "true")

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

--ipc, upc, we all p for c
if imthecaptainnow == 0 and itworksonmymachine == 1 then
	yield("/echo I'm not the captain now")
	if IPC.Automaton.IsTweakEnabled("AutoQueue") == true then IPC.Automaton.SetTweakState("AutoQueue", false) end
end
if imthecaptainnow == 1 and itworksonmymachine == 1 then
	yield("/echo I'm the captain now")
	if IPC.Automaton.IsTweakEnabled("AutoQueue") == false then IPC.Automaton.SetTweakState("AutoQueue", true) end
end

if IPC.Automaton.IsTweakEnabled("EnhancedDutyStartEnd") == true then IPC.Automaton.SetTweakState("EnhancedDutyStartEnd", false) end  --we dont need this if we are handling everything with one script.
--if IPC.Automaton.IsTweakEnabled("EnhancedDutyStartEnd") == false then IPC.Automaton.SetTweakState("EnhancedDutyStartEnd", true) end

if itworksonmymachine == 0 then
	if IPC.Automaton.IsTweakEnabled("AutoQueue") == true then IPC.Automaton.SetTweakState("AutoQueue", false) end
	yield("/echo it does not in fact work on my machine - we gonna use AD to queue i guess")
end

function force_rotation()
	if bm_preset == "none" then
		yield("/"..whichbm.."ai setpresetname AutoDuty Passive") --turn off bm rotation
		yield("/rotation Auto")
	end

	if bm_preset ~= "none" then
		yield("/"..whichbm.."ai setpresetname "..bm_preset)
		yield("/"..whichbm.."ai followtarget on")
		yield("/"..whichbm.."ai follow Slot1")
		yield("/rotation Cancel") --turn off RSR in case it is on
	end
	
	if echo_level < 3 then yield("/"..whichbm.."ai on") end
end

function force_rsr()
	if bm_preset == "none" then
		if timedilation == 2 or timedilation > 2 then yield("/rotation auto") end
		if timedilation < 2 then
			choppedgaming = getRandomNumber(0, 20)
			if timedilation * 10 > choppedgaming then yield("/rotation auto") end
		end
	end
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

OnDutyStartedMessage_0 = 0
OnDutyStartedMessage_1 = 1
OnDutyStartedMessage_2 = 0
OnDutyStartedMessage_3 = 0
start_gooning = 0
stop_gooning = 0

function kjhsdkjh4lka3j2cklh234ljk234cx231lkjaS231JK4H()  --message handler
	if OnDutyStartedMessage_0 == 1 then
		praewake = duty_counter - 99
		yield("/echo Duty # -> 99/99 Praetorium -> "..praewake.." Decumana")
		OnDutyStartedMessage_0 = 0
	end
	if OnDutyStartedMessage_1 == 1 then
		yield("/echo Duty # -> "..duty_counter.."/99 Praetorium -> "..decucounter.." Decumana")
		OnDutyStartedMessage_1 = 0
	end
	if OnDutyStartedMessage_2 == 1 then
		yield("/echo This is duty # -> "..duty_counter.." Runs since last crash -> "..(duty_counter-debug_counter))
		OnDutyStartedMessage_2 = 0
	end
	if OnDutyStartedMessage_3 == 1 then
		yield("/echo We are starting over the duty counter, we passed daily reset time!")
		OnDutyStartedMessage_3 = 0
	end
	if start_gooning == 1 then
		start_gooning = 0
		while Player.Available == false do
			yield("/echo waiting on player")
			yield("/wait 1")
		end
		yield("/wait 3")
		yield("/vnav stop") --stop failed pathing that triggered just now outside (?)
		yield("/mmambo") --change it to something else if you like.

		if Svc.ClientState.TerritoryType == 1044 then --only do this in Prae
			while GetContentTimeLeft() > 7199 and GetContentTimeLeft() > 0 do
				yield("/wait 0.1") -- wait a sec
			end
			yield("/ad stop")
			yield("/wait 1")
			yield("/hold W")
			yield("/wait 1")
			yield("/release W")
			yield("/ad start")
		end

		yield("/"..whichbm.."ai on")
		yield("/"..whichbm.."ai followoutofcombat off")
		yield("/"..whichbm.."ai followtarget off")
		yield("/"..whichbm.."ai setpresetname Autoduty Passive")
		yield("/rotation auto")
		--yield("/echo let's start gooning!")
	end
	if stop_gooning == 1 then
		stop_gooning = 0
		while Svc.Condition[34] == true do
			yield("/ad stop") --without this. your chars will just quit the duty randomly and do WEIRD FUCKING SHIT on duty start
			yield("/wait 1")
			InstancedContent.LeaveCurrentContent()
			yield("/wait 2")
		end
		while IsPlayerAvailable() == false do
			yield("/wait 1")
		end
		yield("/wait 5")
	end
end

--thanks SudoStitch from discord for helping me figure out the trigger events in already running scripts
function OnDutyCompleted()
	stop_gooning = 1
	IPC.vnavmesh.Stop()
end

--thanks SudoStitch from discord for helping me figure out the trigger events in already running scripts
function OnDutyStarted()
	IPC.vnavmesh.Stop()
	--autoqueue at the end because its least important thing
	--can we queue for decu? - in any case we can start counting praes for now.
	--if type(Svc.ClientState.TerritoryType) == "number" then
	duty_counter = duty_counter + 1
	Config.Set("zduty_counter", duty_counter)
	if duty_counter > 98 then
		decucounter = decucounter + 1
	end
	if debug_counter == 0 then
		if echo_level < 5 then
			if duty_counter > 99 then OnDutyStartedMessage_0 = 1 end
			if duty_counter < 100 then OnDutyStartedMessage_1 = 1 end
		end
	end
	if debug_counter > 0 then
		if echo_level < 5 then OnDutyStartedMessage_1 = 1 end
	end
	
	if duty_counter > quitme then
		hehaheohaoehaoehaeohehehehehehehe = 69
	end
	start_gooning = 1
end

hehaheohaoehaoehaeohehehehehehehe = 1

while hehaheohaoehaoehaeohehehehehehehe == 1 do
	kjhsdkjh4lka3j2cklh234ljk234cx231lkjaS231JK4H()  --message handler
	yield("/wait "..timedilation) --the big wait. run the entire fucking script every x seconds
	checking_the_duct_tape = checking_the_duct_tape + 1
	
if IPC.Automaton.IsTweakEnabled("AutoQueue") == false and Svc.Condition[34] == false and (duty_counter > 0 or decucounter > 0) and imthecaptainnow == 1 and itworksonmymachine == 1 then
	if echo_level < 4 then yield("/echo Turning ->ON<- Auto Queue -> It was off for some reason") end
	IPC.Automaton.SetTweakState("AutoQueue", true)
end

--safe check ifs
--DEBUG 	if IsPlayerAvailable() == false then yield("/echo we arent available") end
if IsPlayerAvailable() then
if type(Svc.Condition[34]) == "boolean" and type(Svc.Condition[26]) == "boolean" and type(Svc.Condition[4]) == "boolean" then
--
	if imthecaptainnow == 1 and duty_counter > 98 and decucounter < 1 then
		if  itworksonmymachine == 1 then
			if IPC.Automaton.IsTweakEnabled("AutoQueue") == true then
				IPC.Automaton.SetTweakState("AutoQueue", false)
				yield("/echo Turning ->OFF<- Auto Queue -> Please wait till we switch to Decumana")
			end
			if Svc.Condition[34] == false and decucounter == 0 then
				--entered_duty = 0
				ChooseAndClickDuty(decuID)
				if IPC.Automaton.IsTweakEnabled("AutoQueue") == false then
					yield("/echo Turning ->ON<- Auto Queue -> Please wait till we switch to Decumana")
					IPC.Automaton.SetTweakState("AutoQueue", true)
				end
				if echo_level < 3 then yield("/echo Firing up Decumana") end
				yield("/wait 2")
				yield("/dutyfinder")
			end
		end
	end
	if  itworksonmymachine == 0 and duty_counter > 98 and Svc.Condition[34] == false and imthecaptainnow == 1 then
		if echo_level < 3 then yield("/echo Firing up Decumana") end
		--entered_duty = 0
		yield("/ad stop")
		while IsPlayerAvailable() == false do
			yield("/wait 1")
		end
		yield("/wait 5")
		yield("/ad queu	e The Porta Decumana")
	end
	
	if imthecaptainnow == 1 and duty_counter < 2 then
		if  itworksonmymachine == 1 then
			if IPC.Automaton.IsTweakEnabled("AutoQueue") == true then
				IPC.Automaton.SetTweakState("AutoQueue", false)
				yield("/echo Turning ->OFF<- Auto Queue -> Daily reset has occurred. we will be resuming Praetorium")
			end
			if Svc.Condition[34] == false then
				--entered_duty = 0
				ChooseAndClickDuty(praeID)
				if IPC.Automaton.IsTweakEnabled("AutoQueue") == false then
					yield("/echo Turning ->ON<- Auto Queue -> Daily reset has occurred. we will be resuming Praetorium")
					IPC.Automaton.SetTweakState("AutoQueue", true)
				end
				if echo_level < 3 then yield("/echo Firing up Praetorium") end
				yield("/wait 2")
				yield("/dutyfinder")
			end
		end
	end
	if itworksonmymachine == 0 and duty_counter < 99 and Svc.Condition[34] == false and imthecaptainnow == 1 then
		if echo_level < 3 then yield("/echo Firing up Praetorium") end
		--entered_duty = 0
		yield("/ad stop")
		while IsPlayerAvailable() == false do
			yield("/wait 1")
		end
		yield("/wait 5")
		yield("/ad queue The Praetorium")
	end

	if Svc.Condition[34] == true and Svc.Condition[26] == false then
		if Svc.ClientState.TerritoryType == 1048 then
			yield("/target \"The Ultima Weapon\"")
			yield("/send KEY_1")
		end
	end
	if Svc.Condition[34] == true and Svc.Condition[26] == true then
		force_rsr()
		if Entity.Target and Entity.Target.Name then
			goatfucker = Entity.Target.Name or "goatfucker"
			whopotty = "Gaius van Baelsar"
			if goatfucker == whopotty and Svc.Condition[26] == true then
				if Player.GetJob(GetClassJobId()).IsTank and Entity.Target.HealthPercent > 5 and Entity.Target.HealthPercent < 95 then yield("/ac rampart") end --tank use rampart
			end
			if whopot == 1 then whopotty = "Phantom Gaius" end
			if (goatfucker == whopotty or goatfucker == "Mark II Magitek Colossus") and Svc.Condition[26] == true then --i hypothesize that we can get faster clears with potting on the phantoms. 9:55-10:20 with potting on gauis
				--medicated is status 49
				if pottymouth > 0 and Entity.Target.HealthPercent > 20 and Entity.Target.HealthPercent < 100 then
					pottymouth = pop_pot(pottymouth, pottywords, echo_level) --return the same itemID if we still have pots left
				end
			end
			if goatfucker == "Phantom Gaius" and Svc.Condition[26] == true then
				if Player.GetJob(GetClassJobId()).IsMeleeDPS or Player.GetJob(GetClassJobId()).IsRangedDPS then
					yield("/ac \"limit break\"")
				end
			end
			if goatfucker == "The Ultima Weapon" and Svc.Condition[26] == true then
				--medicated is status 49
				if pottymouth > 0 and Entity.Target.HealthPercent > 80 and Entity.Target.HealthPercent < 100 then
					pottymouth = pop_pot(pottymouth, pottywords, echo_level) --return the same itemID if we still have pots left
				end
				if Entity.Target.HealthPercent > 98 then
					yield("/send KEY_1")
				end	
				if Entity.Target.HealthPercent < 30 then
					if Player.GetJob(GetClassJobId()).IsMeleeDPS or Player.GetJob(GetClassJobId()).IsRangedDPS then
						yield("/ac \"limit break\"")
					end
				end
			end
			if (goatfucker == "Nero tol Scaeva" or goatfucker == "Gaius van Baelsar" or goatfucker == "Phantom Gaius" or goatfucker == "Mark II Magitek Colossus") and Svc.Condition[26] == true then
				if IPC.vnavmesh.IsRunning() then
					yield("/vnav stop")
					if echo_level < 2 then yield("/echo Target in combat condition 26 and we were pathfinding -> "..goatfucker) end
				end
			end
		end
	end

	--decide if we are going to bailout - logic stolen from Ritsuko <3
	zoneleft = GetContentTimeLeft()
	if type(zoneleft) == "number" and zoneleft > 100 then
		if zoneleft > maxzone then
			maxzone = zoneleft
			force_rotation() --refresh the rotationtype when we do this
		end
		inprae = maxzone - zoneleft
		if inprae > hardened_sock and Svc.Condition[26] == false then
			if echo_level < 4 then yield("/echo We bailed from duty -> "..duty_counter) end
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
				if NeedsRepair(99) == false then goat = 666 end
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
			if NeedsRepair(tornclothes) == false and Svc.Condition[34] == false and GetItemCount(ducttape) == 0 then
				xxx = {
				"Otopa Pottopa",
				"Mytesyn",
				"Antoinaut"
				}
				for i=1, #xxx do
					if mydisttoName(xxx[i]) < 50 and mydisttoName(xxx[i]) > 0 then
						PathtoName(xxx[i])
						yield("/target \""..xxx[i].."\"")
						yield("/interact")
						yield("/wait 2")
					end
				end
			end
			if NeedsRepair(tornclothes) and tornclothes > -1 and GetItemCount(1) > 4999 and Svc.Condition[34] == false and Svc.Condition[56] == false then --only do this outside of a duty yo
				goatcounter = 0
				yield("/wait 0.7") --since we have a 0.3 in the main while loop for repair
				if imthecaptainnow == 0 then
					someone_took_the_duct_tape = someone_took_the_duct_tape + 1
				end
				if (imthecaptainnow == 0 and someone_took_the_duct_tape > 10) or (imthecaptainnow == 1 and IPC.Automaton.IsTweakEnabled("AutoQueue") == false) then --we've been outside of prae for 20+ seconds or we are the party leader and autoqueue is disabled
					yield("/ad repair")
					--tornclothes = 99 --force party member repairs. we may not get another chance!
					someone_took_the_duct_tape = 0
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
	if IsPlayerAvailable() then
		if type(Svc.Condition[34]) == "boolean" and type(Svc.Condition[26]) == "boolean" and type(Svc.Condition[4]) == "boolean" then
		--

		--check if we are stuck somewhere.
		--first ensure we are in the duty and not in combat

		--1044 is prae we only need this there atm
			if IsPlayerAvailable() then

			if Svc.Condition[34] == true and Svc.Condition[26] == false and Svc.ClientState.TerritoryType == 1044 then
				entitty = 0
				if Svc.Condition[10] == false then
					yield("/ac sprint")
				end

				while Entity.GetEntityByName(GetCharacterName(false)).CurrentHp == 0 do
					if echo_level < 4 then yield("/echo We died........counting to "..maxres.." then we resetting to entrance..."..entitty.."/"..maxres) end
					yield("/wait 3")
					entitty = entitty + 1
					if Svc.Condition[26] == false then entitty = entitty + 1 end --speed things up if we aren't in combat
					if entitty > maxres then --accept the respawn immediately if we aren't in combat :~(
						yield("/callback SelectYesno true 0")
						yield("/ad stop")
						yield("/wait 10")
						yield("/ad start")
						force_rsr()
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
				force_rsr()
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
						force_rsr()
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

			if Svc.Condition[34] == false and imthecaptainnow == 1 then
				yield("/wait 5") --wait a +bit longer if we are outside.
				if Svc.Condition[91] == false and itworksonmymachine == 1 then 
					yield("/dutyfinder") --try autoqueue with cbt if we aren't queueing for a duty.
				end
			end
		--safe check ends
		end
	end
---
	if os.date("!*t").hour > 6 and os.date("!*t").hour < 8 and duty_counter > 20 then --theres no way we can do 20 prae in 1 hour so this should cover rollover from the previous day
		duty_counter = 0
		Config.Set("zduty_counter", duty_counter)
		decucounter = 0
		if echo_level < 4 then OnDutyStartedMessage_3 = 1 end
	end
end

while Svc.Condition[34] do
	yield("/echo waiting for duty to end....")
	yield("/wait 1")
end
yield("/wait 5")
yield(quitmeexec)