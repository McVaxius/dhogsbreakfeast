--[[
shitty gold farming in west caves
7.2, 19.4

requires a party of 4 (max) around KL 20 - using wrath as the rotation plogon
tank 	dps 	dps 		healer
knight 	thief 	time mage 	bard

i got 1120 gold per hour with no +1 gear. will have some +1 gear soon and will update

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

while im_a_lazy_fuck == true do
	yield("/wait 0.1")
	floop = 0
	jiggletome = jiggletome + 1
	morejiggle = morejiggle + 1
	if morejiggle > 5 then
		yield("/generalaction \"Phantom Action III\"") --counterstance on monk
		morejiggle = 0
	end
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
		while mydistto(-711.080, 115.388, -84.512) > 15 do
			if IPC.vnavmesh.IsRunning() == false then PathfindAndMoveTo(-711.080, 115.388, -84.512, false) end
			if mydistto(-711.080, 115.388, -84.512) < 1 then
				yield("/vnav stop")
			end
			yield("/wait 0.1")
		end
	end
	while GetCharacterCondition(26) == false do
		morejiggle = morejiggle + 1
		if morejiggle > 5 then
			yield("/generalaction \"Phantom Action III\"") --counterstance on monk
			morejiggle = 0
		end
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
			yield("/send TAB")
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
			yield("/send TAB")
			--entity:Interact()
			floop = floop + 1
			if Entity.Target and Entity.Target.Name then WaitForTarget(20,2) end
			lob()
			if statoos == 0 then
				PathtoTarget(5)
			end
		end
		if statoos == 0 and farreacher > 15 then --every 15 sec we will shif tif we stuck
			PathtoName(nemm)
			farreacher = 0
		end
		if statoos > 0 then
			yield("/vnav stop")
		end
	end
end