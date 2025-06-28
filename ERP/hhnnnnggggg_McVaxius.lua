--[[
auto passive emotes

if daddy walks by, do the emote, or if basic bitch is nearby do a diff one.

Table format:
name, emote, wait time after emote, repeat interval, distance to react at

REMEMBER NO @server for name


]]--
hhnnngs = {
{"Butcheek Destroyer", "/imperialsalute", 3, 5, 5},
{"Butcheek Enjoyer", "/panic", 4, 5, 5},
{"Uncle Lanscaper", "/sweep", 10, 5, 5}
}


function hhhnnnggG(hhhh, nnnn, gggg, hhhhng, hhhhnng, hhhhnngg) --dist func
	if type(hhhh) ~= "number" then hhhh = 0 end
	if type(nnnn) ~= "number" then nnnn = 0 end
	if type(gggg) ~= "number" then gggg = 0 end
	if type(hhhhng) ~= "number" then hhhhng = 0 end
	if type(hhhhnng) ~= "number" then hhhhnng	= 0 end
	if type(hhhhnngg) ~= "number" then hhhhnngg = 0 end
	hnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnngggg = math.sqrt((hhhhng - hhhh)^2 + (hhhhnng - nnnn)^2 + (hhhhnngg - gggg)^2)
	if type(hnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnngggg) ~= "number" then
		--hnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnngggg = 0
		hnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnngggg = 666660
	end
    return hnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnngggg
end

hhhnnnggg = 1   --while loop activator
HHNNGG = 0 		--counter for repeat interval
HHHHNNGG = 0 	--max repeat interval value

--get the max value in the repeat interval
for hng=1,#hhnnngs do
	if hhnnngs[hng][4] > HHHHNNGG then HHHHNNGG = hhnnngs[hng][4] end
end

while hhhnnnggg == 1 do
	HHNNGG = HHNNGG + 1
	yield("/wait 1") -- we work in seconds
	hnnggg = EntityPlayerPositionX
	hnngggg = EntityPlayerPositionY
	hnnggggg = EntityPlayerPositionZ
	for hng=1,#hhnnngs do
		yield("/wait 0.3") -- this should be safe for cycling between elements of table while calling SND functions
		if HHNNGG > hhnnngs[hng][3] then -- if we are above the repeat interval actually check to see if we should do this
			if hhhnnnggG(hnnggg, hnngggg, hnnggggg, GetObjectRawXPos(hhnnngs[hng][1]), GetObjectRawYPos(hhnnngs[hng][1]), GetObjectRawZPos(hhnnngs[hng][1])) < hhnnngs[hng][5] then
				yield("/target "..hhnnngs[hng][1])
				yield("/wait 0.5")
				yield(hhnnngs[hng][2])
				yield("/echo attempting to do this -> "..hhnnngs[hng][2])
				yield("/wait "..hhnnngs[hng][3])
			end
		end
	end	
	if HHNNGG > HHHHNNGG then HHNNGG = 0 end --reset the counter if we are at the max possible interval
end
