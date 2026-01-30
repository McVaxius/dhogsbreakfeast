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

    --dungeons
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
		if cleanrand == 0 and zonetest ~= 130 then
			yield("/qst stop")
			yield("/echo escaping from potential stuck in overworld")
			yield("/wait 1")
			yield("/qst start")
		end
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
		if zonetest == 130 and Svc.Condition[34] == false then
--		if zonetest == 131 and Svc.Condition[34] == false then
			cleanrand = getRandomNumber(0, 99) --faild attempt to fix the "in combat" but not really issue
			if cleanrand == 0 and Svc.Condition[34] == false then
				yield("/qst stop")
				yield("/echo escaping from potential stuck in uldah")
				yield("/wait 1")
				yield("/qst start")
			end
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
    if Svc.Condition[34] ~= nil and Svc.Condition[34] == false then
		zonetest = Svc.ClientState.TerritoryType
        --debug
        --yield("/echo GetPlayerRawXPos() -> "..GetPlayerRawXPos())
        --yield("/echo              hehex -> "..hehex)
        --yield("/echo math.abs(GetPlayerRawXPos() - hehex) -> "..math.abs(GetPlayerRawXPos() - hehex))
        --yield("/echo math.abs(GetPlayerRawYPos() - hehey) -> "..math.abs(GetPlayerRawYPos() - hehey))
        --yield("/echo math.abs(GetPlayerRawZPos() - hehez) -> "..math.abs(GetPlayerRawZPos() - hehez))
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
--    if Player.Job.Level > 18 then --make sure we not near training dummy stuff near start of msq
--        yield("/send KEY_1")
--    end
    yield("/wait 0.5")
end