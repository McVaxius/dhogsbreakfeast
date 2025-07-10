--[[
***********************************************************************************************************************************************
***this should be in the (Automaton) enhance duty/start end as /pcraft run start_gooning, obviously make the script in SND for this to work.***
***********************************************************************************************************************************************

in SND make a script called start_gooning
past this into it
click the lua button
set this to run when entering a duty in automaton enhanced duty start/end
type this or copy paste it into there:

/pcraft run start_gooning

--]]

loadfiyel = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\_functions.lua"
functionsToLoad = loadfile(loadfiyel)
functionsToLoad()


--loop wait for is char ready 
while Player.Available == false do
	yield("/echo waiting on player")
	yield("/wait 1")
end

yield("/wait 3")

yield("/mmambo") --change it to something else if you like.

while GetContentTimeLeft() > 7199 and GetContentTimeLeft() > 0 do
	--yield("/echo we are free from the confines of the intro portraits")
	yield("/wait 0.1") -- wait a sec
end

--ok we ran run free now and star the duty

yield("/ad stop")

yield("/wait 1")
yield("/hold W")
yield("/wait 1")
yield("/release W")

--yield("/echo ad start")
yield("/ad start")
yield("/bmrai on")
yield("/vbmai on")
yield("/bmrai on")
--yield("/bmrai followtarget on")
--yield("/bmrai followoutofcombat on")
--/bmrai setpresetname FRENRIDER
yield("/bmrai setpresetname Autoduty Passive")
yield("/rotation auto")
--yield("/echo let's start gooning!")