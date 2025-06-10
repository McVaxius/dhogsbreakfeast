--[[
Does this still work?
--*
flagging this as for followup. since i wanna run maps soon

script to fire up a map and go to it

requires
Pandora -> Auto-Teleport to Map Coords
Pandora -> auto interact + auto chests
Simpletweaks -> Target/Targetting fix
Globetrotter -> automatically get flag for opened map
Something Neeed Doing -> Yes you need this
Rotation Solver -> :D
Boss Mod -> :D
Lazyloot -> optional for "/fulf pass" or whatever you want to do with it
YesAlready -> the first time you decipher a map just add it to your yesalready


How it works.
it will just open any map you might have
grab the flag and get TO the flag
]]

function distance(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx*dx + dy*dy)
end

function WalkTo(x, y, z)
    PathfindAndMoveTo(x, y, z, false)
    while (PathIsRunning() or PathfindInProgress()) do
        yield("/wait 0.5")
    end
end

local function safewait()
    repeat 
        yield("/wait 0.5")
        yield("/echo Are we ready? (backup check)")
    until IsPlayerAvailable()
	yield("/wait 1")
end
function ZoneTransition()
	repeat 
		yield("/wait 0.5")
		yield("/echo Casting TP")
	until not IsPlayerAvailable()
	repeat 
		yield("/wait 0.5")
		yield("/echo Arriving from TP")
	until IsPlayerAvailable()
end

--begin!
--Generic map opener. it will just open whatever appears at top of this list
yield("/gaction decipher")
yield("/wait 1")
yield("/callback SelectIconString true 0")
safewait()

yield("target zone -> "..GetFlagZone())

if GetZoneID() ~= GetFlagZone() then
	--we need to get there!
    yield("/p <flag>")
	--ZoneTransition()  --dont want auto teleport. sometimes it picks an aetheryte i dont agree with 
end

--either we TPed there or we were there already.
--now lets get our butts to the place.  no wait first lets see if we are close enough to the flag already to just waltz over

-- if we are far from the flag (>5 yalm) path to it
tempdist = distance(GetPlayerRawXPos(), GetPlayerRawZPos(), GetFlagXCoord(),GetFlagYCoord())
yield("tempdist -> "..tempdist)
if tempdist > 5 then
	PathfindAndMoveTo(GetFlagXCoord(), GetPlayerRawYPos(), GetFlagYCoord(), false)
end

--pop dig
while GetCharacterCondition(4) do
	yield("/ac dismount")
	yield("/wait 2")
end
yield("/wait 1")
yield("/ac dig")
yield("/wait 7")
	
--target chest
yield("/target chest")
yield("/wait 0.5")
PathfindAndMoveTo(GetObjectRawXPos(GetTargetName()),GetObjectRawYPos(GetTargetName()),GetObjectRawZPos(GetTargetName()), false)
--move to chest

--DONE!