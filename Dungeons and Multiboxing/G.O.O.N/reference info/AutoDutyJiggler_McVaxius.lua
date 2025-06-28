--jiggle it a bit and make it work for autoduty
--purpose. AD gets stuck randomly for me.  This solves that. 
--instructions:
--none. it works on my machine (tm)

--if you actually reading this. please note this file is obselete just here mostly as a code example. this is not useful for anything. please look at GOON and START_GOON thats all you need.

wheahehhahehhaheohuahoeuhaosdflkj = 1

while wheahehhahehhaheohuahoeuhaosdflkj == 1 do
	x1 = EntityPlayerPositionX
	y1 = EntityPlayerPositionY
	z1 = EntityPlayerPositionZ
	yield("/wait 20")
	if Svc.Condition[34] == true then
		yield("/vnav stop")
	end
	if (x1 - EntityPlayerPositionX) == 0 and (y1 - EntityPlayerPositionY) == 0 and (z1 - EntityPlayerPositionZ) == 0 then
		yield("/echo We havent moved in 20 seconds. its time to slap the machine or jiggle it a bit")
		yield("/callback SelectYesno true 0")
		yield("/wait 1")
		yield("/callback Repair true 0")
		yield("/wait 1")
		yield("/callback Repair true 1")
		yield("/wait 3")
		yield("/callback SelectYesno true 0")
		yield("/wait 1")
		while not NavIsReady() do
			yield("/echo waiting on navmesh to finish rebuilding the mesh")
			yield("/wait 1")
		end
		--[[
		if Svc.Condition[34] == false then
			yield("/ad stop")
			yield("/wait 2")
			yield("/ad start")
			yield("/wait 2")
		end
		--]]
	end
end