--[[
CONFIGUJATION:
put the sea pickles into chocobo, unless you have tons of them

you need simpletweaks /target fix

you need to turn off 2 sections of SND in config
/target
/waitaddon

Yes already configs -> try to add all of the menus to get to the important bits, for list tab

UNDER LISTS -> brackets means target specific dont just blindly copy paste teh whoel thing in
UNDER LISTS -> brackets means target specific dont just blindly copy paste teh whoel thing in
UNDER LISTS -> brackets means target specific dont just blindly copy paste teh whoel thing in
UNDER LISTS -> brackets means target specific dont just blindly copy paste teh whoel thing in
UNDER LISTS -> brackets means target specific dont just blindly copy paste teh whoel thing in
I repeat. do not enter these into "YesNo"
non indented text is folder names not needed but nice to have

Costa Del Sol Leves (section name)
    /Fieldcraft.*/
    /A Recipe for Disaster.*/
    /Just Call Me Late for Dinner.*/
    /Kitchen.*/
    /Sounds Fishy.*/
    (Guildleves)
    (F'abodji) Yes
Quarrymill
    (Daca Jinjahl) /Food Chain Reaction.*/
    (Daca Jinjahl) Yes
    (Daca Jinjahl) Blind Ambition
    (Daca Jinjahl) The Long and the Shortcrust


--]]
--beter code for handling leves thanks to mootykins  https://discord.com/channels/1001823907193552978/1196163718216679514/1275953553088708700
--[[ 
local known_quests = {
    ["A Recipe for Disaster"] = 778,
    ["Just Call Me Late for Dinner"] = 779,
    ["Kitchen Nightmares No More"] = 780,
    ["The Blue Period"] = 781
}

function checkingu_node()
    local quest_name = GetNodeText("GuildLeve", 11, 40, 4)
    yield("/echo Node Text -> "..quest_name)
    local quest_id = known_quests[quest_name]
    if quest_id then
        yield("/callback JournalDetail true 3 " .. quest_id)
    end
end
--]]

function visland_stop_moving()
 yield("/equipguud")
 yield("/equiprecommended")
 yield("/character")
 yield("/callback Character true 15")
 yield("/wait 0.5")
 yield("/callback SelectYesno true 0")
 yield("/character")
 yield("/callback Character true 15")
 yield("/callback SelectYesno true 0")
 yield("/wait 3")
 muuv = 1
 muuvX = GetPlayerRawXPos()
 muuvY = GetPlayerRawYPos()
 muuvZ = GetPlayerRawZPos()
 while muuv == 1 do
	yield("/wait 1")
	if muuvX == GetPlayerRawXPos() and muuvY == GetPlayerRawYPos() and muuvZ == GetPlayerRawZPos() then
		muuv = 0
	end
	muuvX = GetPlayerRawXPos()
	muuvY = GetPlayerRawYPos()
	muuvZ = GetPlayerRawZPos()
 end
 yield("/echo movement stopped safely - script proceeding to next bit")
 yield("/visland stop")
 yield("/vnavmesh stop")
 yield("/wait 3")
end

yield("/vnavmesh moveto 453.40570068359 17.503484725952 475.26538085938")
visland_stop_moving()

fartingGoat = 1

function turnin()
	hehehe = 1
	yield("/echo Quest list -> "..GetNodeText("_ToDoList", 8, 13))
	--check first two quests to see if they are the turnin ones. we can finally ignore blue menu now
	while hehehe == 1 do
		hehehe = 0
		floob = GetNodeText("_ToDoList", 8, 13)
		if floob == "A Recipe for Disaster" or floob == "Just Call Me Late for Dinner" or floob == "Kitchen Nightmares No More" then
			hehehe = 1
		end
		floob = GetNodeText("_ToDoList", 9, 13)
		if floob == "A Recipe for Disaster" or floob == "Just Call Me Late for Dinner" or floob == "Kitchen Nightmares No More" then
			hehehe = 1
		end
		floob = GetNodeText("_ToDoList", 8, 13)
		yield("/target F'abodji")
		yield("/wait 0.5")
		yield("/interact")
		yield("/wait 1")
	end

	yield("/send ESCAPE")
	yield("/wait 0.5")
end

function fartwait()
	yield("/send ESCAPE")
	yield("/wait 0.5")
	yield("/send ESCAPE")
	yield("/wait 0.5")
	yield("/send ESCAPE")
	yield("/wait 2")
end

function checkingu_node()
	yield("/echo Node Text -> "..GetNodeText("GuildLeve", 11, 40, 4))
	if GetNodeText("GuildLeve", 11, 40, 4) == "A Recipe for Disaster" then
		yield("/callback JournalDetail true 3 778")
	end
	if GetNodeText("GuildLeve", 11, 40, 4) == "Just Call Me Late for Dinner" then
		yield("/callback JournalDetail true 3 779")
	end
	if GetNodeText("GuildLeve", 11, 40, 4) == "Kitchen Nightmares No More" then
		yield("/callback JournalDetail true 3 780")
	end
	if GetNodeText("GuildLeve", 11, 40, 4) == "The Blue Period" then
		yield("/callback JournalDetail true 3 781")
	end
end

while fartingGoat == 1 do
	yield("/target Nahctahr")
	yield("/wait 0.5")
	yield("/interact")
	yield("/wait 3")
	if GetNodeText("GuildLeve", 5, 2) == "0" then
		yield("/echo itsa done")
		yield("/pcraft stop")
	end
	weew = 8
	oldnode = "wow amazing"
	while weew > 0 do
		if oldnode == GetNodeText("GuildLeve", 11, 40, 4) then
			weew = 0
		end
		checkingu_node()
		weew = weew - 1
		yield("/wait 1")
		if IsAddonVisible("GuildLeve") == false then
			weeew = 0
			fartwait()
		end
		oldnode = GetNodeText("GuildLeve", 11, 40, 4)
	end
	turnin()
end