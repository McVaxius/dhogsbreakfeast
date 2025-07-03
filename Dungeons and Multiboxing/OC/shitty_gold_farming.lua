--[[
shitty gold farming in west caves
7.2, 19.4

requires a party of 4 (max) around KL 20

what is intersting is that pathing to name will always path to the first spawn which is up in the corner of hte cave but it will pause to do combat as it goes there
so it will always complete the loop.  this will work until something about snd/dalamud changes in how lists are made of objects haha.
--]]

loadfiyel = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\_functions.lua"
functionsToLoad = loadfile(loadfiyel)
functionsToLoad()

im_a_lazy_fuck = true
goatfuck = "Lesser Cry of Havoc"
jiggletome = 0
feedmeitem = "Mate Cookie<hq>"
feedme = 46003

function checkfood()
	--Food check!
	statoos = GetStatusTimeRemaining(48)
--	if Svc.Condition[26] == false then -- dont eat while fighting it will upset your stomach
		if type(GetItemCount(feedme)) == "number" then
			if GetItemCount(feedme) > 0 and statoos < 300 then --refresh food if we are below 5 minutes left
				yield("/item "..feedmeitem)
			end
		end
--	end
end

while im_a_lazy_fuck == true do
	yield("/wait 0.1")
	floop = 0
	jiggletome = jiggletome + 1
	if GetCharacterCondition(26) then
		yield("/vnav stop")
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
			if jiggletome > 50 then
				--yield("/echo test 2")
				checkfood()
				jiggletome = 0
			end
		end
	end
	while GetCharacterCondition(26) == false do
		yield("/wait 0.1")
		yield("/ac sprint")
		if Entity.Target and Entity.Target.Name then
			--if (Entity.Target.Position.Y - Entity.Player.Position.Y) < 0.1 or Entity.Player.Position.Y > Entity.Target.Position.Y or Entity.Target.DistanceTo < 5 then
			if Entity.Target.DistanceTo < 3 then
				yield("/ac Shield Lob")
			end
		end
		if floop == 0 then
			yield("/target \"Lesser Cry of Havoc\"")
			nemm = "Lesser Cry of Havoc"
		end
		if floop > 0 then
			yield("/target Geshunpest")
			nemm = "Geshunpest"
			floop = 0
			floop = floop + 1
		end
		PathtoName(nemm)
		--PathtoTarget()
	end
end