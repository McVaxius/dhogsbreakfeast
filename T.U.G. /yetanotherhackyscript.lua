--bad questionable helper
require("dfunc")
hehe = "heehee"
yield("/echo ensuring Pandora is off")
yield("/xldisableplugin Pandora") --this will break QST in any case so keep it OFF

hehex = GetPlayerRawXPos()
hehey = GetPlayerRawYPos()
hehez = GetPlayerRawZPos()
togglecounter = 0
arr_list = { --list of zoneIDs for arr dungeons < level 47ish
    --semi hard solo duties MSQ
    306,--Level 27 - Big Trouble in Little Ala Mhigo
    302,--Level 40 - The Heretic among Us
    304,--Level 44 - Notorious Biggs

    --jobs/classes
    319,--Level 30 - whm Unlock seer folly

    --	
    1036,--sastasha
    1037,--tam tara deep croft
    1038,--copperbell
    1039,--totorak
    1040,--haukke manor
    1041,--brayflox
    1042,--stone vigil

    --trials
    1045, --ifrit
    1046, --titan
    1047  --garuda
}

q_w_kx = { --the list of bullshit quests we get stuck on because of slay x/y
22, --way of hte conjuror kill various
3854, --eggs over queesy kill chigoes
376, --thou shalt not tresspass kill qirin
253, --way of the gladiator
311, --way of the marauder
329, --the perfect swamp
12313 --nothing
}

togglecounter = 0

while hehe == "heehee" do
    yield("/bmrai on")
    if Svc.Condition[34] ~= nil and Svc.Condition[34] == false then --not in duty
        zonetest = Svc.ClientState.TerritoryType
		if zonetest == 130 then
			--yield("/echo we in the glitchy place dist to bad spot -> "..mydistto(-21,10,-41))
			if mydistto(-21,10,-41) < 5 then
				yield("/vnav moveto -14 10 -38")
				yield("/echo damn uldah glitch")
				yield("/wait 10")
			end
		end
		cleanrand = getRandomNumber(0, 99) --faild attempt to fix the "in combat" but not really issue
		zonetestZ = 0 --var to test before resetting
		--if Player.Job.Level > 8 then zonetestZ = 1 end
		if zonetest == 130 then zonetestZ = 1 end --uldah
		if zonetest == 131 then zonetestZ = 1 end --uldah
		if zonetest == 128 then zonetestZ = 1 end --limsa
		if zonetest == 129 then zonetestZ = 1 end --limsa
		if zonetest == 133 then zonetestZ = 1 end --grid
		if zonetest == 132 then zonetestZ = 1 end --grid
		if Quests.IsQuestAccepted(448) and zonetest == 132 and cleanrand == 0 and IPC.vnavmesh.IsRunning() == false and mydistto(228, 2, 38) < 20 then --festive endevours in gridania finisher
			yield("/echo maybe we can tp back to grid now")
			yield("/tp grid")
			yield("/qst stop")
			yield("/wait 10")
			yield("/qst start")
			yield("/vnav moveto 25.9 -8 132")
			yield("/wait 100")
		end
		--test the types of Quest
		--yield("/echo cleanrand -> "..cleanrand)
		if zonetest == 145 and mydistto(-332, -22, 432) < 5 then  --we just finished the halatali unlock and need to continue the msq
			yield("/tp horizon")
		end
		--START HALATALI RECOVERY
		if Quests.IsQuestComplete(697) then -- this is the code for halatali
			if zonetest == 140 and Player.Job.Level > 22 and mydistto(72, 45, -221) < 25 then --get to the waking sands
				yield("/vnav moveto -483, 17, -386")
				yield("/wait 20")
			end
			if zonetest == 140 and Player.Job.Level > 22 and mydistto(-483, 17, -386) < 5 then
				yield("/target entrance")
				yield("/wait 2")
				yield("/send NUMPAD5")
				yield("/interact")
				yield("/send NUMPAD0")
				yield("/wait 2")
			end
			if zonetest == 212 and Player.Job.Level > 22 then
				yield("/target solar")
				yield("/wait 2")
				yield("/interact")
				yield("/send NUMPAD0")
				yield("/wait 20")
			end
		end
		--END HALATALI RECOVERY
		if zonetestZ == 0 and cleanrand == 0 then
		--if zonetestZ == 0 and cleanrand < 20 then
			zonetestZ = 1
			yield("/echo testing to see if we on the right missiont to reset qst")
			for i=1,#q_w_kx do
				if Quests.IsQuestAccepted(i) then zonetestZ = 0 end
				if Quests.IsQuestAccepted(618) then
                    if mydistto(-340, -37, 241) < 5 then
						yield("/echo trying to interact with ripe corpse")
						yield("/qst stop")
						yield("/send NUMPAD0")
						yield("/wait 2")
						--yield("/send NUMPAD5")
						--yield("/wait 2")
						yield("/interact")
						yield("/wait 1")
						yield("/interact")
						yield("/wait 1")
						yield("/interact")
						yield("/wait 1")
						yield("/target Ripe")
					end
				end
			end
			--yield("/echo q completed -> "..tostring(Quests.IsQuestComplete(i)))
			--yield("/echo q accepted -> "..tostring(Quests.IsQuestAccepted(i)))
			if zonetestZ == 0 then yield("/echo wrong mission") end
		end
		if cleanrand == 0 and zonetestZ == 0 then
			yield("/qst stop")
			yield("/echo escaping from potential stuck in overworld")
			yield("/wait 1")
			yield("/qst start")
		end
        togglecounter = togglecounter + 1
        if math.abs(GetPlayerRawXPos() - hehex) < 0.5 and math.abs(GetPlayerRawYPos() - hehey) < 0.5 and math.abs(GetPlayerRawZPos() - hehez) < 0.5 then
            if togglecounter > 15 then
                yield("/echo restarting QST")
                yield("/qst start")
                yield("/qst reload")
                togglecounter = 0
            end
            
            if Svc.Condition[26] == false then
                --yield("/send KEY_1")
                yield("/ac Tomahawk")
                yield("/ac Aero")
            end
--            if togglecounter > 60 and Svc.Condition[26] == false then
            if togglecounter > 20 then
                yield("/send KEY_1")
                --yield("/mount")
                yield("/equipguud")
                yield("/equiprecommended")
            end
            
            if togglecounter > 20 or Svc.Condition[26] == true then            
                yield("/bmrai setpresetname FRENRIDER")
                yield("/rotation cancel")
                togglecounter = 0
            end

        end
        if math.abs(GetPlayerRawXPos() - hehex) > 0.5 then
            togglecounter = 0
        end
        
        hehex = GetPlayerRawXPos()
        hehey = GetPlayerRawYPos()
        hehez = GetPlayerRawZPos()
	end

    if Svc.Condition[34] ~= nil and Svc.Condition[34] == true then --are in duty
        togglecounter = togglecounter + 1
        arr_l_47 = 0
        zonetest = Svc.ClientState.TerritoryType
        for i=1,#arr_list do
            if zonetest == arr_list[i] then arr_l_47 = 1 end
        end
        if arr_l_47 == 1 and togglecounter > 20 then
            yield("/bmrai setpresetname Autoduty Passive")
            yield("/rotation auto")
            togglecounter = 0
        end
        if arr_l_47 == 0 and togglecounter > 20 then
            yield("/bmrai setpresetname Questionable - Quest Battles")
            yield("/rotation cancel")
            togglecounter = 0
        end
        if zonetest == 307 then
           yield("/rotation cancel")
           yield("/bmrai off")
           darget("Large Boulder")
           yield("/ac Tomahawk")
           yield("/ac Aero")
        end
        --[[ actualyl this doesnt work
        if zonetest == 266 then --level 15 thaumaturge
            zdarget = "Momo's Urn"
            if Svc.Condition(26) == true then
                yield("/vnav stop")
            end
            if _distance(EntityPlayerPositionX(), EntityPlayerPositionY(), EntityPlayerPositionZ(), GetObjectRawXPos(zdarget),GetObjectRawYPos(zdarget),GetObjectRawZPos(zdarget)) > 5 and Svc.Condition(26) == false then
                yield("/vnav moveto "..GetObjectRawXPos(zdarget).." "..GetObjectRawYPos(zdarget).." "..GetObjectRawZPos(zdarget))
            end            
        end
        --]]
        if zonetest == 301 then --Level 38 - In the Eyes of Gods and Men -- need to target the rosary
            darget("Draconian Rosary")
            zdarget = "Draconian Rosary"
            yield("/interact")
            if _distance(EntityPlayerPositionX(), EntityPlayerPositionY(), EntityPlayerPositionZ(), GetObjectRawXPos(zdarget),GetObjectRawYPos(zdarget),GetObjectRawZPos(zdarget)) > 5 then
                yield("/vnav moveto "..GetObjectRawXPos(zdarget).." "..GetObjectRawYPos(zdarget).." "..GetObjectRawZPos(zdarget))
            end
        end
    end
--    if Player.Job.Level > 18 then --make sure we not near training dummy stuff near start of msq
--        yield("/send KEY_1")
--    end
    yield("/wait 0.5")
end