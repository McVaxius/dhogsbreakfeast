--[[
shitty gold farming in west caves
7.2, 19.4

requires a party of 4 (max) around KL 20 - using wrath as the rotation plogon
tank 	dps 	dps 		healer
knight 	thief 	time mage 	cannoneer

i am getting closer to 1300 gold per hour with +1 gear on three slots per char
w 0 it was around 1120
w 1 it was around 1150
w 2 it was around 1200
w 3 it was around 1300
w 4 it was around ?
w 5 i didn't test im done for now.

its shit but it can reach 1k gold per hour with party of 4 "real actual players"

what is intersting is that pathing to name will always path to the first spawn which is up in the corner of hte cave but it will pause to do combat as it goes there
so it will always complete the loop.  this will work until something about snd/dalamud changes in how lists are made of objects haha.

some notes
RSR is better than BM for healer rotations
Wrath and RSR both seem to have more phantom stuff than BM will test today
--]]

loadfiyel = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\_functions.lua"
functionsToLoad = loadfile(loadfiyel)
functionsToLoad()

im_a_lazy_fuck = true
goatfuck = "Lesser Cry of Havoc"
jiggletome = 0
morejiggle = 0
--feedmeitem = "Mate Cookie<hq>"
feedme = 46003
statoos = 0
nemm = "hehe"
farreacher = 0

function checkfood()
	--Food check!
	statoos = GetStatusTimeRemaining(48)
--	if Svc.Condition[26] == false then -- dont eat while fighting it will upset your stomach
		if type(GetItemCount(feedme)) == "number" then
			if GetItemCount(feedme) > 0 and statoos < 300 then --refresh food if we are below 5 minutes left
				--yield("/item "..feedmeitem)
				yield("/wait 0.1")
				Inventory.GetInventoryItem(tonumber(feedme)):Use()
			end
		end
--	end
end

function lob()
		if Entity.Target and Entity.Target.Name then
			--if Entity.Target.DistanceTo < 30 then
				yield("/ac Shield Lob")
			--end
			--yield("/echo dist to "..nemm.." -> "..Entity.Target.DistanceTo)
		end
end

directions = {
"W","A","S","D"
}
directioncounter = 1

while im_a_lazy_fuck == true do
	yield("/wait 0.1")
	floop = 0
	jiggletome = jiggletome + 1
	--[[
	morejiggle = morejiggle + 1
	if morejiggle > 5 then
		yield("/generalaction \"Phantom Action III\"") --counterstance on monk
		morejiggle = 0
	end
	--]]
	if GetCharacterCondition(26) == false then
		if jiggletome > 50 then
			--yield("/echo test 2")
			checkfood()
			jiggletome = 0
		end
	end
	if GetCharacterCondition(26) then
		--check Y heights. if they aren't within 0.1 yalms then lets press back a bit
		if Entity.Target and Entity.Target.Name then
			if (Entity.Target.Position.Y - Entity.Player.Position.Y) > 0.5 and jiggletome > 50 then
				yield("/hold S")
				yield("/wait 0.5")
				yield("/release S")
				jiggletome = 0
				--yield("/echo test 1")
				checkfood()
			end
		end
		--safe spot is -711.080, 115.388, -84.512
		dontfightwithBM = 0
		while mydistto(-711.080, 115.388, -84.512) > 10 and dontfightwithBM < 10 do
			dontfightwithBM = dontfightwithBM + 0.05
			if mydistto(-711.080, 115.388, -84.512) > 10 and IPC.vnavmesh.IsRunning() == false then PathfindAndMoveTo(-711.080, 115.388, -84.512, false) end
			if mydistto(-711.080, 115.388, -84.512) < 10 then
				dontfightwithBM = dontfightwithBM + 1
			end
			if mydistto(-711.080, 115.388, -84.512) < 5 and dontfightwithBM < 10 then
				dontfightwithBM = dontfightwithBM + 1
				yield("/vnav stop")
				zoop = 0
				while Svc.Condition[26] and zoop < 100 do
					yield("/wait 0.1")
					zoop = zoop + 1
					zoop = 0
				end
				if dontfightwithBM > 5 then
					while Svc.Condition[26] and zoop < 100 do
						yield("/wait 0.1")
						zoop = zoop + 1
						zoop = 0
					end
				end
			end
			yield("/wait 0.1")
		end
	end
	while GetCharacterCondition(26) == false do
		--[[morejiggle = morejiggle + 1
		if morejiggle > 5 then
			yield("/generalaction \"Phantom Action III\"") --counterstance on monk
			morejiggle = 0
		end--]]
		farreacher = farreacher + 1
		yield("/wait 0.1")
		yield("/ac sprint")
		statoos = GetStatusTimeRemaining(44) --brink of death (50%) --dont vnav if we recently died we need to chill until it goes away
		if statoos == 0 then
			statoos = GetStatusTimeRemaining(43) --weakness from first death 25%
		end
		if Entity.Target and Entity.Target.Name then
			--if (Entity.Target.Position.Y - Entity.Player.Position.Y) < 0.1 or Entity.Player.Position.Y > Entity.Target.Position.Y or Entity.Target.DistanceTo < 5 then
		end
		if floop > 0 then
			--yield("/target \"Crescent Geshunpest\"")
			nemm = "Crescent Geshunpest"
			local entity = closest_thing(nemm)
			entity:SetAsTarget()
			--[[
			directioncounter = directioncounter + 1
			yield("/hold "..directions[directioncounter])
			yield("/wait 0.1")
			yield("/release "..directions[directioncounter])
			yield("/send END")--]]
			yield("/send TAB")
			if directioncounter == 4 then directioncounter = 1 end
			--closest_thing(nemm)
			floop = 0
			if Entity.Target and Entity.Target.Name then WaitForTarget(20,2) end
			lob()
			--[[if statoos == 0 then
				--PathtoName(nemm)
				PathtoTarget(5)
			end--]]
		end
		if floop == 0 then
			--yield("/target \"Lesser Cry of Havoc\"")
			nemm = "Lesser Cry of Havoc"
			--closest_thing(nemm)
			local entity = closest_thing(nemm)
			entity:SetAsTarget()
			directioncounter = directioncounter + 1
			--[[
			directioncounter = directioncounter + 1
			yield("/hold "..directions[directioncounter])
			yield("/wait 0.1")
			yield("/release "..directions[directioncounter])
			yield("/send END")--]]
			yield("/send TAB")
			if directioncounter == 4 then directioncounter = 1 end
			--entity:Interact()
			floop = floop + 1
			if Entity.Target and Entity.Target.Name then WaitForTarget(20,2) end
			lob()
			if statoos == 0 then
				PathtoTarget(5)
			end
		end
		if statoos == 0 and farreacher > 15 then --every 15 sec we will shif tif we stuck
			PathtoName(nemm)  --this seems to be a source of grief and displeasure
			farreacher = 0
			yield("/wait 3")
			yield("/vnav stop")
		end
		if statoos > 0 then
			yield("/vnav stop")
		end
	end
end