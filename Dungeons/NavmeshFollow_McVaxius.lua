 --[[
  Description: Navmesh follow. works alot better and i actually tested it. you will have to click rebuild navmesh yourself
  Author: McVaxius
  Link: https://discord.com/channels/1162031769403543643/1162799234874093661/1194784208749608991
]]

--[[
contemplate these for next update:
          "- Added GetTargetRawXPos()" +
          "- Added GetTargetRawYPos()" +
          "- Added GetTargetRawZPos()" +
          "- Added GetDistanceToTarget()" +
          "- Added GetFlagXCoord()" +
          "- Added GetFlagYCoord()");
]]

--configuration notes:
--***install vnavmesh (veyn) might still be a compile it yourself situation
--pull and compile from -> https://github.com/awgil/ffxiv_navmesh/
--you can't run this script without it
--
--***install bossmod  (veyn)
--add to dalamud -> https://puni.sh/api/repository/veyn
--	BEFORE joining group
--	set it to ai mode on
--	click follow to turn it on
--  this way it won't try to follow the group leader
--
--***install rotationsolver (croizat)
--add to dalamud -> https://puni.sh/api/repository/croizat
--	uncheck autoration disable on area change
--  configure a key to turn it on or make a hotkey and turn it on
--
--***install Something Need Doing (croizat)
--add to dalamud -> https://puni.sh/api/repository/croizat
--you can't run this script without it
--

--some things missing:
--*actually doing something other than spamming echo when the deest is super far or target is defaulted to 1,1,1 (i think thats what the getraw from snd does?)
--*looking for interaction points and navmeshing to them if they are within some yalms
--*maybe when not in combat check for interaction points that are close by and on same z plane within tolerance of like 3 yalms then path to it?
--*optionally filter the entire thing with some area number white list in an array :p 

--navmesh test
local char_snake = 2 -- character slot 2, slot 1 is us
local snake_deest = 8 -- distance max to the specific char so we can decide when to start moving
local enemy_deest = 3 -- distance max to the specific enemy to beeline to the enemy using navmesh. set this to a higher value than snake_deest if you want it to never follow the enemy.
local meh_deest = 40 -- distance max to char_snake where we stop trying to follow or do anything. maybe look for interaction points or exits?
local enemeh_deest = 5 -- distance max to battle target

yield("/vnavmesh stop")
yield("/wait 1")
yield("/vnavmesh stop")
--or flyto

--placeholder for target location
local currentLocX = 1
local currentLocY = 1
local currentLocZ = 1

--our current location
local mecurrentLocX = GetPlayerRawXPos(tostring(1))
local mecurrentLocY = GetPlayerRawYPos(tostring(1))
local mecurrentLocZ = GetPlayerRawZPos(tostring(1))

--our current area
local we_are_in = 666
local we_were_in = 666

--declaring distance var
local dist_between_points = 500

--how long to lock on for. we only do it once every lockon_wait seconds. this will interfere less with VBM dodging mechanics
local dont_lockon = 0
local lockon_wait = 5

local neverstop = true

local function distance(x1, y1, z1, x2, y2, z2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
end

local function setdeest()
	if currentLocX and currentLocY and currentLocZ and mecurrentLocX and mecurrentLocY and mecurrentLocZ then
		dist_between_points = distance(currentLocX, currentLocY, currentLocZ, mecurrentLocX, mecurrentLocY, mecurrentLocZ)
		-- dist_between_points will contain the distance between the two points
		yield("/echo Distance between char_snake and point 1: " .. dist_between_points)
	else
		yield("/echo Failed to retrieve coordinates for one or both points.")
		dist_between_points = 500 -- default value haha
	end
end

while neverstop do
	currentLocX = GetPlayerRawXPos(tostring(char_snake))
	currentLocY = GetPlayerRawYPos(tostring(char_snake))
	currentLocZ = GetPlayerRawZPos(tostring(char_snake))
	mecurrentLocX = GetPlayerRawXPos(tostring(1))
	mecurrentLocY = GetPlayerRawYPos(tostring(1))
	mecurrentLocZ = GetPlayerRawZPos(tostring(1))
	yield("/targetenemy") --this will trigger RS to do stuff.

	--test dist to the intended party leader
	setdeest()
	if dist_between_points > snake_deest and dist_between_points < meh_deest then
            yield("/vnavmesh moveto "..currentLocX.." "..currentLocY.." "..currentLocZ)
			--yield("/echo vnavmesh moveto "..math.ceil(currentLocX).." "..math.ceil(currentLocY).." "..math.ceil(currentLocZ))
    end

	--test distance to enemy if we are in combat
	dont_lockon = dont_lockon + 1
	if GetCharacterCondition(26)==true then --if we are in combat
		currentLocX = GetPlayerRawXPos(GetTargetName())
		currentLocY = GetPlayerRawYPos(GetTargetName())
		currentLocZ = GetPlayerRawZPos(GetTargetName())
		setdeest()
		if dist_between_points > enemy_deest and dist_between_points < enemeh_deest and dont_lockon > lockon_wait then
			--yield("/vnavmesh moveto " .. math.ceil(currentLocX) .. " " .. math.ceil(currentLocY) .. " " .. math.ceil(currentLocZ))
			--yield("/echo vnavmesh moveto "..math.ceil(currentLocX).." "..math.ceil(currentLocY).." "..math.ceil(currentLocZ))
			yield("/lockon on")
			yield("/automove on")
			yield("/wait 1") --on/off movements			
		end
		if dist_between_points < (enemy_deest + 1) then
			yield("/lockon off")
			yield("/automove off")
			dont_lockon = 0
		end
	end
	--if we are > meh_deest
		--check for interaction points or something
	yield("/wait 1") -- default wait between "tics"
	
	--this part will be deprecated soon once there is some kind of autobuilding
	--check if we chagned areas and rebuild navmesh or just wait as normal
	we_are_in = GetZoneID() --where are we?
	if type(we_are_in) ~= "number" then
		we_are_in = 666 --its an invalid type so lets just default it and wait 10 seconds
		yield("/echo invalid type for area waiting 10 seconds")
		yield("/wait 10")
	end
	if we_are_in ~= we_were_in then
		yield("/vnavmesh stop")
		yield("/wait 1")
		yield("/vnavmesh rebuild")
		yield("/echo we changed areas. rebuild the navmesh!")
		--yield("/wait 10")
	end
	
	we_were_in = we_are_in --record this as we are in this area now
end