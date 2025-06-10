 --[[
  Description: generic dungeon solver - very rough - just pseudocode for now
  Author: McVaxius
]]

--[[
idea:
its possible to make a kind of generic dungeon solver with navmesh and GetDistanceToObject() to just be able to enter any dungeon and run it in a group or with trust/duty support
it wlil kind of wander around the dungeon and do stuff until it reaches the end and leaves

***Config:
(objectives) have an array with a struct similar to [Instance Name ("Sastasha" etc, and a "all" one as well for "Exit" "Shortcut" etc), objectname (monster name, levername, keyname, shortcut/exit name etc), x,y,z  (if it has values then its going to try to check dist to those]
(chests) make a 2nd list of chest types so it can be configured for chest/nochest for dungeon runs [Instance Name, chestname, use (boolean), x,y,z]
**some general configs
	self repair on/off
	repairpct integer of 1-99 to represent a %
	repairnpc on/off would require standing next to a repair npc
	materia extract on/off
	desynth on/off
	eat specific food = "??"
**duty config
	number of times to run
	duty to run
	more stuff later i have an idea for some kind of planner for running various dungeons to level up jobs etc

***Loop
**every x seconds you do 
	search for distances for objects that exist
		put them into a search results array
		navmesh to the closest objective also still exists
		eat specific food when duration is <4 minutes even during combat
	pause objective-seeking when there is combat and do that since sometimes keys can drop....
	self repair run when not in combat and under repairpct
**Repeat dungeon x times or based on rules/plan
	desynth if we set it for inventory items only
		(pause yesalready for this cuz we might be in a group)
		try to accept duty after finishing in case not group leader
		we can even force config to put items in inventory
			yield("/maincommand Item Settings") --fires up teh char config
			yield("/wait 3")
			yield("/pcall ConfigCharaItem true 18 286 0u") --this turns off armory storage
			--yield("/pcall ConfigCharaItem true 18 286 1 0u") --this turns on armory storage
			yield("/pcall ConfigCharaItem true 0")
			yield("/maincommand Item Settings") --fires off teh char config
	materia extra if we set it for all items
		(pause yesalready for this cuz we might be in a group)
		try to accept duty after finishing in case not group leader
	use repair npc
		(pause yesalready for this cuz we might be in a group)
		try to accept duty after finishing in case not group leader

Plugin Notes:
--Required plugins
--Navmesh (still wip no caching yet), SND (croizat fork), Pandora, Simpletweaks,  RotationSolver
--Simpletweaks -> turn on maincommand
--SND disable SND Targeting
--Pandora set interact distance to 5 dist 5 height
--Pandora enable auto chest opening
--Pandora enable automatic active battle events
--Simpletweaks enable maincommand
--Simpletweaks enable targeting fix
--VBM BEFORE joining or forming group. Click ai mode -> Then click follow. Then form the group.
--Rotation Solver disable disabling of RS on exiting duty
--			OR we can contemplate using count down (e.g. /cd 5) at start of every duty to enable it automatically so it doesnt cast spells while outside.
]]
